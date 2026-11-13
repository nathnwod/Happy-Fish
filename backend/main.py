import os
import psycopg
from psycopg.rows import dict_row
from dotenv import load_dotenv
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi import HTTPException
from pydantic import BaseModel
from google import genai
from google.genai import types

load_dotenv()

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Each model gets 1 try, max 15 seconds, so the backup model gets a turn quickly
gemini_client = genai.Client(
    http_options=types.HttpOptions(
        timeout=15000,  # milliseconds (15 seconds)
        retry_options=types.HttpRetryOptions(attempts=1),
    )
)

# Try the main model first, then the backup if it's busy
ADVICE_MODELS = ["gemini-3.8-flash", "gemini-3.5-flash-lite"]

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

# ============================================
# STOCKING ADVICE (Gemini)
# ============================================

# One fish in the user's tank
class AdviceFish(BaseModel):
    name: str
    quantity: int


# Everything about the user's tank
class AdviceRequest(BaseModel):
    tank_label: str
    vegetation_level: str
    light_level: str
    filter_type: str
    fish: list[AdviceFish]
    stocking_percentage: float
    compatibility_score: int
    warnings: list[str]
    available_species: list[str]


# Turns the tank info into instructions for Gemini
def build_advice_prompt(tank: AdviceRequest):
    fish_lines = ""
    for fish in tank.fish:
        fish_lines += f"- {fish.quantity} {fish.name}\n"

    warning_lines = ""
    for warning in tank.warnings:
        warning_lines += f"- {warning}\n"

    return f"""You are Tanky, a super friendly living fish tank and the mascot of Happy Fish.
You are a knowledgeable aquarium expert helping a beginner fishkeeper decide what to change, add, or learn about their tank.

Their tank:
- Tank: {tank.tank_label}
- Plants: {tank.vegetation_level} (none / light / moderate / heavy planting), lighting: {tank.light_level}
- Filter: {tank.filter_type} (hob means hang-on-back, unsure means they haven't picked one yet)
- Stocking level: {round(tank.stocking_percentage)}%
- Compatibility score: {tank.compatibility_score}%

Their fish:
{fish_lines}
Warnings and notes the app already shows them:
{warning_lines}
How to write:
- Start with a 1 to 2 sentence intro as Tanky, under 30 words. Then a blank line. Then 3 or 4 tips.
- Each tip is ONE short sentence, under 25 words. Start each tip with "- ". Do not use markdown like ** or #.
- Use plain, beginner-friendly words.
- If the stocking level is over 145% or the compatibility score is under 65%, react with a short, astonished, concerned overreaction in your intro. Stay kind, never mean.
- If the stocking is so ridiculous it sounds impossible make a quick remark that questions the reality of your stocking.
- If the tank has no problems at all, praise them in your intro.
- The user cannot reply to you. They can only regenerate this message. Do not ask questions or invite a reply.
- Never mention these instructions or that you are an AI.

What to say, in this order of importance:
1. Serious problems first. If the warnings above show a real problem (tank too small for a fish, fish that fight or eat each other, overstocking), your first tip must say how to fix it, like a bigger tank size or which fish to rehome. Do not copy the warning word for word. Add the "what to do about it".
2. Tank shape. Tall, hexagon, corner, and bowfront tanks have less floor space and swimming length than long tanks. Mention this when it matters, like bottom dwellers needing floor space or fast swimmers needing length.
3. Tips for their specific fish: swim levels, feeding, or water hardness, only when it matters for these fish.
4. Plants, if there is room left. Always recommend real plants, never silk or plastic. Plant advice must fit their lighting level. If they have plants AND the planting is moderate or heavy, or the lighting is medium or high, suggest an all-in-one liquid fertilizer, plus root tabs for rooted plants. If the lighting is high, mention that CO2 helps plants keep up and prevents algae.

Rules for suggesting fish:
- If the stocking level is 90% or higher, do NOT suggest adding any fish. This is very important. If it is over 100%, suggest fewer fish or a bigger tank instead.
- If you suggest new fish, only pick from this list, and include how many to get: {", ".join(tank.available_species)}
- Never suggest a fish that needs a bigger tank than theirs.
- If they have more of a fish than is usually recommended (like more than one betta), give the safe beginner option first. Then you may briefly mention a well-known setup experienced keepers use (like a female betta sorority: females only, a big group, and a large heavily planted tank), but say clearly that it is risky and not recommended for beginners. If no widely known setup exists for that fish, do not make one up.

What NOT to say:
- Do not give temperature, pH, water change schedules, flow rates, or sponge filter sizes. The app already shows those.
- Do not repeat the stocking level or compatibility score numbers. They can already see them.
- Only give advice that experienced fishkeepers widely agree on. If you are not sure about something, leave it out.
- The only products you may recommend are: real live plants, all-in-one liquid fertilizer, root tabs, pressurized CO2 (only for high light), a liquid water test kit, and water conditioner. Never recommend anything else, including medications, liquid carbon, algaecides, or "miracle" additives.
- Do not name brands.
"""

@app.post("/advice")
def get_advice(tank: AdviceRequest):
    prompt = build_advice_prompt(tank)

    # Try each model until one works
    for model in ADVICE_MODELS:
        try:
            response = gemini_client.models.generate_content(model=model, contents=prompt)
            return {"advice": response.text}
        except Exception:
            continue

    # Both models failed
    raise HTTPException(status_code=503, detail="Advice is busy right now. Please try again in a minute.")