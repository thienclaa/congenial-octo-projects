/*
===============================================================================
Enterprise Sales Analytics Platform

Description
-----------
Builds a Flash Sale analytical dataset by integrating promotion transactions,
sales, product, payment, order channel, and store dimensions.

This public version has been simplified to remove proprietary schemas and
internal business identifiers.

Technology
----------
SQL Server
INNER JOIN
LEFT JOIN
Business Rule Filtering

===============================================================================
*/

SELECT

    promo.date_key,

    promo.promotion_code,
    promotion.promotion_name,

    promo.created_date,
    promo.transaction_date,

    promo.order_number,

    promo.product_code,

    product.product_name,
    product.product_category,
    product.product_group,
    product.brand_name,

    backend.payment_method,

    channel.order_channel,

    store.region,

    promo.quantity,
    promo.unit_name,

    promo.promotion_discount,

    sales.list_price,
    sales.sales_amount,
    sales.sales_amount_before_vat

FROM fact_promotion_transaction promo

INNER JOIN fact_sales_transaction sales

    ON promo.order_number = sales.ecommerce_order_number

INNER JOIN (

    SELECT
        ecommerce_order_number

    FROM fact_sales_transaction

    WHERE sales_amount_before_vat <> 0

    GROUP BY ecommerce_order_number

    HAVING SUM(sales_amount_before_vat) > 1000

) successful_orders

    ON sales.ecommerce_order_number = successful_orders.ecommerce_order_number

INNER JOIN dim_product product

    ON sales.product_key = product.product_key
    AND promo.product_code = product.product_code

LEFT JOIN fact_sales_backend backend

    ON promo.order_number = backend.ecommerce_order_number

INNER JOIN dim_promotion promotion

    ON promotion.promotion_code = promo.promotion_code

INNER JOIN dim_order_channel channel

    ON channel.order_channel_key = promo.order_channel

INNER JOIN dim_store store

    ON store.store_code = promo.store_code

WHERE

    promotion.program_type = 'Flash Sale'

    AND channel.data_source = 'Enterprise'

    AND promo.transaction_date >= @StartDate;
