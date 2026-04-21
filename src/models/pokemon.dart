import 'base_stats.dart';
import 'move.dart';

class Pokemon {
  final int id;
  final String name;

  // タイプ（最大2）
  final List<String> types;

  // 種族値
  final BaseStats baseStats;

  // 特性（複数）
  final List<String> abilities;

  // 重さ（kg）
  final double weight;

  // 覚える技（ID参照）
  final List<int> moveIds;

  const Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.baseStats,
    required this.abilities,
    required this.weight,
    required this.moveIds,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'] as int,
      name: json['name'] as String,
      types: List<String>.from(json['types']),
      baseStats: BaseStats.fromJson(json['baseStats']),
      abilities: List<String>.from(json['abilities']),
      weight: (json['weight'] as num).toDouble(),
      moveIds: List<int>.from(json['moveIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'types': types,
      'baseStats': baseStats.toJson(),
      'abilities': abilities,
      'weight': weight,
      'moveIds': moveIds,
    };
  }
}
