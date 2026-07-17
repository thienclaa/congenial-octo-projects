# Enterprise Semantic Model

## Overview

The Sales Analytics Platform is powered by an enterprise Power BI Semantic Model designed to centralize business logic, standardize KPI calculations, and support scalable reporting across Pharmacy & Healthcare E-Commerce operations.

Rather than building isolated datasets for individual reports, the platform consolidates enterprise data into a reusable semantic layer shared by multiple Power BI reports, ensuring consistent business metrics and governance.

---

## Model Statistics

| Metric | Value |
|---------|------:|
| Tables | 47 |
| Relationships | 77 |
| Measures | 477 |
| Calculated Columns | 107 |
| Daily Transactions | 100K+ |
| Business Users | 100+ |
| Refresh Frequency | Daily |

---

## Business Domains

The semantic model supports multiple enterprise business functions, including:

- Sales Analytics
- Customer Analytics
- Product Analytics
- Promotion Analytics
- Payment Analytics
- Customer Service Analytics
- Executive KPI Reporting
- Operational Performance Monitoring

---

## Data Model Design

The semantic model follows a star schema architecture composed of multiple fact tables connected to shared dimensions.

The model is designed to:

- maximize report performance
- promote reusable business logic
- minimize data redundancy
- simplify report development
- support enterprise-scale analytical workloads

---

## Shared Dimensions

The semantic model contains reusable enterprise dimensions including:

- Date
- Product
- Customer
- Store
- Promotion
- Payment
- Sales Channel
- Business Source

These dimensions are shared across multiple fact tables to ensure consistent KPI calculations.

---

## Fact Tables

The semantic model integrates multiple analytical fact tables supporting different business processes, including:

- Sales Transactions
- Customer Orders
- Customer Service
- Complaint Analytics
- Operational KPIs
- Sales Targets
- Promotion Performance

Each fact table represents a different analytical subject area while sharing common dimensions.

---

## Business Logic

Business calculations are centralized inside the semantic model using reusable DAX measures.

Examples include:

- Revenue
- GMV
- Sales Achievement
- Order Count
- Average Order Value
- Customer Repurchase
- Promotion Contribution
- Payment Mix
- MTD Revenue
- YTD Revenue
- YoY Growth

This approach guarantees consistent KPI definitions across all reports.

---

## Performance Optimization

The semantic model was extensively optimized to improve enterprise reporting performance.

### Results

| Optimization | Result |
|--------------|-------:|
| Semantic Model Refresh | 90 → 30 minutes |
| Dataflow Refresh | 3 hours → 1.5 hours |
| Semantic Model Storage | 15 GB → 5 GB |

Key optimization techniques included:

- Semantic model redesign
- DAX optimization
- Relationship optimization
- Calculated column reduction
- Power BI Dataflow optimization
- Memory optimization
- Refresh pipeline optimization

---

## Enterprise Reporting

The semantic model supports multiple executive dashboards including:

- Executive Sales Dashboard
- Sales Performance Dashboard
- Promotion Analytics
- Customer Analytics
- Payment Analytics
- Operational KPI Dashboard

All reports consume the same semantic model, ensuring consistent business metrics across departments.

---

## Technologies

- Power BI Semantic Models
- Power BI Dataflows
- DAX
- SQL Server
- Azure Synapse Analytics
- Databricks
- Python

---

## Lessons Learned

This project demonstrates how enterprise semantic models can serve as the foundation of a scalable Business Intelligence platform.

Major lessons include:

- Designing reusable semantic layers
- Centralizing business logic through DAX
- Optimizing enterprise-scale Power BI models
- Improving refresh performance for large datasets
- Delivering consistent KPIs across multiple business functions
