"""
Database Utilities
------------------

Reusable SQL Server helpers for the ETL pipeline.

Production connection details are loaded from environment variables
and are never committed to source control.
"""

import pyodbc
import pandas as pd

from .config import DATABASE_CONFIG


def get_connection():
    """Create a SQL Server connection."""

    return pyodbc.connect(
        DRIVER=f"{{{DATABASE_CONFIG['driver']}}}",
        SERVER=DATABASE_CONFIG["server"],
        DATABASE=DATABASE_CONFIG["database"],
        UID=DATABASE_CONFIG["username"],
        PWD=DATABASE_CONFIG["password"],
        TrustServerCertificate="yes",
    )


def execute_sql(sql: str, params=None):
    """Execute a SQL statement."""

    conn = get_connection()

    try:
        cursor = conn.cursor()

        if params:
            cursor.execute(sql, params)
        else:
            cursor.execute(sql)

        conn.commit()

    except Exception:
        conn.rollback()
        raise

    finally:
        cursor.close()
        conn.close()


def fetch_dataframe(sql: str, params=None) -> pd.DataFrame:
    """Execute a SELECT query and return a DataFrame."""

    conn = get_connection()

    try:
        return pd.read_sql_query(
            sql,
            conn,
            params=params,
        )

    finally:
        conn.close()


def insert_dataframe(
    df: pd.DataFrame,
    table_name: str,
    engine=None,
):
    """
    Load a DataFrame into a target table.

    Production-specific loading implementation is excluded.
    """

    raise NotImplementedError(
        "Production data-loading implementation removed."
    )
