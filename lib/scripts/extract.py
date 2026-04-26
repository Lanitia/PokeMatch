# pokemon_data.json から regulation-m-a に該当するポケモンを抽出して pokemon_list.json に保存するスクリプト

import json

INPUT_FILE = "pokemon_data.json"
OUTPUT_FILE = "pokemon_list.json"

TARGET_REGULATION = "regulation-m-a"

def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def save_json(path, data):
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

def filter_pokemon(data):
    result = []

    for p in data:
        # regulationIds が存在しない場合はスキップ
        if "regulationIds" not in p:
            continue

        # 条件一致チェック
        if TARGET_REGULATION not in p["regulationIds"]:
            continue


        # 必要なフィールドだけ抽出
        filtered = {
            "name": p.get("name"),
            "isMega": p.get("isMega"),
            "single_rank": p.get("single_rank"),
        }

        if "form" in p and p["form"] is not None:
            filtered["form"] = p.get("form")

        result.append(filtered)

    return result

def main():
    data = load_json(INPUT_FILE)

    # 入力が辞書ではなくリスト前提（ポケモン一覧）
    if not isinstance(data, list):
        raise ValueError("JSONの最上位は配列（list）である必要があります")

    filtered = filter_pokemon(data)
    save_json(OUTPUT_FILE, filtered)

    print(f"完了: {len(filtered)} 件を書き出しました -> {OUTPUT_FILE}")

if __name__ == "__main__":
    main()