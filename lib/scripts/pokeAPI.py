import json
import requests
import sqlite3
import time

with open("pokemon_list.json", "r", encoding="utf-8") as f:
    data = json.load(f)
jp_names = list(set([p["name"] for p in data]))

"""
def fetch_species_mapping(limit=1024):
    url = f"https://pokeapi.co/api/v2/pokemon-species?limit={limit}"
    res = requests.get(url).json()

    mapping = {}

    for item in res["results"]:
        detail = requests.get(item["url"]).json()

        jp_name = None
        en_name = detail["name"]

        for n in detail["names"]:
            if n["language"]["name"] == "ja":
                jp_name = n["name"]
                print(jp_name)
                break

        if jp_name:
            mapping[jp_name] = en_name

        time.sleep(0.2)  # レート制御


    with open("species_mapping.json", "w", encoding="utf-8") as f:
        json.dump(mapping, f, ensure_ascii=False, indent=2)

    return mapping
"""



def fetch_pokemon(en_name):
    url = f"https://pokeapi.co/api/v2/pokemon/{en_name}"
    try:
        return requests.get(url).json()
    except Exception as e:
        print(f"Error fetching {en_name}: {e}")
        return None

conn = sqlite3.connect("../data/pokemon.db")
cur = conn.cursor()

cur.execute("""
CREATE TABLE IF NOT EXISTS pokemon (
    id INTEGER PRIMARY KEY,
    jp_name TEXT,
    en_name TEXT,
    types TEXT,
    base_stats TEXT,
    moves TEXT,
    sprite_url TEXT,
    weight DECIMAL(10, 1)
)
""")

with open("species_mapping.json", "r", encoding="utf-8") as f:
    mapping = json.load(f)

for jp_name in jp_names:
    en_name = mapping.get(jp_name)

    if not en_name:
        print(f"skip: {jp_name}")
        continue

    data = fetch_pokemon(en_name)

    if not data:
        print(f"Failed to fetch data for {jp_name} ({en_name})")
        continue

    types = [t["type"]["name"] for t in data["types"]]

    moves = [m["move"]["name"] for m in data["moves"]]

    stats = {
        s["stat"]["name"]: s["base_stat"]
        for s in data["stats"]
    }

    cur.execute("""
        INSERT OR REPLACE INTO pokemon
        (id, jp_name, en_name, types, moves, base_stats, sprite_url, weight)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    """, (
        data["id"],
        jp_name,
        en_name,
        json.dumps(types),
        json.dumps(moves),
        json.dumps(stats),
        data["sprites"]["front_default"],
        data["weight"]
    ))

    conn.commit()
    time.sleep(0.2)