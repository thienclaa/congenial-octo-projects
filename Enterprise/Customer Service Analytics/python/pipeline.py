"""
Customer Service Analytics Platform
----------------------------------

Daily ETL Pipeline

This module orchestrates the execution of all ETL processes used to build
the Customer Service Analytics semantic model.

Production implementation simplified for portfolio.
"""

from etl_steps import (
    etl_cus_to_coor,
    etl_coor_to_sup,
    etl_cus_to_support,
    etl_cus_to_transfer,
    etl_transfer_to_support,
    etl_session_waiting_duration,
    etl_session_start_end,
    etl_end_to_end,
    etl_night_session_stats,
    etl_all_steps,
)


def run_daily_pipeline():
    """
    Execute the complete ETL workflow.

    Execution order is important because downstream datasets depend on
    previously generated fact tables.
    """

    print("Starting Customer Service Analytics ETL...")

    etl_cus_to_coor()

    etl_coor_to_sup()

    etl_cus_to_support()

    etl_cus_to_transfer()

    etl_transfer_to_support()

    etl_session_waiting_duration()

    etl_session_start_end()

    etl_end_to_end()

    etl_night_session_stats()

    etl_all_steps()

    print("ETL completed successfully.")


if __name__ == "__main__":
    run_daily_pipeline()
