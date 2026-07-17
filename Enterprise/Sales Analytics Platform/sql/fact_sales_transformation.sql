/*
===============================================================================
Enterprise Sales Analytics Platform

Description
-----------
Builds the Sales Fact dataset for the Power BI Semantic Model by integrating
sales transactions with product, store, payment, and order channel dimensions.

Note
----
This is a simplified version of the production query.
Internal schemas, proprietary business rules, and sensitive mappings have been
anonymized for confidentiality.

Technology
----------
SQL Server
CTE
LEFT JOIN
CASE WHEN
Business Rule Transformation

===============================================================================
*/

WITH base_data AS (

SELECT DISTINCT

    sales.invoice_number             AS order_number,
    sales.ecommerce_order_number     AS ecommerce_order_number,
    CAST(sales.transaction_date AS DATE) AS transaction_date,

    sales.employee_code,

    store.store_code,

    CASE
        WHEN sales.delivery_type = 'Home Delivery'
            THEN 'Home Delivery'
        WHEN sales.delivery_type = 'Store Pickup'
            THEN 'Store Pickup'
    END AS delivery_type,

    product.product_code,

    sales.is_featured_product,

    sales.quantity,

    sales.unit_name,

    sales.standard_quantity,

    sales.standard_unit,

    sales.sales_amount_before_vat,

    success.successful_order,

    sales.order_source,

    CASE

        WHEN product.category='Cosmetics'
            AND sales.standard_quantity>=10
            THEN 'Wholesale'

        WHEN product.category='Medicine'
            AND sales.standard_quantity>=10
            THEN 'Wholesale'

        WHEN product.category='Medical Equipment'
            AND sales.standard_quantity>=10
            THEN 'Wholesale'

        ELSE 'Retail'

    END AS order_type,

    sales.payment_method,

    CASE

        WHEN sales.order_source='Call'
            THEN 'Call Center'

        WHEN sales.order_source='Outbound'
            THEN 'Outbound'

        WHEN sales.order_source='App'
            THEN 'Mobile App'

        WHEN sales.order_source='Web'
            THEN 'Website'

        WHEN sales.order_source='Chat'
            THEN 'Live Chat'

        WHEN sales.order_source='Marketplace'
            THEN 'Marketplace'

        ELSE 'Other'

    END AS sales_channel

FROM fact_sales_transaction sales

LEFT JOIN dim_product product

ON sales.product_key = product.product_key

LEFT JOIN dim_store store

ON sales.store_key = store.store_key

LEFT JOIN (

    SELECT

        ecommerce_order_number,

        1 AS successful_order

    FROM fact_sales_transaction

    WHERE

        channel='Ecommerce'

        AND transaction_date>=@StartDate

        AND sales_amount_before_vat<>0

    GROUP BY ecommerce_order_number

    HAVING SUM(sales_amount_before_vat)>1000

) success

ON sales.ecommerce_order_number=success.ecommerce_order_number

LEFT JOIN fact_sales_backend backend

ON sales.ecommerce_order_number=backend.ecommerce_order_number

LEFT JOIN dim_order_channel channel

ON backend.order_channel_key=channel.order_channel_key

WHERE

    sales.transaction_date>=@StartDate

    AND sales.sales_amount_before_vat<>0

    AND sales.channel='Ecommerce'

    AND LEFT(store.store_code,2)<>'XX'

    AND store.business_unit='Retail'

)
