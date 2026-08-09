# Data Model

## 1. Overview

The Power BI semantic model is designed to transform customer conversation data and AI-generated classifications into reusable business analytics.

The model combines several analytical domains rather than relying on a single fact table.

At a high level:

```text
Conversation / Omnichat Data
            │
            ├──────────────┐
            │              │
            ▼              ▼
     Session Context   AI Labeling
            │              │
            └───────┬──────┘
                    │
                    ▼
             Supporting Dimensions
                    │
                    ▼
             Power BI Semantic Model
                    │
                    ▼
                DAX / KPIs
```

The production semantic model is represented in this repository at an architectural level. Individual production columns, source queries, credentials, and other implementation details are intentionally excluded.

---

# 2. Modeling Objective

The data model is designed to answer three major business questions:

### 1. What happened?

Understand customer conversations, sessions, channels, and interaction volume.

### 2. What did the conversation mean?

Use AI-generated labels and sentiment to classify customer intent and experience.

### 3. What business outcome was associated with the interaction?

Analyze order-related conversations and customer conversion signals.

This creates the following analytical chain:

```text
Conversation
     ↓
Session
     ↓
AI Classification
     ↓
Customer Experience
     ↓
Business Outcome
```

---

# 3. Main Analytical Domains

The semantic model can be grouped into several logical domains.

```text
┌────────────────────────────────────────────────────┐
│                POWER BI MODEL                      │
│                                                    │
│  Conversation / Omnichat                           │
│             │                                      │
│             ├── Session / Operational Context      │
│             │                                      │
│             ├── AI Chat Labeling                   │
│             │                                      │
│             ├── Segmentation / Classification      │
│             │                                      │
│             └── Label Reference                    │
│                                                    │
│  Date / Supporting Dimensions                      │
└────────────────────────────────────────────────────┘
```

The production model contains multiple tables supporting these domains.

---

# 4. Conversation / Omnichat Domain

The core conversation domain is represented by:

**`fact_conversation`**

This domain contains the underlying customer interaction data used by the analytical model.

At a conceptual level, it represents:

* Conversation activity
* Message-level interaction
* Customer / sender context
* Communication channel
* Conversation timing
* Session-level analytical context

The public documentation intentionally does not reproduce the complete production schema.

---

# 5. Conversation Grain

The conversation domain contains interaction-level information, while many business KPIs are calculated at the session level.

This distinction is important.

```text
One Customer
      │
      ├── Session A
      │      ├── Message
      │      ├── Message
      │      └── Message
      │
      └── Session B
             ├── Message
             └── Message
```

Therefore:

```text
Message volume
      ≠
Session volume
      ≠
Customer volume
```

The semantic model uses different aggregation logic depending on the analytical question.

---

# 6. AI Chat Labeling Domain

The AI labeling domain is represented by:

**`fact_chat_labeling`**

This is the primary analytical layer for AI-generated conversation classification.

Conceptually:

```text
Customer Conversation
        │
        ▼
   AI Processing
        │
        ▼
  Chat Labeling
        │
   ┌────┼─────┐
   ▼    ▼     ▼
 Label Category Sentiment
```

The labeling domain supports analytical attributes such as:

* Business classification
* Category
* Sentiment
* Order-related indicators
* Classification metadata

---

# 7. AI Labeling Grain

The AI labeling domain is analyzed primarily at the conversation/session level.

The central analytical concept is:

```text
Session
   ↓
AI classification
   ↓
Business label
   ↓
Sentiment
```

This allows the model to calculate metrics such as:

* Positive conversations
* Negative conversations
* Negative customers
* Complaint sessions
* Order-related sessions
* Label distribution

---

# 8. Session / Operational Context

The semantic model also contains supporting data related to session and operational context.

This domain is represented by:

**`fact_session_support`**

Its purpose is to provide additional context around customer interactions and connect conversation analytics with operational information.

Conceptually:

```text
Conversation
     │
     ▼
Session
     │
     ├── Operational context
     ├── Support context
     └── Interaction attributes
```

This layer is kept separate from the AI classification domain so that operational information and model-generated interpretation remain logically distinct.

---

# 9. Conversation Segmentation

The model also includes a conversation segmentation domain represented by:

**`fact_conversation_segment`**

Its purpose is to provide additional analytical segmentation of conversation activity.

Conceptually:

```text
Conversation
     │
     ▼
Conversation Segment
     │
     ├── Segment A
     ├── Segment B
     └── Segment C
```

This allows Power BI to analyze conversation behavior beyond raw session volume.

---

# 10. Label Reference Layer

The semantic model contains a reference layer for business labels and their categorization.

This domain is represented by:

**`dim_label`**

Conceptually:

```text
Category
    │
    ▼
Subcategory
    │
    ▼
Label
```

This hierarchy makes AI classification output easier to aggregate and analyze in Power BI.

The production taxonomy is intentionally generalized in this repository.

---

# 11. Date Dimension

Time is a common analytical dimension across the model.

The public model represents this dimension as:

**`dim_date`**

It supports:

* Daily analysis
* Monthly trends
* Period comparisons
* Channel trends
* Sentiment trends
* Order-related trends

Conceptually:

```text
Date
 │
 ├── Day
 ├── Month
 ├── Quarter
 └── Year
```

---

# 12. Logical Model

