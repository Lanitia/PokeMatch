import 'dart:io';
import 'package:data/pokemon.dart';
import 'package:sqflite/sqflite.dart';

enum StatType { hp, attack, defense, spAttack, spDefense, speed }

class StatCalculator {
  static int calculate({
    required StatType type,
    required int base,
    int iv = 31,
    int ev = 0,
    int level = 50,
    double nature = 1.0,
  }) {
    if (type == StatType.hp) {
      return ((base * 2 + iv + (ev ~/ 4)) * level ~/ 100) + level + 10;
    } else {
      return (((base * 2 + iv + (ev ~/ 4)) * level ~/ 100) + 5) *
          nature ~/ 1;
    }
  }
}

void main() {
  final dbPath = 'data/pokemon.db';

  if (!File(dbPath).existsSync()) {
    print('DBファイルが存在しません: $dbPath');
    return;
  }


  stdout.write('ポケモン名を入力: ');
  final input = stdin.readLineSync();

  if (input == null || input.isEmpty) {
    print('入力が不正です');
    db.dispose();
    return;
  }

  // テーブル構造は以下を想定
  // pokemon(name TEXT, hp INT, attack INT, defense INT, sp_attack INT, sp_defense INT, speed INT)
  final stmt = db.prepare('''
    SELECT base_stats
    FROM pokemon
    WHERE jp_name = ?
  ''');

  final result = stmt.select([input]);

  if (result.isEmpty) {
    print('ポケモンが見つかりません');
    stmt.dispose();
    db.dispose();
    return;
  }

  final row = result.first;
  final baseStatsJson = row['base_stats'] as String;

  print(baseStatsJson);

  // JSONパース
  // final Map<String, dynamic> json = jsonDecode(baseStatsJson);

  final baseStats = {
    StatType.hp: row['hp'] as int,
    StatType.attack: row['attack'] as int,
    StatType.defense: row['defense'] as int,
    StatType.spAttack: row['sp_attack'] as int,
    StatType.spDefense: row['sp_defense'] as int,
    StatType.speed: row['speed'] as int,
  };

  final realStats = <StatType, int>{};

  baseStats.forEach((type, base) {
    realStats[type] = StatCalculator.calculate(
      type: type,
      base: base,
    );
  });

  print('\n実数値（Lv50 / IV31 / EV0）');
  realStats.forEach((stat, value) {
    print('${stat.name}: $value');
  });

  stmt.dispose();
  db.dispose();
}