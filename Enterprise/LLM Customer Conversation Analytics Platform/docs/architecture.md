# System Architecture

## 1. Architecture Overview

The Customer Chat Intelligence Platform is an end-to-end analytics solution that transforms unstructured customer conversations into structured business intelligence.

The architecture separates the AI inference layer from the analytical layer:

```text
Customer Conversations
        ↓
Conversation Processing
        ↓
AI Labeling
        ↓
Ollama Inference
        ↓
SQL Server
        ↓
Power BI Semantic Model
        ↓
Business Analytics
```

The AI layer is responsible for interpreting customer conversations and generating structured classification results.

SQL Server provides the persistent data layer, while Power BI provides semantic modeling, KPI definitions, and business reporting.

---

# 2. High-Level Architecture

```text
┌─────────────────────────────────────────────────────────────┐
│                    CUSTOMER DATA                            │
│                                                             │
│  Customer Conversations / Sessions / Operational Events     │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│              CONVERSATION PROCESSING                        │
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
│  Pharmacy-domain fine-tuned LLM                             │
│  Llama 3.1 8B Instruct                                      │
│  LoRA / QLoRA                                                │
│                                                             │
│  Pharmacy V3                                                 │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     OLLAMA                                  │
│                                                             │
│  Local model inference                                      │
│  Structured classification output                            │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               │ AI-generated attributes
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                     SQL SERVER                              │
│                                                             │
│  Conversation / Omnichat Data                               │
│  AI Labeling Data                                           │
│  Supporting Analytical Data                                 │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                    POWER BI                                 │
│                                                             │
│  Data Model                                                 │
│  Relationships                                              │
│  Semantic Model                                             │
│  DAX Measures                                               │
│  KPI Logic                                                  │
└──────────────────────────────┬──────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────┐
│                  BUSINESS ANALYTICS                         │
│                                                             │
│  Customer Intent     Sentiment      Complaints              │
│  Service Quality     Conversation Trends                    │
│  Order-related Signals                                    │
└─────────────────────────────────────────────────────────────┘
```

---

# 3. Architecture Layers

The solution can be divided into six logical layers.

| Layer                   | Responsibility                                    |
| ----------------------- | ------------------------------------------------- |
| Customer Data           | Provides conversation and operational context     |
| Conversation Processing | Prepares conversations for AI inference           |
| AI Model                | Classifies customer conversations                 |
| Ollama                  | Executes local model inference                    |
| SQL Server              | Stores and integrates structured data             |
| Power BI                | Provides semantic modeling and business analytics |

This separation allows each component to have a clearly defined responsibility.

---

# 4. Customer Conversation Layer

The pipeline begins with customer conversation data.

The underlying data contains the context required to understand customer interactions and support downstream analytics.

At a high level, the data domain includes:

* Customer conversations
* Sessions
* Conversation events
* Operational context
* Channel information
* Order-related context

The public repository does not contain production customer conversations.

---

# 5. Conversation Processing Layer

Before inference, conversation data is transformed into a consistent format for the language model.

The conceptual flow is:

```text
Raw Conversation
       ↓
Session Preparation
       ↓
Message / Event Ordering
       ↓
Conversation Formatting
       ↓
AI Input
```

The purpose of this layer is to provide the model with sufficient conversational context while maintaining a consistent input structure.

---

# 6. AI Layer

The AI component uses a pharmacy-domain fine-tuned language model based on:

**Llama 3.1 8B Instruct**

The model was adapted for customer conversation classification using parameter-efficient fine-tuning.

The training workflow can be represented as:

```text
Llama 3.1 8B Instruct
          ↓
Pharmacy Conversation Dataset
          ↓
LoRA / QLoRA
          ↓
Supervised Fine-Tuning
          ↓
Pharmacy V3
```

The model is designed primarily for structured classification rather than general-purpose chatbot interaction.

---

# 7. Ollama Inference Layer

Ollama is used as the local inference runtime for the fine-tuned model.

The responsibility of Ollama is to execute the model and return structured AI output.

```text
Conversation
      ↓
Inference Process
      ↓
Ollama
      ↓
Pharmacy V3
      ↓
Structured AI Output
```

A simplified output can contain information such as:

```text
Business Label
Sentiment
Classification Result
```

The production model and inference implementation are not included in the public repository.

---

# 8. SQL Server Data Layer

SQL Server acts as the central persistent data layer between AI inference and Power BI.

The core integration pattern is:

```text
Ollama
   ↓
AI-generated results
   ↓
SQL Server
   ↓
Power BI
```

The AI runtime is therefore not treated as the reporting data source.

Instead, model outputs are persisted in SQL Server and become part of the analytical data pipeline.

This provides:

* Persistent storage
* Historical analysis
* SQL-based transformation
* Data quality control
* Reusable downstream analytics
* Decoupling between AI inference and BI reporting

---

# 9. Analytical Data Domains

The Power BI semantic model is built on several analytical domains represented in the underlying data model.

Rather than exposing the production schema, the public architecture groups these into logical domains:

