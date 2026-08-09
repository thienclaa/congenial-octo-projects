# Data Model

## 1. Overview

The Power BI semantic model integrates customer conversation data, AI-generated conversation classifications, operational session information, conversation segmentation, and reference data into a centralized analytical model.

The production model contains six main tables:

| Public Name | Analytical Role |
|---|---|---|
| `dim_date` | Time-based analysis |
| `dim_label` | Category / subcategory / label reference |
| `fact_conversation` | Customer conversation analysis |
| `fact_chat_labeling` | AI classification and sentiment analysis |
| `fact_conversation_segment` | Conversation segmentation |
| `fact_session_support` | Session and support context |

Production table names are replaced with public-safe names in the documentation. Individual production columns are intentionally not documented.

---

## 2. Logical Model

The semantic model can be represented at a high level as:

```text
                         dim_date
                            |
                            |
                            v
                  fact_conversation
                            |
                            |
                            v
                  fact_chat_labeling
                     ^      ^      ^
                     |      |      |
                     |      |      |
                 dim_label  |      |
                            |      |
             fact_conversation_segment
                            |
                            |
                  fact_session_support
```

The model combines conversation data, AI-generated classification, segmentation, operational session information, and reference data.

---

## 3. Data Model Components

The model consists of four main types of analytical components:

```text
Dimensions
    |
    +-- dim_date
    |
    +-- dim_label

Analytical Data
    |
    +-- fact_conversation
    |
    +-- fact_chat_labeling
    |
    +-- fact_conversation_segment

Operational Context
    |
    +-- fact_session_support
```

---

## 4. Date Dimension

### Public Name

`dim_date`

### Production Table

`dateDim`

The date dimension provides the common time context used throughout the semantic model.

It supports analysis by:

- Date
- Day
- Day of week
- Day of year
- Month
- Date offset
- End of month

Conceptually:

```text
dim_date
    |
    +-- Day
    +-- Week
    +-- Month
    +-- Quarter
    +-- Year
```

The date dimension is used to support time-based analysis of conversation activity and related analytical metrics.

---

## 5. Conversation Fact

### Public Name

`fact_conversation`

### Production Table

`f_omnichat_longchau_group`

This table represents the underlying customer conversation and Omnichat interaction data.

At a high level, it provides the context required to analyze:

- Customer conversations
- Sessions
- Communication channels
- Conversation timing
- Sender / customer activity
- Message activity

The public repository does not expose the complete production column schema.

---

## 6. Conversation Grain

The conversation data contains interaction-level information.

A customer can participate in multiple sessions, and a session can contain multiple messages.

Conceptually:

```text
Customer
   |
   +-- Session A
   |      |
   |      +-- Message
   |      +-- Message
   |      +-- Message
   |
   +-- Session B
          |
          +-- Message
          +-- Message
```

Therefore:

```text
Message volume
      !=
Session volume
      !=
Customer volume
```

This distinction is important when defining Power BI measures.

---

## 7. Chat Labeling Fact

### Public Name

`fact_chat_labeling`

This table contains the AI-generated classification results associated with customer conversations.

The labeling domain supports analytical attributes such as:

- Category
- Subcategory / label
- Sentiment
- Order-related classification
- AI-generated labeling information
- Conversation / session context

Conceptually:

```text
Customer Conversation
        |
        v
AI Classification
        |
        v
fact_chat_labeling
        |
        +-- Category
        +-- Subcategory
        +-- Label
        +-- Sentiment
        +-- Order Signal
```

The complete production schema is intentionally excluded.

---

## 8. Label Reference

### Public Name

`dim_label`

This table provides the reference structure used to organize conversation labels.

The classification hierarchy can be represented as:

```text
Category
    |
    v
Subcategory
    |
    v
Label
```

This allows AI-generated labels to be grouped into higher-level business categories for reporting.

The production taxonomy is not reproduced in the public repository.

---

## 9. Conversation Segmentation

### Public Name

`fact_conversation_segment`

This table provides segmentation information associated with Omnichat conversation activity.

At a conceptual level, it supports:

- Conversation segmentation
- Message / session-level segmentation metrics
- Sender-level analytical context
- Segment-based analysis

The production implementation and detailed column definitions are intentionally excluded.

---

## 10. Session Support Context

### Public Name

`fact_session_support`

This table provides supporting operational information associated with conversation sessions.

Its purpose is to provide context such as:

- Session
- Sender
- Support assignment
- Supporter information
- Operational skill / support context

This allows conversation and AI labeling data to be analyzed together with the operational context surrounding a session.

---

## 11. Relationship Structure

The semantic model uses relationships between reference, analytical, and operational tables.

At a conceptual level:

```text
dim_date
   |
   v
fact_conversation
   |
   v
fact_chat_labeling
   ^
   |
dim_label
```

The model also connects the labeling domain with conversation segmentation and session support context:

```text
fact_conversation_segment
          |
          v
fact_chat_labeling
          ^
          |
fact_session_support
```

The exact relationship columns are intentionally omitted from the public documentation.

---

## 12. Relationship Design

The model is designed around shared analytical concepts including:

- Date
- Conversation
- Session
- Sender / customer
- Classification
- Segmentation
- Support context

The central analytical path is:

```text
Conversation
     |
     v
Session
     |
     v
AI Classification
     |
     +-- Category
     +-- Label
     +-- Sentiment
     +-- Order Signal
```

This allows the model to connect what happened during a customer interaction with how the conversation was classified.

---

## 13. Conversation and AI Labeling

The most important analytical relationship is between the conversation domain and the AI labeling domain.

```text
fact_conversation
        |
        | Conversation / Session Context
        v
fact_chat_labeling
        |
        +-- Business Classification
        +-- Sentiment
        +-- Order-related Signal
```

