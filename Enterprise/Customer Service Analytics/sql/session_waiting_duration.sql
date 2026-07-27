WITH waiting_time AS (

    SELECT

        session_id,

        agent_id,

        assign_time,

        first_response_time,

        DATEDIFF(
            SECOND,
            assign_time,
            first_response_time
        ) AS waiting_seconds

    FROM fact_chat_log

)

SELECT

    agent_id,

    AVG(waiting_seconds) AS avg_waiting_seconds,

    MAX(waiting_seconds) AS max_waiting_seconds,

    COUNT(*) AS total_sessions

FROM waiting_time

GROUP BY

    agent_id;