The overall model can be represented as:

```text
                         dim_date
                            │
                            │
                            ▼
                 fact_conversation
                            │
              ┌─────────────┼─────────────┐
              │             │             │
              ▼             ▼             ▼
   fact_session_support  fact_chat_    fact_conversation_
                         labeling          segment
                              │
                              │
                         ┌────┼────┐
                         ▼    ▼    ▼
                      Category Label Sentiment
                              │
                              ▼
                          dim_label
                              │
                              ▼
                       Power BI KPIs
```

This is a logical representation of the semantic model, not a reproduction of the production relationship diagram.

---

# 13. Relationship Strategy

The model connects analytical domains through shared business concepts such as:

* Session
* Customer / sender
* Date
* Channel
* Classification

The most important analytical key is the session because many KPIs are defined at the conversation/session level.

Conceptually:

```text
Conversation
     │
     │ Session
     ▼
AI Labeling
     │
     │ Classification
     ▼
Business Analysis
```

The exact production relationship metadata is intentionally not published.

---

# 14. Why Session Is Important

Session is the primary unit for many conversation KPIs.

For example:

```text
Total Sessions
=
Number of chat sessions
```

while:

```text
Total Customers
=
Distinct customers participating in chat
```

A single customer can therefore contribute multiple sessions.

This distinction is essential for preventing session-level volume from being interpreted as customer-level volume.

---

# 15. Customer-Level Analysis

Customer metrics require distinct-customer aggregation rather than simple session counting.

Conceptually:

```text
Customer A
   │
   ├── Session 1
   ├── Session 2
   └── Session 3
```

The model can therefore distinguish:

```text
3 Sessions
        ↓
1 Customer
```

This distinction is particularly important for customer sentiment and customer conversion metrics.

---

# 16. Sentiment Analytics

The AI labeling domain supports sentiment analysis.

The classification framework includes:

```text
Positive
Negative
Neutral
Mixed
```

These classifications are used to distinguish customer experience outcomes.

```text
Total Sessions
      │
      ├── Positive
      ├── Neutral
      ├── Negative
      └── Mixed
```

---

# 17. Negative Customer Analysis

The semantic model distinguishes between:

### Negative Sessions

Number of sessions classified as negative.

```text
Negative Sessions
=
Sessions with Negative Sentiment
```

### Negative Customers

Number of unique customers with at least one negative session.

```text
Negative Customers
=
Distinct customers
with ≥ 1 negative session
```

This distinction prevents repeated interactions from being interpreted as multiple unique customers.

---

# 18. Order Conversion Analytics

The data model also supports analysis of conversations associated with orders.

Conceptually:

```text
Chat Session
     │
     ▼
Order Signal
     │
     ▼
Order-related Session
```

The model supports measures for:

* Sessions associated with orders
* Order-related customers
* Chat-to-order rate
* Customer chat-to-order rate

The exact production order logic is intentionally not published.

---

# 19. KPI Architecture

The semantic model centralizes reusable measures.

The major KPI groups are:

```text
Conversation KPIs
├── Total Sessions
├── Total Messages
└── Channel Sessions

Customer KPIs
├── Total Customers
├── Negative Customers
└── Customers with Orders

Sentiment KPIs
├── Positive Sessions
├── Negative Sessions
└── Negative Conversation Rate

Commercial KPIs
├── Order Sessions
├── Order Customers
├── Chat-to-Order Rate
└── Customer Conversion Rate
```

---

# 20. Semantic Layer in Power BI

The SQL Server data is consumed by Power BI and transformed into a reusable semantic model.

```text
SQL Server
     ↓
Data Integration
     ↓
Tables
     ↓
Relationships
     ↓
Measures
     ↓
Semantic Model
     ↓
Reports
```

The semantic model is responsible for:

* Defining relationships
* Centralizing business metrics
* Managing analytical dimensions
* Supporting filter propagation
* Providing reusable DAX measures

---

# 21. Analytical Flow

A typical analytical path is:

```text
Date
 │
 ▼
Channel
 │
 ▼
Conversation
 │
 ▼
Session
 │
 ▼
AI Classification
 │
 ├── Category
 ├── Subcategory
 ├── Label
 └── Sentiment
 │
 ▼
Business KPI
```

This allows an executive KPI to be drilled down into the underlying customer interaction domain.

---

# 22. Example Business Analysis

A business user may start with:

```text
Negative Conversation Rate
```

and drill down through:

```text
Negative Conversation Rate
          ↓
Category
          ↓
Subcategory
          ↓
Label
          ↓
Session
          ↓
Conversation
```

This creates a path from an aggregated business KPI to the underlying customer interaction.

---

# 23. Summary

The data model connects customer interaction data with AI-generated business intelligence.

```text
Customer Conversations
          │
          ▼
fact_conversation
          │
          ▼
       Session
          │
          ├───────────────┐
          │               │
          ▼               ▼
fact_session_support   fact_chat_labeling
                          │
                    ┌─────┼─────┐
                    ▼     ▼     ▼
                 Category Label Sentiment
                          │
                          ▼
                       dim_label
                          │
                          ▼
                    Business KPIs
                          │
                          ▼
                       Power BI
```

The key design principle is:

> **Model the customer interaction separately from the AI interpretation, then combine both through a reusable Power BI semantic layer.**
