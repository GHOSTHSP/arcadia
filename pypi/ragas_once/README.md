# Ragas CLI

A one-step Ragas cli tool to evaluate QCAG testsets generated by RAG apps. (Q = Question, C = Contexts, A = Answer, G = Ground_truth)

## Install with pip

```bash
pip install ragas langchain==0.0.354
```

then:

```bash
pip install ragas_once
```

## Arguments

- `--model`: Specifies the model to use for evaluation.
    - Default value is "gpt-3.5-turbo". Langchain compatible.
- `--apibase`: Specifies the base URL for the API.
    - Default value is "https://api.openai.com/v1".
- `--apikey`: Specifies the API key to authenticate requests. 
    - Not required if using psuedo-openai API server, e.g. vLLM, Fastchat, etc.
- `--embeddings`: Specifies the Huggingface embeddings model to use for evaluation. 
    - Embeddings will run **locally**.
    - Will use OpenAI embeddings if not set.
    - Better set if using psuedo-openai API server.
- `--metrics`: Specifies the metrics to use for evaluation.
    - Will use Ragas default metrics if not set.
    - Default metrics: `["answer_relevancy", "context_precision", "faithfulness", "context_recall", "context_relevancy"]`
    - Other metrics: `"answer_similarity", "answer_correctness"`
- `--dataset`: Specifies the path to the dataset for evaluation.    
    - Dataset format must meet RAGAS requirements.
    - Will use fiqa dataset as demo if not set.

## Usage

### Fiqa dataset demo:

```bash
python3 -m ragas_once.cli --apikey "YOUR_OPENAI_API_KEY"
```

### Evaluate with GPT-4 and `BAAI/bge-small-en` embeddings

The huggingface embeddings will run locally, so **Make sure your machine works and have [sentence-transformers](https://pypi.org/project/sentence-transformers/) installed:**

```bash
pip install sentence-transformers
```
Then run:

```bash
python3 -m ragas_once.cli --model "gpt-4" --apikey "YOUR_OPENAI_API_KEY" --embeddings "BAAI/bge-small-en" --dataset "path/to/dataset.csv"
```

### Prepare Dataset

See [**Ragas documentation**](https://docs.ragas.io/en/stable/howtos/applications/data_preparation.html)