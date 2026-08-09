# Power BI Semantic Model

## E-Commerce Analytics — Semantic Model Showcase

This documentation presents the semantic-model architecture reconstructed from a Power BI Tabular Model (`.bim`) used in a production-scale e-commerce analytics environment.

> **Portfolio note:** This is an architecture and modeling showcase. The original production PBIX, source data, credentials, and proprietary report visuals are not included.

## Model at a glance

| Metric | Value |
|---|---:|
| Tables | 47 |
| Columns | 419 |
| Measures | 477 |
| Relationships | 77 |
| Model expressions | 9 |

## What this demonstrates

- Power BI semantic modeling
- Fact / dimension architecture
- Relationship design
- Reusable business dimensions
- Centralized DAX measures
- Multi-domain analytics
- Business-oriented KPI modeling

## Business domains

The model spans several analytical areas:

- **E-Commerce Sales**
- **Orders & Transactions**
- **Product & Promotion**
- **Customer Service / Chat / Call**
- **Employee & Team Performance**
- **Targets & Achievement**
- **Store / Region / Organization**
- **Time-based analysis**

## Architecture

![Semantic model overview](../images/semantic-model-overview.png)

For a more detailed explanation, see:

- [Model Architecture](architecture.md)
- [Table Catalog](tables.md)
- [Relationship Catalog](relationships.md)
- [Measure Overview](measures.md)

## Production-scale context

The underlying analytics environment supported:

- 100K+ daily transactions
- 100+ business users
- 10+ Power BI reports
- Large-scale SQL/Python ETL workflows
- Power BI semantic modeling and DAX

These figures describe the production experience behind the showcase and are not a representation of the public synthetic portfolio dataset.

## Privacy

The public documentation intentionally excludes:

- Production data
- Credentials and connection details
- Company-specific source extracts
- The original PBIX report
- Raw production DAX catalog

The repository should use synthetic or anonymized data for any executable portfolio implementation.
