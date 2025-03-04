/*
Copyright 2023 The KubeAGI Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package langchainwrap

import (
	"context"
	"errors"
	"fmt"
	"os"

	langchainllms "github.com/tmc/langchaingo/llms"
	"github.com/tmc/langchaingo/llms/openai"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/apimachinery/pkg/runtime"
	"k8s.io/apimachinery/pkg/runtime/schema"
	"k8s.io/apimachinery/pkg/types"
	"k8s.io/client-go/dynamic"
	"sigs.k8s.io/controller-runtime/pkg/client"

	"github.com/kubeagi/arcadia/api/base/v1alpha1"
	"github.com/kubeagi/arcadia/pkg/config"
	"github.com/kubeagi/arcadia/pkg/llms"
	"github.com/kubeagi/arcadia/pkg/llms/zhipuai"
	"github.com/kubeagi/arcadia/pkg/utils"
)

const (
	GatewayUseExternalURLEnv = "GATEWAY_USE_EXTERNAL_URL"
)

func GetLangchainLLM(ctx context.Context, llm *v1alpha1.LLM, c client.Client, cli dynamic.Interface, model string) (langchainllms.LLM, error) {
	if err := utils.ValidateClient(c, cli); err != nil {
		return nil, err
	}
	switch llm.Spec.Provider.GetType() {
	case v1alpha1.ProviderType3rdParty:
		apiKey, err := llm.AuthAPIKey(ctx, c, cli)
		if err != nil {
			return nil, err
		}
		switch llm.Spec.Type {
		case llms.ZhiPuAI:
			return zhipuai.NewZhiPuAILLM(apiKey, zhipuai.WithRetryTimes(3)), nil
		case llms.OpenAI:
			// When apitype is OpenAI,there are two possible sources:
			// 1. From official OpenAI
			// 2. From kubeagi which provides OpenAI compatible apis
			// Both only provides 1 embedding model,so get the 1st one should be fine if the model is not specified.
			if model == "" {
				models := llm.GetModelList()
				if len(models) == 0 {
					return nil, errors.New("no valid models for this LLM")
				}
				model = models[0]
			}
			return openai.New(openai.WithToken(apiKey), openai.WithBaseURL(llm.Get3rdPartyLLMBaseURL()), openai.WithModel(model))
		}
	case v1alpha1.ProviderTypeWorker:
		gateway, err := config.GetGateway(ctx, c, cli)
		if err != nil {
			return nil, err
		}
		if gateway == nil {
			return nil, fmt.Errorf("global config gateway not found")
		}
		workerRef := llm.Spec.Worker
		if workerRef == nil {
			return nil, fmt.Errorf("embedder.spec.worker not defined")
		}
		worker := &v1alpha1.Worker{}
		if c != nil {
			if err := c.Get(ctx, types.NamespacedName{Namespace: workerRef.GetNamespace(llm.GetNamespace()), Name: workerRef.Name}, worker); err != nil {
				return nil, err
			}
		} else {
			obj, err := cli.Resource(schema.GroupVersionResource{Group: v1alpha1.Group, Version: v1alpha1.Version, Resource: "workers"}).
				Namespace(workerRef.GetNamespace(llm.GetNamespace())).Get(ctx, workerRef.Name, metav1.GetOptions{})
			if err != nil {
				return nil, err
			}
			err = runtime.DefaultUnstructuredConverter.FromUnstructured(obj.UnstructuredContent(), worker)
			if err != nil {
				return nil, err
			}
		}
		modelRef := worker.Spec.Model
		if modelRef == nil {
			return nil, fmt.Errorf("worker.spec.model not defined")
		}
		modelName := worker.MakeRegistrationModelName()
		// Configure witch gateway url to use, use apiserver by default
		// can use external gateway URL when do local debug by setting GATEWAY_USE_EXTERNAL_URL env to true
		gatewayURL := gateway.APIServer
		if os.Getenv(GatewayUseExternalURLEnv) == "true" {
			gatewayURL = gateway.ExternalAPIServer
		}
		return openai.New(openai.WithModel(modelName), openai.WithBaseURL(gatewayURL), openai.WithToken("fake"))
	}
	return nil, fmt.Errorf("unknown provider type")
}
