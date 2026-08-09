# Measure Overview

Contains **477 measures**.

The public showcase intentionally does not publish the full production DAX catalog. Instead, it documents the role of the measure layer and dependency structure.

## Measure layer characteristics

- Centralized KPI definitions
- Reusable calculations across report pages
- Time-based comparison logic
- Sales and transaction KPIs
- Customer-service KPIs
- Target and achievement calculations
- Business performance metrics

## Measure dependency concept

A measure can depend on other measures, creating a reusable calculation layer:

```text
Base data
   ↓
Base measures
   ↓
Intermediate business measures
   ↓
KPI / management measures
   ↓
Power BI visuals
```

## Most reused measures

The following measures have the highest number of downstream measure references in the reconstructed model. Names are retained because they are part of the model metadata; raw DAX expressions are intentionally omitted from this public documentation.

| Table | Measure | Used by other measures | Direct dependencies |
|---|---|---:|---:|
| `Business Measures` | `year ds` | 49 | 0 |
| `Business Measures` | `DS - Tổng cộng dồn` | 20 | 1 |
| `Business Measures` | `year dhtc` | 20 | 0 |
| `Business Measures` | `year dhpos` | 15 | 1 |
| `Business Measures` | `year kpi chat số comment ca ngày` | 15 | 1 |
| `Business Measures` | `year dhbe` | 14 | 0 |
| `Business Measures` | `year chbh` | 13 | 6 |
| `Business Measures` | `Metric - Tổng` | 11 | 10 |
| `Business Measures` | `year kpi chat_omni số lượt chat ca ngày` | 11 | 0 |
| `Business Measures` | `DHTC - Tổng` | 10 | 0 |
| `Business Measures` | `NumberOfDays` | 10 | 0 |
| `Business Measures` | `year ds full` | 10 | 0 |
| `Business Measures` | `DHTC - Tổng cộng dồn` | 9 | 1 |
| `Business Measures` | `year chbh chat_omni` | 9 | 1 |
| `Business Measures` | `year kpi chat_omni_dscm số lượt chat ca ngày` | 9 | 0 |
| `Business Measures` | `DS - Tổng` | 8 | 0 |
| `Business Measures` | `year kpi call cg nhỡ` | 8 | 0 |
| `Business Measures` | `year kpi tick yêu cầu tổng ngày` | 7 | 0 |
| `Business Measures` | `year ds hàng hot` | 6 | 1 |
| `Business Measures` | `year ds tb ngày` | 6 | 1 |
| `Business Measures` | `year dhtc edited` | 6 | 0 |
| `Business Measures` | `year kpi lv2 ca ngày` | 6 | 0 |
| `Business Measures` | `year chbh tick ngày` | 5 | 3 |
| `Business Measures` | `year aov` | 5 | 2 |
| `Business Measures` | `year tltc` | 5 | 2 |
| `Business Measures` | `month aov tháng trước full` | 5 | 1 |
| `Business Measures` | `month chbh tháng trước full` | 5 | 1 |
| `Business Measures` | `year chbh call` | 5 | 1 |
| `Business Measures` | `DHBE - Tổng` | 5 | 0 |
| `Business Measures` | `DHPOS - Tổng` | 5 | 0 |
| `dimEmp` | `Target` | 5 | 0 |
| `Business Measures` | `total INC` | 5 | 0 |
| `Business Measures` | `year chbh comment oncx` | 5 | 0 |
| `Business Measures` | `year kpi tick giỏ hàng tổng ngày` | 5 | 0 |
| `Business Measures` | `CHBH - Tổng` | 4 | 14 |
| `Business Measures` | `CR - Tổng` | 4 | 2 |
| `Business Measures` | `Metric - Tổng CP-1` | 4 | 2 |
| `Business Measures thi đua` | `Target thi đua 1%` | 3 | 3 |
| `Business Measures thi đua` | `Target thi đua 2%` | 3 | 3 |
| `Business Measures thi đua` | `Target thi đua 3%` | 3 | 3 |
| `Business Measures` | `year chbh tick` | 3 | 3 |
| `Business Measures` | `DHCANCEL - Tổng` | 3 | 2 |
| `Business Measures` | `year % ecom` | 3 | 2 |
| `Business Measures` | `year chbh tick tổng nguồn yêu cầu` | 3 | 2 |
| `Business Measures thi đua` | `CR thi đua 3%` | 3 | 1 |
| `Business Measures` | `DS Full - Tổng cộng dồn` | 3 | 1 |
| `Business Measures` | `month cr tháng trước full` | 3 | 1 |
| `Business Measures thi đua` | `UT DS` | 3 | 1 |
| `Business Measures` | `year dhpos tb ngày` | 3 | 1 |
| `Business Measures` | `year dhtc tb ngày` | 3 | 1 |

## Privacy note

This public documentation intentionally excludes full production DAX expressions. The complete BIM remains a private working artifact.
