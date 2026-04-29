import 'package:poke_match/models/base_status.dart';
import 'package:poke_match/logic/modifier/modifier.dart';

class ModifierCalculator {
  static BaseStats applyModifiers(
    BaseStats base,
    List<StatModifier> modifiers,
  ) {
    return BaseStats(
      H: base.H,
      A: modifiers.fold(base.A.toDouble(), (acc, mod) { 
          final value = mod.apply(StatType.A);
          if (value == 1.0) return acc;
          return (acc * value).floorToDouble();
        }).toInt(),
      B: modifiers.fold(base.B.toDouble(), (acc, mod) {
          final value = mod.apply(StatType.B);
          if (value == 1.0) return acc;
          return (acc * value).floorToDouble();
        }).toInt(),
      C: modifiers.fold(base.C.toDouble(), (acc, mod) {
          final value = mod.apply(StatType.C);
          if (value == 1.0) return acc;
          return (acc * value).floorToDouble();
        }).toInt(),
      D: modifiers.fold(base.D.toDouble(), (acc, mod) {
          final value = mod.apply(StatType.D);
          if (value == 1.0) return acc;
          return (acc * value).floorToDouble();
        }).toInt(),
      S: modifiers.fold(base.S.toDouble(), (acc, mod) {
          final value = mod.apply(StatType.S);
          if (value == 1.0) return acc;
          return (acc * value).floorToDouble();
        }).toInt(),
    );
  }
}