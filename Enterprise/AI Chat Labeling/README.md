# AI Chat Labeling Platform

## Overview

Developed an AI-assisted analytics platform to automatically classify customer
chat conversations into structured business labels.

The platform combines Llama, Python, SQL Server, and Power BI to transform
unstructured conversations into reusable datasets supporting customer service
analytics and executive reporting.

## Business Problem

Customer conversations were manually reviewed before analysis.

Manual labeling was:

- Time-consuming
- Inconsistent across reviewers
- Difficult to scale
- Unsuitable for large-volume analytics

Business teams required standardized labels to analyze customer intent,
customer sentiment, complaint trends, and ordering behavior.

## Solution

Developed an AI-powered labeling pipeline using Llama.

The pipeline automatically:

- Reads raw conversations
- Generates structured labels
- Detects customer sentiment
- Identifies business intent
- Produces datasets for Power BI reporting

flowchart TD

A[Raw Chat]

--> B[Python Pipeline]

--> C[Llama]

--> D[Validation]

--> E[SQL Server]

--> F[Semantic Model]

--> G[Power BI]

## Semantic Model Overview

| Metric | Value |
|---------|------:|
| Tables | 7 |
| Measures | 24 |
| Core Measure Table | vd_chatbot_labeling_flc |
| Date Table | dateDim |

## Business Metrics

### Conversation

- Total Conversations
- Total Customers

### Sentiment

- Negative Conversations
- Negative Conversation Rate

### Business Outcome

- Conversations with Orders

### Weekly Trend

- Week-over-Week Change

## Technology Stack

### AI

- Llama

### Data Engineering

- Python

### Database

- SQL Server

### Business Intelligence

- Power BI
- DAX
