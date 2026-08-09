# System Architecture

## 1. Architecture Overview

The Customer Chat Intelligence Platform is designed as an end-to-end analytics pipeline that transforms unstructured customer conversations into structured business intelligence.

The architecture consists of five major layers:

```text
Customer Conversations
        ↓
AI Labeling
        ↓
SQL Server
        ↓
Power BI Semantic Model
        ↓
Business Analytics
```

The AI inference layer and analytical layer are intentionally separated.

The AI model is responsible for extracting structured signals from conversations, while SQL Server and Power BI are responsible for storing, modeling, aggregating, and analyzing those signals.

---

## 2. High-Level Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                    CUSTOMER DATA                            │
│                                                             │
│  Customer Conversations / Sessions / Operational Events     │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                 CONVERSATION PROCESSING                     │
│                                                             │
│  Session preparation                                        │
│  Conversation formatting                                    │
│  Input preparation for AI inference                         │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                       AI LAYER                              │
│                                                             │
│  Pharmacy V3                                                │
│  Llama 3.1 8B Instruct                                      │
│  LoRA / QLoRA fine-tuning                                   │
│                                                             │
│                       Ollama                                │
│                  Local model inference                      │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               │ AI-generated attributes
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     SQL SERVER                              │
│                                                             │
│  ┌─────────────────────┐    ┌──────────────────────────┐   │
│  │ Fact Conversation   │    │ Fact Chat Labeling       │   │
│  │                     │    │                          │   │
│  │ Session information │    │ AI classification        │   │
│  │ Conversation data   │    │ Labels                   │   │
│  │ Operational fields  │    │ Sentiment                │   │
│  └──────────┬──────────┘    └────────────┬─────────────┘   │
│             │                            │                 │
│             └────────────┬───────────────┘                 │
│                          │                                 │
│                    Supporting Data                         │
└──────────────────────────┬──────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                     POWER BI                                │
│                                                             │
│  Data Integration                                          │
│        ↓                                                    │
│  Semantic Model                                             │
│        ↓                                                    │
│  Relationships                                              │
│        ↓                                                    │
│  DAX Measures                                               │
│        ↓                                                    │
│  Business KPIs                                              │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                  BUSINESS ANALYTICS                         │
│                                                             │
│  Customer Intent     Sentiment      Complaints              │
│  Service Quality     Order Signals  Conversation Trends     │
│  Chat → Order Conversion                                     │
└─────────────────────────────────────────────────────────────┘
```

---

# 3. Layer 1 — Customer Conversation Data

The pipeline begins with customer conversations.

At this stage, the data is primarily unstructured or semi-structured and may contain:

* Customer messages
* Conversation/session identifiers
* Timestamps
* Sender information
* Channel information
* Conversation events
* Order-related information

The purpose of this layer is to provide the raw business context required for downstream AI classification and analytics.

The public repository does not contain production conversation data.

---

# 4. Layer 2 — Conversation Processing

Before sending conversations to the language model, the data needs to be transformed into an appropriate inference format.

Conceptually:

```text
Raw Conversation
       ↓
Session Identification
       ↓
Message Ordering
       ↓
Conversation Formatting
       ↓
AI Input
```

The objective is to create a consistent input representation for the fine-tuned model.

For example:

```text
Customer:
"Đơn hàng của tôi khi nào giao?"

Agent:
"Dạ em kiểm tra đơn hàng cho anh/chị."

Customer:
"Tôi đã chờ từ hôm qua."
```

This conversation can then be passed to the AI labeling layer.

The example is synthetic and is included only to illustrate the data flow.

---

# 5. Layer 3 — AI Labeling

## 5.1 Model

The AI layer uses a pharmacy-domain fine-tuned version of:

**Llama 3.1 8B Instruct**

The model was fine-tuned using pharmacy customer conversation examples to improve its ability to classify business-specific customer intents and sentiment.

The training workflow uses parameter-efficient fine-tuning rather than updating all parameters of the base model.

---

## 5.2 Fine-Tuning Flow

```text
Llama 3.1 8B Instruct
            │
            ▼
      Training Dataset
            │
            ▼
       LoRA / QLoRA
            │
            ▼
   Supervised Fine-Tuning
            │
            ▼
     Pharmacy V3 Model
```

The resulting model is then prepared for local inference.

---

## 5.3 Model Packaging

The model development workflow includes model conversion and quantization:

```text
Fine-tuned Model
      ↓
   GGUF FP16
      ↓
 Q4_K_M Quantization
      ↓
    Ollama
```

Quantization allows the model to be deployed with reduced memory requirements while retaining the ability to perform the required classification tasks.

---

# 6. Layer 4 — Ollama Inference

Ollama serves as the local inference runtime for the fine-tuned model.

Its responsibility is to execute the model and return structured classification results.

Conceptually:

```text
Conversation
     │
     ▼
Python / Inference Process
     │
     ▼
Ollama
     │
     ▼
Pharmacy V3 Model
     │
     ▼
Structured AI Output
```

Example output:

```json
{
  "labels": ["Khiếu nại giao hàng"],
  "sentiment": "Negative"
}
```

The production inference implementation is not included in the public repository.

---

# 7. Layer 5 — SQL Server

SQL Server is the central integration and analytical storage layer.

This is a critical architectural component.

The AI model does **not** directly become the Power BI data source.

Instead:

```text
Ollama
   ↓
