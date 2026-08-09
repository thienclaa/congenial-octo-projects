# Table Catalog

The following catalog is generated from the uploaded BIM semantic model.

| Table | Type | Columns | Measures | Hidden | Partitions |
|---|---|---:|---:|---|---:|
| `DateTableTemplate_fefa04aa-11f9-4fa4-a2c5-c13a56250713` | Supporting | 7 | 0 | Yes | 1 |
| `dimShop` | Dimension | 11 | 0 | No | 1 |
| `Business Measures` | Measure / Helper | 0 | 434 | No | 1 |
| `dimDate` | Dimension | 17 | 0 | No | 1 |
| `factDHBe` | Fact | 23 | 0 | No | 17 |
| `factDoanhSo` | Fact | 30 | 0 | No | 17 |
| `factChbhCall` | Fact | 20 | 0 | No | 17 |
| `dimSource` | Dimension | 6 | 0 | No | 1 |
| `factChbhFriendSell` | Fact | 18 | 0 | No | 17 |
| `factChbhApp` | Fact | 15 | 0 | No | 17 |
| `dimDelivery` | Dimension | 4 | 0 | No | 1 |
| `dimEmp` | Dimension | 20 | 7 | No | 1 |
| `factChbhComment` | Fact | 15 | 0 | No | 17 |
| `dimDuration` | Dimension | 1 | 0 | No | 1 |
| `factTargetDept` | Fact | 21 | 3 | No | 1 |
| `dimMonth` | Dimension | 2 | 0 | No | 1 |
| `factTargetTeam` | Fact | 14 | 1 | No | 1 |
| `dimDept` | Dimension | 1 | 0 | No | 1 |
| `factChbhLv2` | Fact | 16 | 0 | No | 17 |
| `dimProduct` | Dimension | 14 | 0 | No | 1 |
| `dimPaymentMethod` | Dimension | 5 | 0 | No | 1 |
| `dimCategory` | Dimension | 2 | 0 | No | 1 |
| `factTargetTotal` | Fact | 13 | 0 | No | 1 |
| `d_measure_sales` | Measure / Helper | 2 | 0 | No | 1 |
| `parTopN` | Supporting | 1 | 1 | No | 1 |
| `dimSubCategory` | Dimension | 2 | 0 | No | 1 |
| `Compare` | Supporting | 2 | 0 | No | 1 |
| `MetricGroup` | Measure / Helper | 2 | 0 | No | 1 |
| `Time Range` | Supporting | 2 | 0 | No | 1 |
| `factChbhMpt` | Fact | 21 | 0 | No | 17 |
| `factChbhChatOmni` | Fact | 17 | 0 | No | 17 |
| `Business Measures thi đua` | Measure / Helper | 1 | 29 | No | 1 |
| `factChbhChatOmniDscm` | Fact | 18 | 0 | No | 17 |
| `factDoanhSoFull` | Fact | 9 | 0 | No | 17 |
| `dimRegion` | Dimension | 1 | 0 | No | 1 |
| `factDhtcFull` | Fact | 2 | 0 | No | 17 |
| `factVoucher` | Fact | 5 | 0 | No | 17 |
| `dim_tran_extra` | Dimension | 1 | 0 | No | 1 |
| `target_date` | Supporting | 3 | 2 | No | 1 |
| `lunar_calendar` | Supporting | 3 | 0 | No | 1 |
| `factDoanhSo_2021` | Fact | 20 | 0 | No | 1 |
| `dimBehavior` | Dimension | 1 | 0 | No | 1 |
| `factDHBe_2021` | Fact | 14 | 0 | No | 1 |
| `dimPhanKhuc` | Dimension | 2 | 0 | No | 1 |
| `dimTargetJP` | Dimension | 5 | 0 | No | 1 |
| `factFlashSale` | Fact | 9 | 0 | No | 17 |
| `factCDP` | Fact | 1 | 0 | No | 1 |

## Reading the catalog

- **Fact** tables represent business processes or events.
- **Dimension** tables provide reusable descriptive attributes.
- **Measure / Helper** tables primarily organize business calculations or supporting model logic.
- **Supporting** tables are model-specific structures that do not fit cleanly into the three primary categories.
