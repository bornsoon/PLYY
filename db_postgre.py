import psycopg
import os

DATABASE_URI = os.getenv('DATABASE_URL_SSL_PRFFER')


def get_query(query, params=None, mul=True):
    with psycopg.connect(DATABASE_URI) as conn:
        with conn.cursor() as cur:

            if params:
                cur.execute(query, params)
            else:
                cur.execute(query)
                
            if mul:
                result = cur.fetchall()
            else:
                result = cur.fetchone()

            return result


def execute_query(query, params):
    with psycopg.connect(DATABASE_URI) as conn:
        with conn.cursor() as cur:

            cur.execute(query, params)
            conn.commit()