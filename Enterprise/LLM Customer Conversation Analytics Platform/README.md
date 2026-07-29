# LLM Customer Conversation Classification Platform

Enterprise AI-powered analytics platform for automatically classifying customer conversations into structured business labels and sentiment categories, enabling downstream analytics through SQL Server and Power BI.

---

# Overview

Developed an end-to-end AI analytics platform that transforms unstructured customer conversations into structured analytical datasets using a fine-tuned Llama 3.1 model.

The platform automates conversation classification, customer sentiment analysis, and business intent detection before loading the results into SQL Server fact tables. The labeled datasets are then consumed by Power BI semantic models to deliver customer service dashboards and operational reporting.

Unlike traditional machine learning workflows, the solution integrates Large Language Models (LLMs) directly into the enterprise analytics pipeline, reducing manual labeling efforts while improving reporting consistency.

---

# Business Problem

Customer service operations generated a large volume of conversations across multiple communication channels every day.

Business users relied on manual review to classify conversations into business categories such as complaints, product consultation, delivery issues, promotions, and ordering behavior.

This manual process introduced several challenges:

- Time-consuming manual labeling
- Inconsistent classification across reviewers
- Difficult to scale as conversation volume increased
- Limited visibility into customer sentiment and complaint trends
- Delayed operational reporting

The business required an automated AI solution capable of generating standardized labels that could be directly integrated into enterprise reporting.

---

# Solution

Built an end-to-end AI labeling platform combining Llama 3.1, Python, SQL Server, and Power BI.

The platform automatically:

- Extracts customer conversations
- Generates AI prompts
- Performs conversation classification using a fine-tuned Llama model
- Detects customer sentiment
- Identifies business intent
- Validates prediction results
- Stores structured labels in SQL Server fact tables
- Publishes customer service analytics through Power BI semantic models

---

# End-to-End Architecture

```text
Customer Conversations
          │
          ▼
Python ETL Pipeline
          │
          ▼
Prompt Generation
          │
          ▼
Fine-tuned Llama 3.1
          │
          ▼
Conversation Classification
          │
          ▼
Validation Layer
          │
          ▼
SQL Server Fact Tables
          │
          ▼
Power BI Semantic Model
          │
          ▼
Executive Dashboards
```

---

# AI Classification Workflow

The AI pipeline converts raw customer conversations into structured analytical data.

Workflow:

1. Load customer conversations
2. Format prompts for Llama
3. Perform inference using the fine-tuned model
4. Generate structured JSON output
5. Validate prediction quality
6. Transform predictions into relational format
7. Load results into SQL Server
8. Refresh Power BI semantic models

---

# Classification Dimensions

Each conversation is automatically classified into multiple analytical dimensions.

### Customer Sentiment

- Positive
- Neutral
- Negative

### Business Intent

Examples include:

- Product Consultation
- Delivery
- Promotion
- Payment
- Complaint
- Customer Feedback
- Order Related
- Others

### Operational Labels

Additional business labels are generated for downstream reporting and KPI monitoring.

---

# Analytics Platform

The AI-generated labels are stored inside SQL Server fact tables and consumed by Power BI semantic models.

The reporting layer provides:

- Conversation volume monitoring
- Customer sentiment distribution
- Complaint analysis
- Business category analysis
- Weekly conversation trends
- Customer service KPI dashboards
- Executive operational reporting

---

# Semantic Model Overview

| Metric | Value |
|---------|------:|
| Tables | 7 |
| Measures | 24 |
| Core Fact Table | AI Conversation Labels |
| Date Dimensions | 1 |
| Reporting Layer | Power BI |

---

# Technology Stack

## Artificial Intelligence

- Llama 3.1 8B Instruct
- LoRA Fine-tuning
- Unsloth
- Transformers
- TRL

## Data Engineering

- Python
- SQL Server
- JSON Processing

## Business Intelligence

- Power BI
- DAX
- Semantic Models

---

# Repository Structure

```text
README.md

dax/
    conversation_metrics.dax
    sentiment_metrics.dax
    weekly_trend_metrics.dax

sql/
    conversation_dataset.sql
    load_fact_labeling.sql

python/
    labeling_pipeline.py
    inference.py
    validation.py

prompts/
    system_prompt.md
    inference_prompt.md

notebooks/
    finetune_llama31.ipynb

images/
```

---

# Sample DAX

The repository includes representative DAX measures demonstrating how AI-generated labels are transformed into business KPIs.

Examples include:

- Conversation Volume
- Negative Conversation Rate
- Customer Sentiment Distribution
- Weekly Trend Analysis
- Order-related Conversation Metrics

---

# Sample SQL

Only representative SQL examples are included in this repository.

Production ETL logic, business rules, and enterprise SQL scripts have been simplified to protect proprietary business logic.

Examples demonstrate:

- Conversation extraction
- Loading AI predictions into fact tables
- Building reporting datasets

---

# Sample Python Pipeline

Production inference pipelines have been simplified for demonstration purposes.

The examples illustrate the overall architecture:

```text
Load Conversations

↓

Prompt Builder

↓

LLM Inference

↓

Prediction Validation

↓

Fact Table Loading
```

---

# Dashboard

The final labeled datasets are visualized through Power BI dashboards supporting customer service operations.

Dashboard examples include:

- Conversation Trend
- Customer Sentiment
- Complaint Analysis
- Business Category Distribution
- Operational KPIs
- Executive Summary

---

# Key Highlights

- End-to-end LLM-powered analytics platform
- Fine-tuned Llama model for enterprise conversation classification
- Automated AI labeling pipeline
- SQL Server integration for structured analytics
- Power BI semantic models and dashboards
- Reusable DAX measures for customer service reporting
- Enterprise-ready architecture supporting AI-driven business intelligence

---

# Note

The SQL queries, Python scripts, prompts, and model training code included in this repository have been simplified for demonstration purposes.

Production implementations contain additional business rules, optimization logic, validation layers, and proprietary enterprise workflows that are intentionally omitted to protect confidential business information.
