from datetime import timedelta

from dagster import asset

from .functions import (
    run_daily_pipeline,
)
from .database import (
    fetch_dataframe,
    get_connection,
)


@asset
def get_processing_date():

    sql = """
    SELECT MAX(processing_date)
    FROM <target_table>
    """

    # Production query removed.

    return {
        "start_date": None,
        "end_date": None,
    }


@asset
def run_chat_etl(get_processing_date):

    conn = get_connection()

    try:

        results = run_daily_pipeline(
            conn=conn,
            run_date=get_processing_date,
        )

        return results

    finally:

        conn.close()
