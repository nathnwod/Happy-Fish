import os
import psycopg
from psycopg.rows import dict_row
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

load_dotenv()

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_connection():
    return psycopg.connect(os.environ["DATABASE_URL"], row_factory=dict_row)

@app.get("/")
def home():
    return {"message": "Happy Fish backend is alive"}

@app.get("/species")
def get_species():
    with get_connection() as conn:
        rows = conn.execute("SELECT * FROM species ORDER BY name").fetchall()
    return rows

@app.get("/tank_sizes")
def get_tank_sizes():
    with get_connection() as conn:
        rows = conn.execute("SELECT * FROM tank_sizes ORDER BY gallons").fetchall()
    return rows