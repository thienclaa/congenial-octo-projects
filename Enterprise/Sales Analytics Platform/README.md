# Enterprise Sales Analytics Platform

Enterprise analytics platform supporting executive decision-making across Pharmacy & Healthcare E-Commerce by integrating sales, promotions, customer behavior, payment, and operational data into a centralized Power BI reporting solution.

# Overview

Designed and maintained an enterprise Sales Analytics Platform supporting Pharmacy & Healthcare E-Commerce operations at FPT Retail – Long Châu.

The platform integrates sales transactions, promotions, payment methods, and customer behavior into executive Power BI dashboards, enabling data-driven decision-making across E-Commerce, Operations, and Management teams.

The platform supports approximately 100K+ daily sales transactions, serves more than 100 business users, and powers daily executive reporting across E-Commerce operations.

## Business Problem

The business required a centralized analytics platform capable of consolidating sales transactions, promotions, payment methods, customer behavior, and operational metrics from multiple enterprise data sources.

Existing reporting processes relied on fragmented datasets, lengthy refresh cycles, and disconnected reports, limiting timely operational monitoring and executive decision-making.

## Solution

The platform delivers enterprise reporting capabilities including:

- Executive sales performance dashboards
- Sales KPI and target monitoring
- Promotion effectiveness analysis
- Payment channel analytics
- Customer purchasing behavior analysis
- Product performance monitoring
- Operational reporting for business stakeholders

## Architecture


SQL Server
        │
Azure Synapse
        │
Databricks
        │
Power BI Dataflows
        │
Semantic Model
        │
Power BI Reports
        │
Business Users

## Semantic Model Overview

| Metric | Value |
|---------|------:|
| Tables | 47 |
| Relationships | 77 |
| Measures | 477 |
| Daily Transactions | 100K+ |
| Business Users | 100+ |

## Business Impact

- Supported analytics for approximately 100K+ daily sales transactions.
- Served more than 100 business users across E-Commerce, Operations, Customer Service, and Management.
- Increased call center revenue by 15% through customer repurchase analytics.
- Reduced semantic model refresh time from 90 minutes to 30 minutes.
- Reduced Power BI Dataflow refresh time from 3 hours to 1.5 hours.
- Reduced semantic model storage from 15 GB to 5 GB.

## Technology Stack

### Data Platforms
- SQL Server
- Azure Synapse Analytics
- Databricks

### Business Intelligence
- Power BI
- Power BI Dataflows
- Semantic Models
- DAX

### Data Engineering
- Python

## Key Responsibilities

- Designed and maintained enterprise Power BI semantic models.
- Developed analytical datasets supporting executive reporting.
- Built KPI frameworks for sales performance monitoring.
- Maintained production reporting pipelines and data quality.
- Optimized enterprise reporting performance and refresh architecture.
