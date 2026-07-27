"""
Database Utilities
------------------

Shared database helper functions used by ETL modules.

Connection details have been removed for portfolio purposes.
"""

import pyodbc


def get_connection():
    """
    Create SQL Server connection.

    Production credentials removed.
    """

    connection = pyodbc.connect(

        DRIVER="{ODBC Driver 17 for SQL Server}",

        SERVER="<SERVER>",

        DATABASE="<DATABASE>",

        UID="<USERNAME>",

        PWD="<PASSWORD>",

        TrustServerCertificate="yes"

    )

    return connection


def execute_sql(sql):

    conn = get_connection()

    cursor = conn.cursor()

    cursor.execute(sql)

    conn.commit()

    cursor.close()

    conn.close()


def execute_many(sql_list):

    conn = get_connection()

    cursor = conn.cursor()

    for sql in sql_list:

        cursor.execute(sql)

    conn.commit()

    cursor.close()

    conn.close()


def fetch_dataframe(sql):

    import pandas as pd

    conn = get_connection()

    df = pd.read_sql(sql, conn)

    conn.close()

    return df


def insert_dataframe(df, table_name):

    """
    Placeholder for dataframe loading.

    Production implementation removed.
    """

    pass
