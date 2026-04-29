import 'package:poke_match/models/base_status.dart';


class StatCalculator {
  static BaseStats calculate({
    required BaseStats baseStats,
    required BaseStats evs,
    Map<StatType, double> nature = const {},
    int level = 50,
    Map<StatType, double>? itemModifier,
  }) {
    return BaseStats(
      H: _calcHp(baseStats.H, evs.H, level),
      A: _calcOther(baseStats.A, evs.A, level, nature[StatType.A] ?? 1.0, itemModifier?[StatType.A] ?? 1.0),
      B: _calcOther(baseStats.B, evs.B, level, nature[StatType.B] ?? 1.0, itemModifier?[StatType.B] ?? 1.0),
      C: _calcOther(baseStats.C, evs.C, level, nature[StatType.C] ?? 1.0, itemModifier?[StatType.C] ?? 1.0),
      D: _calcOther(baseStats.D, evs.D, level, nature[StatType.D] ?? 1.0, itemModifier?[StatType.D] ?? 1.0),
      S: _calcOther(baseStats.S, evs.S, level, nature[StatType.S] ?? 1.0, itemModifier?[StatType.S] ?? 1.0),
    );
  }

  static int _calcHp(int base, int ev, int level) {
    return (((base * 2 + ev ~/ 4) * level) ~/ 100) + level + 10;
  }

  static int _calcOther(int base, int ev, int level, double nature, double item) {
    final value = (((base * 2 + ev ~/ 4) * level) ~/ 100) + 5;
    return ((value * nature).floor() * item).floor();
  }
}