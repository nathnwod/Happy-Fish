import os
import psycopg
from psycopg.rows import dict_row
from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()

app = FastAPI()

def get_connection():
    return psycopg.connect(os.environ["DATABASE_URL"], row_factory=dict_row)

@app.get("/")
def home():
    return {"message": "Happy Fish backend is alive"}

@app.get("/species")
def get_species():
    with get_connection() as conn:
        rows = conn.execute("SELECT * FROM species").fetchall()
    return rows