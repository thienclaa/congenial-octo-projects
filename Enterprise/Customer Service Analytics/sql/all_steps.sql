WITH all_steps AS (

    SELECT ...
    FROM customer_to_coordinator

    UNION ALL

    SELECT ...
    FROM coordinator_to_support

    UNION ALL

    SELECT ...
    FROM customer_to_support

    UNION ALL

    SELECT ...
    FROM customer_to_transfer

    UNION ALL

    SELECT ...
    FROM transfer_to_support

)

SELECT
    *
FROM all_steps;