SQL Server
   ↓
Power BI
```

This separation provides a persistent and queryable storage layer between AI inference and analytics.

---

# 8. Fact Table Architecture

The analytical design separates conversation information from AI-generated labeling information.

Conceptually, the SQL Server layer contains two primary fact tables.

## Fact 1 — Conversation / Session Fact

This fact stores conversation-level or session-level information.

Conceptual attributes may include:

```text
session_id
conversation_id
customer_id
date_key
channel
created_datetime
order-related information
conversation attributes
```

The exact production schema is intentionally not disclosed.

---

## Fact 2 — Chat Labeling Fact

This fact stores AI-derived analytical attributes.

Conceptual attributes include:

```text
session_id
label
category
sentiment
AI processing status
order-related indicators
classification metadata
```

Again, the production schema and internal column names are excluded from this public repository.

---

# 9. Why Two Fact Tables?

Separating the two analytical domains provides several benefits.

### Conversation data

Answers:

> What happened in the conversation?

### AI labeling data

Answers:

> What did the AI identify from the conversation?

This creates a logical separation:

```text
                 Conversation
                      │
          ┌───────────┴───────────┐
          │                       │
          ▼                       ▼
   Conversation Fact       AI Labeling Fact
          │                       │
          │                 Label / Sentiment
          │                       │
          └───────────┬───────────┘
                      │
                      ▼
                 Power BI
```

This structure also allows AI-generated attributes to evolve independently from the underlying conversation data.

---

# 10. SQL Server as the Integration Layer

The overall integration can be represented as:

```text
                  AI PIPELINE
                       │
                       ▼
                  Ollama
                       │
                AI prediction
                       │
                       ▼
              ┌────────────────┐
              │   SQL Server   │
              └───────┬────────┘
                      │
            ┌─────────┴─────────┐
            ▼                   ▼
    Conversation Fact    Chat Labeling Fact
            │                   │
            └─────────┬─────────┘
                      ▼
                 Power BI
```

This architecture prevents the BI layer from depending directly on the AI runtime.

The AI runtime can therefore be changed or upgraded without fundamentally changing the Power BI analytical layer, provided that the downstream SQL data contract remains stable.

---

# 11. Layer 6 — Power BI

Power BI consumes the structured data stored in SQL Server.

The analytical pipeline is:

```text
SQL Server
     ↓
Data Integration
     ↓
Semantic Model
     ↓
Relationships
     ↓
DAX Measures
     ↓
Reports
```

The Power BI layer is responsible for transforming the stored data into reusable business metrics.

---

# 12. Semantic Model

The semantic model provides a centralized analytical representation of the customer conversation domain.

Conceptually:

```text
                     Dim Date
                        │
                        │
                        ▼
Dim Customer ─── Fact Conversation ─── Dim Channel
                        │
                        │
                        ▼
                Fact Chat Labeling
                        │
              ┌─────────┼─────────┐
              ▼         ▼         ▼
           Label    Sentiment   Category
```

The exact production semantic model is proprietary and is therefore not included in this repository.

---

# 13. Business Analytics Layer

The semantic model supports analysis across several dimensions.

### Customer

* Customer volume
* Customer sentiment
* Negative customer identification
* Customer conversation behavior

### Conversation

* Session volume
* Conversation trends
* Channel distribution
* Label distribution

### Sentiment

* Positive
* Negative
* Neutral
* Mixed

### Business Labels

* Product inquiries
* Ordering
* Delivery
* Complaints
* Service feedback
* Other customer intents

### Commercial Signals

* Order-related conversations
* Chat-to-order conversion
* Customer interaction patterns

---

# 14. Example Analytical Flow

A business user may start from an executive KPI:

```text
Negative Conversation Rate
            │
            ▼
       Category
            │
            ▼
     Complaint Type
            │
            ▼
        Session
            │
            ▼
     Conversation
```

This creates a drill-down path from aggregated business performance to the underlying customer interaction.

---

# 15. Architecture Principles

## Separation of Concerns

Each layer has a distinct responsibility.

```text
AI
↓
Classification

SQL Server
↓
Storage + Integration

Power BI
↓
Semantic Modeling + Analytics
```

---

## Centralized Data Storage

AI-generated results are persisted in SQL Server instead of relying on the model runtime as the system of record.

---

## Reusable Analytics

Business definitions are implemented in the semantic model so that different reports can reuse consistent KPI logic.

---

## Traceability

Aggregated metrics should remain traceable to session-level and conversation-level records.

---

## Confidentiality

The public repository intentionally excludes production assets.

The architecture is documented at a level that demonstrates the solution design without exposing:

* Customer data
* Production database details
* Internal server information
* Credentials
* Production model artifacts
* Proprietary source code
* Internal business configurations

---

# 16. Public vs Production Architecture

The public repository represents the architecture conceptually:

```text
Public Documentation

AI
 ↓
SQL Server
 ↓
Fact Tables
 ↓
Power BI
```

The actual production environment may contain additional components, transformations, monitoring, orchestration, security controls, and infrastructure that are not represented here.

This repository should therefore be interpreted as a **sanitized architecture and methodology reference**, rather than a complete production deployment package.
