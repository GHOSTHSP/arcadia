/*
Copyright 2023 KubeAGI.

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

package openai

// Chat is a chat completion response returned by model.
type Chat struct {
	ID      string   `json:"id"`      // A unique identifier for the chat completion
	Object  string   `json:"object"`  // The object type, which is always chat.completion
	Created int      `json:"created"` // A unix timestamp of when the chat completion was created.
	Model   string   `json:"model"`   // The model used for the chat completion.
	Choices []Choice `json:"choices"` // A list of chat completion choices. Can be more than one if n is greater than 1.
	Usage   Usage    `json:"usage"`   // Usage statistics of the completion request.
}

// ChatStream is a streamed chunk of a chat completion returned by model.
type ChatStream struct {
	ID      string         `json:"id"`      // A unique identifier for the chat completion.
	Object  string         `json:"object"`  // The object type, which is always chat.completion
	Created int            `json:"created"` // A unix timestamp of when the chat completion was created.
	Model   string         `json:"model"`   // The model used for the chat completion.
	Choices []ChoiceStream `json:"choices"` // A list of chat completion choices. Can be more than one if n is greater than 1.
}

type Choice struct {
	Index        int     `json:"index"`         // The index of the choice in the list of choices.
	Message      Message `json:"message"`       // The completion message generated by the model.
	FinishReason string  `json:"finish_reason"` // The reason the model stopped generating tokens. This will be stop if the model hit a natural stop point or a provided stop sequence, `length` if the maximum number of tokens specified in the request was reached, or `function_call` if the model called a function.
}

type ChoiceStream struct {
	Index        int    `json:"index"`
	Delta        Delta  `json:"delta"`
	FinishReason string `json:"finish_reason"`
}

// Message is a chat completion message generated by the model.
type Message struct {
	Role         string       `json:"role"`
	Content      string       `json:"content,omitempty"`
	FunctionCall FunctionCall `json:"function_call,omitempty"`
}

// FunctionCall is used when a message is calling a function generated by openAI model.
type FunctionCall struct {
	Name      string `json:"name"`      // Name of the function.
	Arguments string `json:"arguments"` // JSON format of the arguments.
}

// Usage is the usage statistics of the completion request.
type Usage struct {
	PromptTokens     int `json:"prompt_tokens"`
	CompletionTokens int `json:"completion_tokens"`
	TotalTokens      int `json:"total_tokens"`
}

// Delta is A chat completion delta generated by streamed model responses.
type Delta struct {
	Role         string       `json:"role"`
	Content      string       `json:"content,omitempty"`
	FunctionCall FunctionCall `json:"function_call,omitempty"`
}
