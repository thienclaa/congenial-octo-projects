# DAX Measures

This folder contains representative DAX measures from the Enterprise Sales Analytics Platform.

The semantic model consists of **477 reusable business measures** supporting Sales Analytics, Customer Analytics, Promotion Analytics, Customer Service, and Executive KPI Reporting.

Rather than exposing every measure, this folder highlights representative examples demonstrating enterprise semantic model design, reusable KPI development, and advanced DAX techniques.

## Featured DAX

The platform is powered by a reusable **Dynamic KPI Engine** that dynamically evaluates business metrics based on selected KPI, time granularity, and comparison mode, enabling a single semantic layer to support hundreds of executive KPIs.

See: `dax/Dynamic_KPI_Engine.dax`

## Contents

| File | Description |
|------|-------------|
| Dynamic_KPI_Engine.dax | Dynamic KPI calculation engine supporting multiple business metrics and time granularities |
| Revenue.dax | Base revenue measure |
| Successful_Orders.dax | Successful order calculation |
| Average_Order_Value.dax | AOV calculation |
| Customer_Repurchase.dax | Customer repurchase KPI |
