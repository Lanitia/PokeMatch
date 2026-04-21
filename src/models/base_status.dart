class BaseStats {
  final int h;
  final int a;
  final int b;
  final int c;
  final int d;
  final int s;

  const BaseStats({
    required this.h,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.s,
  });

  factory BaseStats.fromJson(Map<String, dynamic> json) {
    return BaseStats(
      h: json['h'],
      a: json['a'],
      b: json['b'],
      c: json['c'],
      d: json['d'],
      s: json['s'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'h': h,
      'a': a,
      'b': b,
      'c': c,
      'd': d,
      's': s,
    };
  }
}