This separation provides two complementary perspectives:

```text
What happened?
        |
        v
fact_conversation

What did the AI identify?
        |
        v
fact_chat_labeling
```

Together they form the foundation of customer conversation analytics.

---

## 14. Sentiment Analysis

The AI labeling domain supports sentiment analysis.

The project classification framework includes:

```text
Positive
Negative
Neutral
Mixed
```

Conceptually:

```text
Customer Conversation
        |
        v
Sentiment Classification
        |
        +-- Positive
        +-- Negative
        +-- Neutral
        +-- Mixed
```

These classifications allow customer experience and negative-conversation metrics to be calculated in Power BI.

---

## 15. Customer-Level Analysis

The semantic model distinguishes between session-level and customer-level analysis.

For example:

```text
Customer A
   |
   +-- Session 1
   +-- Session 2
   +-- Session 3
```

This means:

```text
3 Sessions
    |
    v
1 Customer
```

Customer-level metrics therefore require distinct customer aggregation rather than simply counting sessions.

---

## 16. Session-Level Analysis

Session is an important analytical unit in the model.

Examples of session-level analysis include:

- Total sessions
- Sessions by channel
- Positive sessions
- Negative sessions
- Complaint sessions
- Order-related sessions

Conceptually:

```text
Total Sessions
      |
      +-- Channel
      +-- Sentiment
      +-- Classification
      +-- Order-related activity
```

---

## 17. Conversation Classification

The classification hierarchy allows business users to move from a high-level category toward a more specific conversation label.

```text
Category
    |
    v
Subcategory
    |
    v
Label
    |
    v
Conversation / Session
```

This provides a structured way to analyze the reasons behind customer interactions.

---

## 18. Order-Related Analysis

The AI labeling domain contains an order-related classification signal.

This enables the semantic model to distinguish between:

```text
Chat Sessions
      |
      +-- Order-related
      |
      +-- Non-order-related
```

This information can then be used to calculate commercial KPIs such as chat-to-order performance.

---

## 19. KPI Layer

The semantic model centralizes reusable business measures.

### Conversation KPIs

```text
Total Sessions
Total Customers
Total Messages
Sessions by Channel
```

### Sentiment KPIs

```text
Positive Sessions
Negative Sessions
Negative Customers
Negative Conversation Rate
```

### Customer-Service KPIs

```text
Complaint Sessions
Negative Customer Rate
Customer Experience Indicators
```

### Commercial KPIs

```text
Order-related Sessions
Customers with Orders
Chat-to-Order Rate
Customer Chat-to-Order Rate
```

These measures are consumed by Power BI reports and dashboards.

---

## 20. Power BI Semantic Layer

SQL Server provides the structured data consumed by Power BI.

The analytical flow is:

```text
SQL Server
     |
     v
Data Integration
     |
     v
Semantic Model
     |
     v
Relationships
     |
     v
DAX Measures
     |
     v
Power BI Reports
```

The semantic model provides a centralized layer for:

- Relationships
- Business definitions
- DAX measures
- Filtering
- KPI calculations
- Analytical dimensions

This prevents business logic from being duplicated across individual visuals.

---

## 21. Analytical Drill-Down

A typical analytical drill-down can follow this path:

```text
Business KPI
      |
      v
Sentiment / Classification
      |
      v
Category
      |
      v
Subcategory
      |
      v
Label
      |
      v
Session
      |
      v
Conversation
```

This allows users to move from an aggregated KPI to the underlying business reason behind the result.

---

## 22. Data Model Summary

The public-safe model can be summarized as:

```text
                         dim_date
                            |
                            |
                            v
                  fact_conversation
                            |
                            |
                            v
                  fact_chat_labeling
                     ^      ^      ^
                     |      |      |
                     |      |      |
                 dim_label  |      |
                            |      |
             fact_conversation_segment
                            |
                            |
                  fact_session_support
```

The model combines:

```text
Conversation Data
        +
AI Classification
        +
Label Reference
        +
Conversation Segmentation
        +
Session Support Context
        +
Date Analysis
        |
        v
Power BI Semantic Model
        |
        v
Business KPIs
```

---

## 23. Public Repository Scope

The GitHub repository intentionally does not publish:

- Production column-level schema
- Production SQL queries
- Customer conversation data
- Database credentials
- Internal server information
- Connection strings
- Production model files
- Full semantic-model metadata
- Proprietary implementation details

Instead, the repository documents the architecture and analytical design.

---

## 24. Design Principles

### Separation of Concerns

Conversation data, AI classification, reference data, segmentation, and operational context are modeled as separate components.

### Session-Aware Analytics

Session-level and customer-level metrics are calculated separately to avoid incorrect aggregation.

### Centralized Business Logic

Business KPIs are defined in the Power BI semantic layer.

### Reusable Analytical Model

The same semantic model can support multiple reports and analytical views.

### Public-Safe Documentation

The repository exposes the analytical architecture without exposing production data or proprietary implementation details.

---

## 25. Summary

The semantic model combines customer conversation data with AI-generated classification and supporting analytical context.

```text
                    Customer Conversations
                            |
                            v
                  fact_conversation
                            |
                            v
                  fact_chat_labeling
                     ^      ^      ^
                     |      |      |
                     |      |      |
                 dim_label  |      |
                            |      |
        fact_conversation_segment
                            |
                            |
                  fact_session_support
                            |
                            v
                       Power BI
                            |
                            v
                     Business KPIs
```

The key design principle is:

> Separate customer interaction data from AI-generated interpretation, then combine both with reference and operational context in a centralized Power BI semantic model.
