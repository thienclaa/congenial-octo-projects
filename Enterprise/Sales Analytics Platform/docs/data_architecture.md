# Semantic Model Architecture

## High-level design

The model uses a multi-fact dimensional architecture. Different business processes are represented by separate fact tables while reusable dimensions provide consistent filtering and slicing across analytical domains.

```text
                         POWER BI REPORTS
                                |
                                v
                      SEMANTIC / KPI LAYER
                                |
        +-----------------------+-----------------------+
        |                       |                       |
        v                       v                       v
   SALES / ORDERS        CUSTOMER SERVICE        TARGET / KPI
        |                       |                       |
        v                       v                       v
   Fact tables             Fact tables            Fact tables
        |                       |                       |
        +-----------------------+-----------------------+
                                |
                    CONFORMED DIMENSIONS
                                |
       +------------+------------+------------+------------+
       |            |            |            |            |
      Date       Product       Shop       Employee      Source
       |            |            |            |            |
       +------------+------------+------------+------------+
                                |
                                v
                    ENTERPRISE DATA SOURCES
```

## Core design principles

### 1. Multiple fact domains

Sales, orders, customer-service activity and targets have different business grains. Keeping them as separate fact tables avoids forcing unrelated processes into one wide table.

### 2. Reusable dimensions

Date, product, shop, employee, source and other dimensions can be reused across multiple fact domains, enabling consistent analysis.

### 3. Centralized KPI layer

Business measures are centralized in the semantic model so report pages can reuse common definitions instead of implementing KPI logic independently in every visual.

### 4. Business-oriented abstraction

The semantic model converts operational source structures into analytical entities such as sales, products, customers, shops, employees and service KPIs.

## Main fact domains

- `factDHBe`
- `factDoanhSo`
- `factChbhCall`
- `factChbhFriendSell`
- `factChbhApp`
- `factChbhComment`
- `factTargetDept`
- `factTargetTeam`
- `factChbhLv2`
- `factTargetTotal`
- `factChbhMpt`
- `factChbhChatOmni`
- `factChbhChatOmniDscm`
- `factDoanhSoFull`
- `factDhtcFull`
- `factVoucher`
- `factDoanhSo_2021`
- `factDHBe_2021`
- `factFlashSale`
- `factCDP`

## Main dimensions

- `dimShop`
- `dimDate`
- `dimSource`
- `dimDelivery`
- `dimEmp`
- `dimDuration`
- `dimMonth`
- `dimDept`
- `dimProduct`
- `dimPaymentMethod`
- `dimCategory`
- `dimSubCategory`
- `dimRegion`
- `dim_tran_extra`
- `dimBehavior`
- `dimPhanKhuc`
- `dimTargetJP`

## Supporting / helper tables

- `Business Measures`
- `d_measure_sales`
- `MetricGroup`
- `Business Measures thi đua`
