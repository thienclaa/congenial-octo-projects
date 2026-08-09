# AI Labeling Pipeline

## 1. Overview

The AI labeling layer converts customer conversations from unstructured text into structured business attributes that can be stored and analyzed downstream.

The overall workflow is:

```text
Customer Conversation
        ↓
Data Preparation
        ↓
Instruction Formatting
        ↓
Llama 3.1 8B Instruct
        ↓
LoRA / QLoRA Fine-Tuning
        ↓
Pharmacy V3
        ↓
GGUF Conversion
        ↓
Q4_K_M Quantization
        ↓
Ollama
        ↓
Structured Classification
        ↓
SQL Server
```

The production implementation is not included in this repository because the underlying dataset, trained model, and inference implementation are proprietary.

---

# 2. Business Objective

The primary objective of the AI layer is to automatically classify customer conversations into business-relevant categories and identify their sentiment.

Instead of requiring customer-service teams or analysts to manually inspect large volumes of conversations, the model generates structured attributes that can subsequently be aggregated in SQL Server and Power BI.

The AI layer therefore acts as a bridge between:

```text
Unstructured Customer Conversations
                ↓
          Structured Data
```

---

# 3. Training Data

The model was trained using pharmacy-domain customer conversation examples.

The documented training workflow used approximately:

```text
5,000 examples
```

The dataset was formatted for instruction-based supervised fine-tuning.

Conceptually:

```text
Training Example
       │
       ├── Customer conversation
       │
       ├── Business classification
       │
       └── Sentiment
```

The original production dataset is not included in the repository.

No customer-level information or production conversations are published.

---

# 4. Instruction-Based Training Format

The training examples are converted into an instruction format suitable for an instruction-following LLM.

Conceptually:

```text
System Instruction
        +
Customer Conversation
        +
Expected Classification
        ↓
Training Example
```

A simplified public example is:

```text
Instruction:

Classify the following customer conversation
according to the available business labels and
determine its sentiment.

Conversation:

"Đơn hàng của tôi vẫn chưa được giao."

Expected Output:

Labels: Khiếu nại giao hàng
Sentiment: Negative
```

The example is synthetic and is not taken from production data.

---

# 5. Base Model

The base model used for the labeling task is:

**Llama 3.1 8B Instruct**

The model was selected as the foundation for domain-specific fine-tuning rather than training a language model from scratch.

This allows the project to leverage an existing instruction-following model while adapting its behavior to pharmacy customer-service conversations.

---

# 6. Fine-Tuning Approach

The training workflow uses parameter-efficient fine-tuning.

The primary approach is:

```text
Llama 3.1 8B
      ↓
LoRA / QLoRA
      ↓
Pharmacy-domain adaptation
```

Instead of updating the complete base model, LoRA adapters are trained on the target task.

This reduces the number of trainable parameters and makes fine-tuning more practical for a large language model.

---

# 7. Training Configuration

The documented training workflow includes:

| Component             | Configuration          |
| --------------------- | ---------------------- |
| Base model            | Llama 3.1 8B Instruct  |
| Fine-tuning           | LoRA / QLoRA           |
| Framework             | Unsloth                |
| Training type         | Supervised Fine-Tuning |
| Sequence length       | 2,048 tokens           |
| Dataset size          | ~5,000 examples        |
| Training steps        | 500                    |
| Optimizer             | 8-bit AdamW            |
| Precision             | BF16-capable training  |
| Gradient accumulation | Enabled                |

These values describe the documented training configuration and should not be interpreted as a complete production training specification.

---

# 8. Training Process

The training workflow can be represented as:

```text
Raw Labeled Conversations
           │
           ▼
      Data Cleaning
           │
           ▼
   Instruction Formatting
           │
           ▼
      Tokenization
           │
           ▼
   LoRA / QLoRA Training
           │
           ▼
     Pharmacy V3 Model
```

The goal is to adapt the model to the vocabulary, business categories, and conversational patterns specific to the pharmacy customer-service domain.

---

# 9. Why Fine-Tuning?

A general-purpose LLM can understand customer conversations, but the business requires consistent classification according to a predefined domain taxonomy.

Fine-tuning provides domain adaptation for:

* Pharmacy terminology
* Customer-service language
* Business-specific intents
* Complaint categories
* Operational terminology
* Sentiment patterns
* Vietnamese customer conversations

The objective is therefore not to make the model a better general-purpose chatbot.

The objective is to make it a more consistent **customer conversation classification model**.

---

# 10. Pharmacy V3

The fine-tuned model is referred to as **Pharmacy V3**.

Conceptually:

```text
Llama 3.1 8B Instruct
           │
           ▼
Pharmacy Customer Chat Dataset
           │
           ▼
      Fine-Tuning
           │
           ▼
       Pharmacy V3
```

Pharmacy V3 serves as the AI labeling component of the broader analytics platform.

---

# 11. Model Conversion

After fine-tuning, the model is prepared for local inference.

The documented model preparation workflow includes:

```text
Fine-Tuned Model
       │
       ▼
   GGUF FP16
       │
       ▼
  Q4_K_M Quantization
       │
       ▼
     Ollama
```

The quantized model is intended to reduce memory requirements and make local inference more practical.

---

# 12. Ollama Deployment

Ollama is used as the local model runtime.

Its role is to provide an inference interface for the fine-tuned model.

The architecture is:

```text
Application / Inference Script
             │
             ▼
          Ollama
             │
             ▼
      Pharmacy V3 Model
             │
             ▼
       Model Response
```

Ollama is therefore an **inference layer**, not the analytical database.

This distinction is important:

