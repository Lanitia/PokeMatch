class StatRange {
  final int min;
  final int custom;
  final int max;

  StatRange(this.min, this.custom, this.max);
}

class StatCalculate {
  static const int individualValue = 31;
  static const int level = 50;

  int _calculate(int baseStat, int effort, int natureModifier) {
    return (((((baseStat * 2 + individualValue + effort * 2) * level) ~/ 100) + 60) * natureModifier) * itemModifier;
  }

  StatRange calculateRange(int baseStat, int effort, {double natureModifier = 1.0}, {double itemModifier = 1.0}) {
    final min = _calculate(baseStat, 0, natureModifier);
    final custom = _calculate(baseStat, effort, natureModifier);
    final max = _calculate(baseStat, 32, 1.1);

    return StatRange(min, custom, max);
  }
}

class HpCalculate extends StatCalculate {
  @override
  int _calculate(int baseStat, int effort, int natureModifier) {
    return (((baseStat * 2 + individualValue + effort * 2) * level) ~/ 100) + level + 10;
  }
}