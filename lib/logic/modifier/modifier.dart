import 'package:poke_match/models/base_status.dart';

abstract class StatModifier {
  double apply(StatType type);
}