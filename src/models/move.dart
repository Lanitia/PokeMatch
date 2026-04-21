enum MoveCategory { physical, special, status }

class Move {
  final String name;
  final String type;
  final MoveCategory category;
  final int? power;
  final int accuracy;
  final int priority;

  const Move({
    required this.name,
    required this.type,
    required this.category,
    this.power,
    required this.accuracy,
    required this.priority,
  });
}