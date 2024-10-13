import psycopg
import os
from psycopg.rows import dict_row

DATABASE_URI = os.getenv('POSTGRES_URL')


def get_query(query, params=None, mul=True):
    try:
        if DATABASE_URI is None:
            raise ValueError("DATABASE_URI is not set.")
        
        with psycopg.connect(DATABASE_URI) as conn:
            with conn.cursor(row_factory=dict_row) as cur:

                if params:
                    cur.execute(query, params)
                else:
                    cur.execute(query)
                    
                if mul:
                    result = cur.fetchall()
                elif not mul:
                    result = cur.fetchone()
                return result
            
    except psycopg.OperationalError as e:
        print(f"Connection failed: {e}")


def execute_query(query, params):
    try:
        if DATABASE_URI is None:
            raise ValueError("DATABASE_URI is not set.")
        
        with psycopg.connect(DATABASE_URI) as conn:
            with conn.cursor() as cur:

                cur.execute(query, params)
                conn.commit()

    except psycopg.OperationalError as e:
        print(f"Connection failed: {e}")


def execute_query_blob(query, params):
    try:
        if DATABASE_URI is None:
            raise ValueError("DATABASE_URI is not set.")
        
        with psycopg.connect(DATABASE_URI) as conn:
            with conn.cursor() as cur:
                cur.execute(query, params, binary=True)
                conn.commit()

    except psycopg.OperationalError as e:
        print(f"Connection failed: {e}")


def roll():
    return True