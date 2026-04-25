class BaseStats {
  final int H;
  final int A;
  final int B;
  final int C;
  final int D;
  final int S;

  const BaseStats({
    required this.H,
    required this.A,
    required this.B,
    required this.C,
    required this.D,
    required this.S,
  });

  factory BaseStats.fromJson(Map<String, dynamic> json) {
    return BaseStats(
      H: json['H'],
      A: json['A'],
      B: json['B'],
      C: json['C'],
      D: json['D'],
      S: json['S'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'H': H,
      'A': A,
      'B': B,
      'C': C,
      'D': D,
      'S': S,
    };
  }
}
