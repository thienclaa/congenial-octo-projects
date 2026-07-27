# Business Metrics

## Overview

The enterprise semantic model centralizes business calculations into reusable DAX measures supporting executive reporting across multiple business functions.

The model currently contains **477 reusable business measures** organized around different analytical domains.

---

# Sales Analytics

Representative measures include:

// Total Sales

DS - Tổng =
SUM('factDoanhSo'[Thành Tiền Trước VAT])
+
SUM('factDoanhSo_2021'[Thành Tiền Trước VAT])

// Successful Orders

DHTC - Tổng =
DISTINCTCOUNT('factDoanhSo'[Số Đơn Hàng])

// Average Order Value

AOV - Tổng =
DIVIDE(
    [DS - Tổng],
    [DHTC - Tổng],
    BLANK()
)

# Time Intelligence

The semantic model implements reusable time intelligence measures across Year, Month, and Week levels, allowing business users to analyze performance trends and period-over-period comparisons consistently across reports.