```text
SQL Server
    │
    ├── Conversation / Omnichat Domain
    │
    ├── AI Chat Labeling Domain
    │
    ├── Session / Supporter Domain
    │
    ├── Omnichat Segmentation Domain
    │
    ├── Label / Category Reference Domain
    │
    └── Date / Supporting Dimensions
```

These domains provide the underlying data required by the Power BI semantic model.

The public repository intentionally does not expose every production table or column.

---

# 10. AI Labeling Data

The AI-generated classification results form a dedicated analytical domain.

Conceptually:

```text
Customer Conversation
        ↓
      Ollama
        ↓
AI Classification
        ↓
SQL Server
        ↓
AI Labeling Data
```

The labeling domain supports analytical attributes such as:

* Business classification
* Category
* Sentiment
* Order-related indicators
* Classification metadata

These attributes can then be analyzed alongside conversation and operational data.

---

# 11. Power BI Semantic Model

Power BI consumes the structured data stored in SQL Server.

The analytical flow is:

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

The semantic model provides a centralized layer for business definitions and reusable analytical logic.

The model reconstructed from the production metadata contains multiple analytical tables, supporting dimensions, relationships, and measures.

For the public repository, these are documented at the architectural level rather than exposing the complete production schema.

---

# 12. Semantic Model Structure

At a high level, the model combines:

```text
                    Date / Time
                        │
                        ▼
Conversation / Omnichat ──────── Supporting Dimensions
        │
        │
        ├──────── AI Labeling
        │
        ├──────── Session / Operational Context
        │
        └──────── Segmentation / Classification
                        │
                        ▼
                 Power BI Measures
                        │
                        ▼
                   Business KPIs
```

The exact production relationships are intentionally omitted from the public documentation.

---

# 13. Business Analytics Layer

The semantic model supports analysis across several business dimensions.

### Conversation Analytics

* Session volume
* Conversation trends
* Channel distribution
* Conversation segmentation

### Customer Analytics

* Customer volume
* Customer interaction behavior
* Negative customer identification
* Customer sentiment

### AI Classification

* Business label distribution
* Category distribution
* Sentiment distribution
* Negative conversation trends

### Commercial Analytics

* Order-related conversations
* Chat-to-order signals
* Customer interaction patterns

---

# 14. KPI Layer

The Power BI semantic model centralizes business metrics.

Examples of analytical KPI categories include:

```text
Conversation Volume
        ↓
Customer Volume
        ↓
Negative Conversations
        ↓
Negative Customers
        ↓
Negative Conversation Rate
        ↓
Order-related Sessions
        ↓
Chat-to-Order Analysis
```

The production semantic model contains the actual DAX implementation.

The public repository documents the business meaning of these metrics rather than publishing the complete production measure library.

---

# 15. End-to-End Data Flow

The complete solution can be summarized as:

```text
                CUSTOMER
                   │
                   ▼
          Customer Conversation
                   │
                   ▼
          Conversation Processing
                   │
                   ▼
              Pharmacy V3
                   │
                   ▼
                Ollama
                   │
                   │
          AI Classification
                   │
                   ▼
              SQL Server
                   │
          ┌────────┴────────┐
          │                 │
          ▼                 ▼
 Conversation Data    AI Labeling Data
          │                 │
          └────────┬────────┘
                   ▼
            Power BI Model
                   │
                   ▼
             DAX / KPI
                   │
                   ▼
          Business Analytics
```

This architecture separates **model inference**, **data storage**, and **business analytics**.

---

# 16. Separation of Responsibilities

Each component has a specific responsibility.

### AI Model

```text
Understand conversation
        ↓
Generate classification
```

### Ollama

```text
Execute model inference
        ↓
Return AI output
```

### SQL Server

```text
Store structured results
        ↓
Integrate analytical data
        ↓
Provide persistent query layer
```

### Power BI

```text
Model data
        ↓
Define business logic
        ↓
Calculate KPIs
        ↓
Visualize insights
```

This separation prevents the BI layer from becoming dependent on the internal implementation of the AI model.

---

# 17. Why SQL Server Is Between AI and Power BI

The architecture intentionally avoids:

```text
Ollama
   ↓
Power BI
```

Instead, the solution uses:

```text
Ollama
   ↓
SQL Server
   ↓
Power BI
```

This provides a stable data contract between the AI and analytics layers.

The AI model can therefore be retrained, replaced, or upgraded without requiring the Power BI report to directly interact with the model runtime.

As long as the downstream analytical structure remains compatible, the BI layer can continue consuming the stored results.

---

# 18. Summary

The platform follows a clear end-to-end architecture:

```text
Unstructured Customer Conversations
                ↓
        AI Classification
                ↓
             Ollama
                ↓
          SQL Server
                ↓
      Power BI Semantic Model
                ↓
          Business KPIs
                ↓
       Customer Insights
```

The central architectural principle is:

> **The LLM performs interpretation, SQL Server provides the persistent analytical layer, and Power BI transforms the structured data into reusable business intelligence.**

This separation allows the platform to combine AI-driven unstructured data processing with a conventional enterprise BI architecture while keeping production implementation details private.

The objective is to demonstrate the engineering and analytical approach without exposing confidential company assets.