```text
Ollama
  = Model execution

SQL Server
  = Persistent analytical storage

Power BI
  = Semantic modeling and analytics
```

---

# 13. Structured AI Output

The model is designed to return structured classification results.

A simplified example:

```json
{
  "labels": [
    "Khiếu nại giao hàng"
  ],
  "sentiment": "Negative"
}
```

The structured output allows downstream processes to store the result as analytical fields rather than treating the model response as free-form text.

---

# 14. Labeling Dimensions

The AI output focuses primarily on two analytical dimensions.

## Business Label

The label represents the primary business intent or topic of the conversation.

Examples include:

```text
Product inquiry
Ordering
Delivery
Complaint
Service feedback
Promotion
Other
```

The actual production taxonomy is proprietary and is intentionally generalized in this repository.

---

## Sentiment

The sentiment classification contains four categories:

```text
Positive
Negative
Neutral
Mixed
```

These values can subsequently be aggregated by:

* Date
* Channel
* Customer
* Session
* Business category
* Label

---

# 15. AI Output to SQL Server

The AI inference result is passed to the data pipeline and persisted in SQL Server.

The conceptual flow is:

```text
Conversation
      │
      ▼
    Ollama
      │
      ▼
AI Classification
      │
      ▼
Data Processing
      │
      ▼
SQL Server
      │
      ▼
Fact Chat Labeling
```

This persistence layer is important because the AI runtime itself should not be treated as the system of record.

Once stored in SQL Server, the AI output becomes available for:

* Historical analysis
* Aggregation
* KPI calculation
* Data quality checks
* Power BI reporting

---

# 16. AI and Analytics Separation

The solution separates model inference from analytical consumption.

```text
                 AI DOMAIN
                    │
       ┌────────────┴────────────┐
       │                         │
Conversation                Classification
       │                         │
       └────────────┬────────────┘
                    ▼
               SQL Server
                    │
                    ▼
              Power BI Model
                    │
                    ▼
               Business KPI
```

This allows the model to focus on classification while the analytical layer focuses on business interpretation.

---

# 17. Example End-to-End Prediction

A synthetic example:

### Input

```text
Customer:
"Chị đặt thuốc hôm qua nhưng đơn vẫn chưa giao,
em kiểm tra giúp chị với."
```

### AI inference

```text
Pharmacy V3
     ↓
Ollama
```

### Output

```json
{
  "labels": [
    "Khiếu nại giao hàng"
  ],
  "sentiment": "Negative"
}
```

### SQL representation

Conceptually:

```text
session_id     → synthetic_session_001
label          → Khiếu nại giao hàng
sentiment      → Negative
```

### Power BI

The record can contribute to metrics such as:

```text
Negative Sessions
Negative Conversation Rate
Delivery Complaint Volume
```

This example is synthetic and is provided only to demonstrate the pipeline.

---

# 18. Model Evaluation

A production-grade implementation should evaluate the classifier using a held-out dataset rather than relying only on training loss.

Recommended evaluation metrics include:

* Accuracy
* Precision
* Recall
* F1-score
* Confusion matrix
* Per-label performance
* Sentiment classification performance

For multi-class business labeling, per-class performance is particularly important because overall accuracy can hide poor performance on less frequent categories.

The public repository does not publish proprietary production evaluation results.

---

# 19. Data Quality Considerations

AI-generated labels should be treated as analytical outputs that require monitoring.

Potential issues include:

* Ambiguous customer intent
* Multiple intents in one conversation
* Mixed sentiment
* Long conversations
* Vietnamese language variation
* Spelling errors
* Informal customer language
* New business scenarios not represented in the training data

A robust production implementation should therefore include mechanisms for monitoring classification quality and identifying uncertain or previously unseen patterns.

---

# 20. Human-in-the-Loop Extension

A potential future architecture is:

```text
Customer Conversation
        ↓
       LLM
        ↓
   Classification
        │
   ┌────┴─────┐
   │          │
High       Low-confidence
confidence    │
   │          ▼
   │      Human Review
   │          │
   └────┬─────┘
        ▼
   SQL Server
        ↓
   Power BI
```

Human-reviewed records can potentially be reused as additional training data for future model versions.

---

# 21. Model Versioning

The model should be treated as a versioned component of the data platform.

For example:

```text
Pharmacy V1
     ↓
Pharmacy V2
     ↓
Pharmacy V3
     ↓
Future Versions
```

Each version should ideally track:

* Training dataset version
* Label taxonomy version
* Base model
* Fine-tuning configuration
* Evaluation results
* Quantization format
* Deployment configuration

This makes changes in model behavior easier to audit and reproduce.

---

# 22. Confidentiality

The following production assets are intentionally excluded:

* Training dataset
* Customer conversations
* Fine-tuned model weights
* GGUF production model
* Production Ollama configuration
* Production inference scripts
* Internal API endpoints
* Production database schemas
* Credentials
* Internal business taxonomy

This repository documents the **technical approach and architecture**, not the proprietary implementation itself.

---

# 23. Summary

The AI labeling pipeline transforms pharmacy customer conversations into structured business signals:

```text
Customer Conversation
        ↓
Llama 3.1 8B
        ↓
LoRA Fine-Tuning
        ↓
Pharmacy V3
        ↓
Ollama
        ↓
Structured Labels + Sentiment
        ↓
SQL Server
        ↓
Power BI
        ↓
Business Analytics
```

The key architectural principle is the separation between **AI inference**, **data storage**, and **business analytics**.

This allows the LLM to operate as a specialized classification component while SQL Server and Power BI provide the persistence, semantic modeling, and analytical capabilities required by the business.
