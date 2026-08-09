# Pharmacy Customer Chat Intelligence Platform

An AI-powered customer conversation analytics solution designed to transform unstructured pharmacy customer chats into structured business insights for customer service, operational monitoring, and sales analytics.

> **Confidentiality Notice**
> This repository documents the architecture, methodology, data modeling approach, AI labeling workflow, and analytical design of an enterprise implementation. Production data, customer conversations, credentials, internal infrastructure details, production models, and proprietary source code are intentionally excluded.

---

## Overview

Customer conversations contain valuable information about customer intent, service quality, sentiment, complaints, and purchasing behavior. However, raw chat messages are difficult to analyze at scale because the information is primarily unstructured.

This solution addresses that problem by introducing an AI-powered conversation labeling layer that converts customer conversations into structured attributes such as:

* Customer intent / business label
* Category
* Sentiment
* Order-related indicators
* Conversation and customer attributes

The structured results are stored in SQL Server fact tables and subsequently consumed by Power BI for semantic modeling, KPI calculation, interactive reporting, and business analysis.

The solution combines:

**LLM Fine-tuning → Local AI Inference → SQL Server → Power BI Semantic Model → Business Analytics**

---

## Business Problem

Customer service teams handle a large volume of conversations across digital channels. Manually reviewing and categorizing these conversations is time-consuming and difficult to scale.

The business needs to understand:

1. **What are customers asking about?**
2. **Which conversations are positive, neutral, or negative?**
3. **What types of complaints are occurring?**
4. **Which conversations are associated with orders?**
5. **How do customer conversation patterns change over time and across channels?**
6. **How can customer-service teams monitor these patterns through standardized KPIs?**

The solution converts these unstructured conversations into structured analytical data that can be aggregated and analyzed in Power BI.

---

## Solution Architecture

```text
                         CUSTOMER CHAT
                              │
                              ▼
                 ┌────────────────────────┐
                 │ Conversation Processing│
                 │                        │
                 │ Session / Conversation │
                 │ preparation            │
                 └───────────┬────────────┘
                             │
                             ▼
                 ┌────────────────────────┐
                 │ Pharmacy V3 AI Model   │
                 │                        │
                 │ Llama 3.1 8B Instruct  │
                 │ LoRA / QLoRA            │
                 │ Supervised Fine-Tuning  │
                 └───────────┬────────────┘
                             │
                             ▼
                         Ollama
                             │
                             │
                 ┌───────────▼────────────┐
                 │ AI Classification      │
                 │                        │
                 │ Category               │
                 │ Label                  │
                 │ Sentiment              │
                 │ Order-related signals  │
                 └───────────┬────────────┘
                             │
                             ▼
                 ┌────────────────────────┐
                 │ SQL Server             │
                 │                        │
                 │ Fact Chat              │
                 │ Fact Chat Labeling     │
                 │ Supporting dimensions  │
                 └───────────┬────────────┘
                             │
                             ▼
                 ┌────────────────────────┐
                 │ Power BI               │
                 │                        │
                 │ Dataflow / Data Model  │
                 │ Semantic Model         │
                 │ DAX Measures           │
                 └───────────┬────────────┘
                             │
                             ▼
                 ┌────────────────────────┐
                 │ Business Analytics     │
                 │                        │
                 │ Customer Intent        │
                 │ Sentiment              │
                 │ Complaints             │
                 │ Service Quality        │
                 │ Chat → Order           │
                 │ Conversion             │
                 └────────────────────────┘
```

---

## End-to-End Data Flow

### 1. Customer Conversations

Raw customer conversations are collected from digital customer-service channels.

The conversation data contains information such as:

* Customer messages
* Sender information
* Conversation/session identifiers
* Creation timestamps
* Channel information

For analytical purposes, conversation-level data is organized into a consistent session/conversation structure.

---

### 2. AI Conversation Labeling

The AI layer uses a fine-tuned **Llama 3.1 8B Instruct** model to classify customer conversations.

The model was fine-tuned using pharmacy-specific labeled examples with an instruction-tuning approach.

Conceptually:

```text
Customer Conversation
        │
        ▼
Instruction + Conversation
        │
        ▼
Fine-tuned Llama 3.1 8B
        │
        ▼
Label + Sentiment
```

The model is designed to produce structured classification output rather than general conversational responses.

---

## AI Fine-Tuning Pipeline

The model development workflow includes:

```text
Pharmacy Customer Chat Dataset
              │
              ▼
       Dataset Formatting
              │
              ▼
      Llama 3 Instruct Format
              │
              ▼
       LoRA / QLoRA Training
              │
              ▼
      Pharmacy V3 Fine-tuned Model
              │
              ▼
          Model Merge
              │
              ▼
           GGUF FP16
              │
              ▼
          Q4_K_M Quantization
              │
              ▼
       Ollama Local Deployment
```

### Base Model

* Llama 3.1 8B Instruct
* Maximum sequence length: 2,048 tokens
* 4-bit loading for memory-efficient training

### Fine-Tuning

The training pipeline uses:

* Unsloth
* PEFT / LoRA
* Supervised Fine-Tuning
* 8-bit AdamW optimizer
* Gradient accumulation
* BF16-capable GPU training

The training configuration uses LoRA adapters rather than updating all base-model parameters.

The documented training run used approximately 5,000 examples and 500 training steps.

---

## AI Output

The model is designed to generate a structured response containing:

```text
Labels: [business label]
Sentiment: [Positive / Negative / Neutral / Mixed]
```
---

## Business Label Taxonomy

The labeling framework organizes customer conversations into major business categories, including:

### Nghiệp vụ – Tư vấn – Hỏi đáp

### Khiếu nại / Tiêu cực

