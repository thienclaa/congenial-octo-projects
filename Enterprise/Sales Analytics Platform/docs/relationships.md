# Relationship Catalog

The model contains **77 relationships**.

| From table | From column | To table | To column | From cardinality | To cardinality | Cross-filter |
|---|---|---|---|---|---|---|
| `factChbhComment` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhApp` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhComment` | `Khung Thời Gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhLv2` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factDHBe` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factDoanhSo` | `Ngày Mua` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhFriendSell` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factDoanhSo` | `Mã Shop` | `dimShop` | `SHOPCODE` | `` | `` | `` |
| `factDoanhSo` | `Loại giao hàng` | `dimDelivery` | `BI` | `` | `` | `` |
| `factDHBe` | `Date,Inside` | `dimEmp` | `Inside,Date` | `` | `` | `` |
| `factChbhApp` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factChbhComment` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factChbhFriendSell` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factChbhCall` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factDoanhSo` | `Date,Inside` | `dimEmp` | `Inside,Date` | `` | `` | `` |
| `factChbhLv2` | `Date,Inside` | `dimEmp` | `Inside,Date` | `` | `` | `` |
| `factChbhFriendSell` | `Nguồn chbh` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhLv2` | `Nguồn chbh` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhCall` | `Nguồn chbh` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhComment` | `Nguồn Chbh` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factTargetTeam` | `Tháng,Năm` | `dimMonth` | `Month & Year` | `` | `` | `` |
| `factDHBe` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factDHBe` | `Mã Shop` | `dimShop` | `SHOPCODE` | `` | `` | `` |
| `factDHBe` | `Nguồn đơn` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhCall` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhFriendSell` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factTargetDept` | `Phòng` | `dimDept` | `Dept` | `` | `` | `` |
| `dimDate` | `Month & Year` | `dimMonth` | `Month & Year` | `` | `` | `` |
| `dimDate` | `Month & Year` | `factTargetTotal` | `Tháng,Năm` | `` | `` | `` |
| `factTargetDept` | `Tháng,Năm` | `dimMonth` | `Month & Year` | `` | `` | `` |
| `factChbhApp` | `source` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhApp` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhCall` | `DATE` | `dimDate` | `Date` | `` | `` | `` |
| `factDHBe` | `Hình thức thanh toán` | `dimPaymentMethod` | `PAYMENT_NUMBER` | `` | `` | `` |
| `dimEmp` | `Team` | `dimDept` | `Dept` | `` | `` | `` |
| `factTargetTeam` | `Team` | `dimDept` | `Dept` | `` | `` | `` |
| `dimProduct` | `Ngành` | `dimCategory` | `Ngành` | `` | `` | `` |
| `dimSubCategory` | `Ngành` | `dimCategory` | `Ngành` | `` | `` | `` |
| `factDoanhSo` | `Hình thức thanh toán` | `dimPaymentMethod` | `PAYMENT_NUMBER` | `` | `` | `` |
| `factDoanhSo` | `Nguồn` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhMpt` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhMpt` | `Nguồn chbh` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhMpt` | `DATE` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhMpt` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factDoanhSo` | `Mã Sản Phẩm` | `dimProduct` | `Mã sản phẩm` | `` | `` | `` |
| `dimProduct` | `Nhóm` | `dimSubCategory` | `Nhóm` | `` | `` | `` |
| `factChbhChatOmni` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factChbhChatOmni` | `Nguồn CHBH` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factChbhChatOmni` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhChatOmni` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhChatOmniDscm` | `Date,Mail` | `dimEmp` | `Mail,Date` | `` | `` | `` |
| `factChbhChatOmniDscm` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factChbhChatOmniDscm` | `Khung thời gian` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `factChbhChatOmniDscm` | `Nguồn CHBH` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factDoanhSoFull` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factDoanhSoFull` | `Skus` | `dimProduct` | `Mã sản phẩm` | `` | `` | `` |
| `dimShop` | `REGION` | `dimRegion` | `REGION` | `` | `` | `` |
| `factDhtcFull` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factVoucher` | `Số đơn hàng Ecom` | `factDHBe` | `Mã đơn hàng ECOM` | `` | `` | `` |
| `factDHBe` | `Mã đơn hàng ECOM` | `dim_tran_extra` | `Order Code` | `` | `` | `` |
| `factDoanhSo` | `Số đơn hàng Ecom` | `dim_tran_extra` | `Order Code` | `` | `` | `` |
| `factDoanhSo` | `Giờ mua` | `dimDuration` | `Khung thời gian` | `` | `` | `` |
| `target_date` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factDoanhSoFull` | `Vùng` | `dimRegion` | `REGION` | `` | `` | `` |
| `factVoucher` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `dimDate` | `Date` | `lunar_calendar` | `solar_date` | `` | `` | `` |
| `factDoanhSo_2021` | `Mã Sản Phẩm` | `dimProduct` | `Mã sản phẩm` | `` | `` | `` |
| `factDoanhSo_2021` | `Mã Shop` | `dimShop` | `SHOPCODE` | `` | `` | `` |
| `factDoanhSo_2021` | `Ngày Mua` | `dimDate` | `Date` | `` | `` | `` |
| `factDoanhSo_2021` | `Nguồn` | `dimBehavior` | `Nhóm hành vi KH` | `` | `` | `` |
| `factDHBe_2021` | `Date` | `dimDate` | `Date` | `` | `` | `` |
| `factDHBe_2021` | `Mã Shop` | `dimShop` | `SHOPCODE` | `` | `` | `` |
| `factDHBe_2021` | `Nguồn đơn` | `dimBehavior` | `Nhóm hành vi KH` | `` | `` | `` |
| `factDoanhSo` | `Phân khúc` | `dimPhanKhuc` | `Phân khúc` | `` | `` | `` |
| `dimTargetJP` | `ORDERFINAL` | `dimSource` | `ORDERFINAL` | `` | `` | `` |
| `factDHBe` | `RECEIVE_FORM_ST` | `dimDelivery` | `BE` | `` | `` | `` |
| `factFlashSale` | `TRANSACTION_DATE` | `dimDate` | `Date` | `` | `` | `` |

## Modeling interpretation

The relationship layer is the mechanism that allows dimensions to filter facts and enables consistent slicing across business processes.
