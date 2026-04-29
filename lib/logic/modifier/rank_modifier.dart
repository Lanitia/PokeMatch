import 'modifier.dart';
import 'package:poke_match/models/base_status.dart';

class RankModifier implements StatModifier {
  final Map<StatType, int> ranks;

  RankModifier(this.ranks);

  @override
  double apply(StatType type) {
    final rank = ranks[type] ?? 0;
    if (rank >= 0) {
      return (2 + rank) / 2;
    } else {
      return 2 / (2 - rank);
    }
  }
}