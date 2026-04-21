class Nature {
  final String name;

  // 補正（1.1 or 0.9 or 1.0）
  final double a;
  final double b;
  final double c;
  final double d;
  final double s;

  const Nature({
    required this.name,
    this.a = 1.0,
    this.b = 1.0,
    this.c = 1.0,
    this.d = 1.0,
    this.s = 1.0,
  });
}