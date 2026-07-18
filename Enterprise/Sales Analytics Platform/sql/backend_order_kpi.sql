/*
===============================================================================
Enterprise Sales Analytics Platform

File
----
backend_order_kpi.sql

Description
-----------
Build backend operational KPI dataset used for SLA monitoring, sales channel
classification, and order processing analytics.

===============================================================================
*/

SELECT DISTINCT

    O.order_number,
    O.created_datetime,
    O.first_view_datetime,
    O.store_code,
    C.order_channel,
    O.payment_method,

    CASE
        WHEN CAST(O.created_datetime AS TIME)
             BETWEEN '08:00:00' AND '21:59:59'
        THEN 'Day'
        ELSE 'Night'
    END AS work_shift,

    CASE
        WHEN O.first_view_datetime IS NULL THEN NULL
        WHEN DATEDIFF(MINUTE,
                      O.created_datetime,
                      O.first_view_datetime) < 0
        THEN 0
        ELSE DATEDIFF(MINUTE,
                      O.created_datetime,
                      O.first_view_datetime)
    END AS response_minutes,

    CASE
        WHEN O.order_source IN ('App','Website')
            THEN 'Self-Service'

        WHEN O.order_source IN ('Call','Outbound')
            THEN 'Call Center'

        WHEN O.order_source LIKE '%Chat%'
            THEN 'Live Chat'

        ELSE 'Other'
    END AS sales_channel,

    CASE

        WHEN O.first_view_datetime IS NULL
            THEN NULL

        WHEN CAST(O.created_datetime AS TIME)
             BETWEEN '08:00:00' AND '21:59:59'
             AND DATEDIFF(MINUTE,
                          O.created_datetime,
                          O.first_view_datetime) <= 5
            THEN 'Pass'

        WHEN CAST(O.created_datetime AS TIME) NOT BETWEEN '08:00:00' AND '21:59:59'
             AND CAST(O.first_view_datetime AS TIME) <= '10:00:00'
            THEN 'Pass'

        ELSE 'Fail'

    END AS sla_status

FROM fact_order_backend O

LEFT JOIN dim_order_channel C
    ON O.order_channel_key = C.order_channel_key

WHERE
    O.created_datetime >= '2025-01-01'
    AND O.order_status = 'Completed';
