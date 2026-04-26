import 'package:models/base_status.dart';

class StatCalculator {
  static Stats calculate({
    required Stats baseStats,
    required Stats evs,
    required Nature nature,
    int level = 50,
    Stats? itemModifier,
  }) {
    return Stats(
      hp: _calcHp(baseStats.hp, evs.hp, level),
      attack: _calcOther(baseStats.attack, evs.attack, level, nature.get(StatType.attack), itemModifier?.attack ?? 1.0),
      defense: _calcOther(baseStats.defense, evs.defense, level, nature.get(StatType.defense), itemModifier?.defense ?? 1.0),
      spAttack: _calcOther(baseStats.spAttack, evs.spAttack, level, nature.get(StatType.spAttack), itemModifier?.spAttack ?? 1.0),
      spDefense: _calcOther(baseStats.spDefense, evs.spDefense, level, nature.get(StatType.spDefense), itemModifier?.spDefense ?? 1.0),
      speed: _calcOther(baseStats.speed, evs.speed, level, nature.get(StatType.speed), itemModifier?.speed ?? 1.0),
    );
  }

  static int _calcHp(int base, int ev, int level) {
    return (((base * 2 + ev ~/ 4) * level) ~/ 100) + level + 10;
  }

  static int _calcOther(int base, int ev, int level, double nature, double item) {
    final value = (((base * 2 + ev ~/ 4) * level) ~/ 100) + 5;
    return (value * nature * item).floor();
  }
}