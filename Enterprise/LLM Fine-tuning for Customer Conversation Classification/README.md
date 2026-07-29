## Overview

Developed an end-to-end AI analytics platform to automatically classify pharmacy customer conversations using a fine-tuned Llama 3.1 model.

The platform transforms unstructured customer conversations into structured business labels, stores the results in SQL Server fact tables, and delivers customer service analytics through Power BI semantic models and executive dashboards.

## Business Problem

Customer conversations were manually reviewed before reporting, resulting in inconsistent labels, slow turnaround, and limited scalability.

Business teams required an automated solution capable of generating standardized conversation labels that could be integrated directly into enterprise reporting.

## Solution

Built an end-to-end AI analytics pipeline combining Llama 3.1, Python, SQL Server, and Power BI.

The solution automatically:

- Classifies customer conversations
- Detects customer sentiment
- Identifies business intent
- Generates structured labels
- Loads labeled data into SQL Server fact tables
- Publishes analytics through Power BI dashboards

flowchart LR

A[Customer Conversations]

--> B[Python ETL]

--> C[Llama 3.1 Fine-tuned Model]

--> D[Conversation Labels]

--> E[SQL Server Fact Tables]

--> F[Power BI Semantic Model]

--> G[Executive Dashboard]

## Business Impact

- Eliminated manual conversation labeling.
- Standardized business category classification.
- Enabled scalable AI-assisted customer analytics.
- Delivered reusable datasets for enterprise Power BI reporting.
- Improved reporting consistency across customer service operations.