### Phản hồi tích cực

### Khác

The exact production taxonomy is proprietary and is therefore not reproduced in full in this repository.

---

## Sentiment Classification

The solution uses four sentiment categories:

| Sentiment | Description                                                  |
| --------- | ------------------------------------------------------------ |
| Positive  | Positive feedback, satisfaction, appreciation                |
| Negative  | Complaints, frustration, dissatisfaction                     |
| Neutral   | Mainly informational or transactional conversations          |
| Mixed     | A conversation containing both positive and negative signals |

---

# Data & SQL Architecture

SQL Server acts as the central analytical storage layer between the AI inference process and Power BI.

```text
                    AI Inference
                         │
                         ▼
                  SQL Server
                         │
              ┌──────────┴──────────┐
              │                     │
              ▼                     ▼
       Fact Chat /          Fact Chat Labeling /
       Conversation         Session-level Analytics
              │                     │
              └──────────┬──────────┘
                         │
                         ▼
                  Power BI Layer
```

The production implementation separates conversation information from AI-derived analytical attributes.

This enables the analytical layer to retain both:

* The underlying conversation/session context
* The classification and analytical results generated from the AI pipeline

Production table names, schemas, and implementation-specific SQL are intentionally excluded from this repository.

---

## Analytical Data Model

The analytical design follows a fact-and-dimension approach.

Conceptually:

```text
                   Date Dimension
                         │
                         │
Customer ──────── Fact Chat ─────── Channel
                         │
                         │
                         ▼
                 Fact Chat Labeling
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
           Category   Sentiment   Order
```

The model supports analysis at multiple levels:

* Conversation/session
* Customer
* Date
* Week
* Month
* Channel
* Category
* Label
* Sentiment

---

# Power BI Semantic Model

The Power BI semantic layer transforms SQL Server data into reusable business metrics.

The semantic model contains:

* Fact tables
* Supporting dimensions
* Date dimension
* Relationships
* DAX measures
* Business KPI logic

The semantic model is designed to support both overview-level management reporting and detailed conversation analysis.

---

## Key Business Metrics

### Total Sessions

Measures the number of distinct customer conversation sessions.

```text
Distinct Sessions
```

---

### Total Customers

Measures the number of distinct customers participating in conversations.

```text
Distinct Customers
```

---

### Negative Sessions

Counts conversation sessions classified as negative.

```text
Negative Sessions
```

---

### Negative Customers

Counts customers who have at least one negative conversation.

This metric is intentionally different from negative sessions because one customer may have multiple sessions.

```text
Negative Customers ≠ Negative Sessions
```

---

### Negative Conversation Rate

Measures the proportion of conversation sessions classified as negative.

```text
Negative Sessions
──────────────────
Total Sessions
```

---

### Chat-to-Order Conversion

Measures the proportion or volume of chat sessions associated with an order.

```text
Order-related Sessions
───────────────────────
Total Sessions
```

The exact production KPI implementation is maintained in the Power BI semantic model and is not reproduced here.

---

### AI Processing Coverage

The analytical layer can also monitor the proportion of conversations processed by an AI labeling mechanism.

This allows the business to monitor AI-assisted labeling coverage alongside customer-service metrics.

---

# Power BI Report

The analytical report is designed around two major use cases:

## Overview

Provides a high-level view of:

* Conversation volume
* Customer volume
* Sentiment distribution
* Negative conversation trends
* Category distribution
* Order-related conversations
* AI processing coverage
* Time-based trends

## Detail

Allows users to investigate individual conversation/session records and connect aggregated KPIs back to detailed conversation information.

This enables a workflow such as:

```text
KPI
 │
 ▼
Negative Conversations
 │
 ▼
Category / Label
 │
 ▼
Session
 │
 ▼
Conversation Detail
```

---

# Technology Stack

## AI / Machine Learning

* Llama 3.1 8B Instruct
* Unsloth
* PEFT / LoRA
* Supervised Fine-Tuning
* GGUF
* Q4_K_M quantization
* Ollama

## Data Engineering

* Python
* SQL
* SQL Server
* ETL / data processing pipelines

## Analytics

* Power BI
* Power BI Semantic Models
* DAX
* Power Platform Dataflows

Production source code, production datasets, customer information, production model artifacts, and internal configuration files are excluded.

---

# Key Design Principles

### 1. Separate AI inference from analytics

The LLM is responsible for converting unstructured conversations into structured classification signals.

Power BI is responsible for aggregating and analyzing those signals.

### 2. Use SQL Server as the integration layer

SQL Server provides the central storage layer between AI-generated results and downstream analytics.

### 3. Centralize business logic in the semantic layer

Reusable Power BI measures provide standardized definitions for business KPIs.

### 4. Preserve drill-down capability

Aggregated metrics should remain traceable back to individual conversation/session records.

### 5. Protect production data

The public repository intentionally uses documentation and synthetic examples instead of production customer data and proprietary implementation assets.

---

# Project Outcomes

The solution establishes an architecture for transforming unstructured customer conversations into structured analytical data that can be used to monitor:

* Customer intent
* Customer sentiment
* Complaint patterns
* Service quality
* Conversation volume
* Customer behavior
* Chat-to-order conversion
* AI-assisted labeling coverage

The key value of the solution is not the LLM alone, but the integration of:

```text
Unstructured Data
       ↓
AI Classification
       ↓
Structured Data
       ↓
Analytical Data Model
       ↓
Business KPI
       ↓
Decision Support
```

---

## Disclaimer

This project description is a sanitized representation of an enterprise implementation. Names, datasets, production infrastructure, schemas, customer information, and proprietary implementation details have been intentionally omitted or generalized for confidentiality.

