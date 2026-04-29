import 'package:flutter/material.dart';

/// =============================
/// データモデル（UI専用）
/// =============================

class PokemonState {
  String name;
  String ability;
  String item;
  List<Move> moves;

  Map<String, int> evs;
  Map<String, double> nature;
  Map<String, int> ranks;

  PokemonState({
    required this.name,
    required this.ability,
    required this.item,
    required this.moves,
    required this.evs,
    required this.nature,
    required this.ranks,
  });

  factory PokemonState.initial() {
    return PokemonState(
      name: "",
      ability: "なし",
      item: "なし",
      moves: [],
      evs: {
        "HP": 0,
        "A": 0,
        "B": 0,
        "C": 0,
        "D": 0,
        "S": 0,
      },
      nature: {
        "A": 1.0,
        "B": 1.0,
        "C": 1.0,
        "D": 1.0,
        "S": 1.0,
      },
      ranks: {
        "A": 0,
        "B": 0,
        "C": 0,
        "D": 0,
        "S": 0,
      },
    );
  }
}

class Move {
  final String name;
  final String type;
  final int power;
  final String category;

  Move(this.name, this.type, this.power, this.category);
}

/// =============================
/// ダミー計算ロジック
/// =============================

class DamageResult {
  final int min;
  final int max;

  DamageResult(this.min, this.max);
}

class DamageCalculator {
  static DamageResult calculate(
      PokemonState atk, PokemonState def, Move move) {
    // ダミー
    return DamageResult(50, 80);
  }
}

/// =============================
/// メイン画面
/// =============================

class MatchUI extends StatefulWidget {
  const MatchUI({super.key});

  @override
  State<MatchUI> createState() => _MatchUIState();
}

class _MatchUIState extends State<MatchUI> {
  PokemonState attacker = PokemonState.initial();
  PokemonState defender = PokemonState.initial();

  void recalc() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PokéMatch")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PokemonSection(
              title: "自ポケ",
              state: attacker,
              onChanged: (s) {
                attacker = s;
                recalc();
              },
            ),
            const Divider(),
            PokemonSection(
              title: "敵ポケ",
              state: defender,
              onChanged: (s) {
                defender = s;
                recalc();
              },
            ),
            const Divider(),
            DamageSection(attacker: attacker, defender: defender),
          ],
        ),
      ),
    );
  }
}

/// =============================
/// ポケモンセクション
/// =============================

class PokemonSection extends StatelessWidget {
  final String title;
  final PokemonState state;
  final Function(PokemonState) onChanged;

  const PokemonSection({
    super.key,
    required this.title,
    required this.state,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18)),

        /// 名前入力
        TextField(
          decoration: const InputDecoration(labelText: "Pokemon Name"),
          onChanged: (v) {
            final newState = PokemonState.initial();
            newState.name = v;
            onChanged(newState);
          },
        ),

        /// 特性・持ち物
        Row(
          children: [
            Expanded(child: DropdownButton<String>(
              value: state.ability,
              items: ["なし", "特性A"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {
                state.ability = v!;
                onChanged(state);
              },
            )),
            Expanded(child: DropdownButton<String>(
              value: state.item,
              items: ["なし", "こだわりハチマキ"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {
                state.item = v!;
                onChanged(state);
              },
            )),
          ],
        ),

        /// ステータス
        Column(
          children: state.evs.keys.map((k) {
            return StatSliderRow(
              label: k,
              value: state.evs[k]!,
              onChanged: (v) {
                state.evs[k] = v;
                onChanged(state);
              },
            );
          }).toList(),
        ),

        /// 技
        Wrap(
          children: state.moves.map((m) => MoveCard(move: m)).toList(),
        ),
      ],
    );
  }
}

/// =============================
/// ステータス行
/// =============================

class StatSliderRow extends StatelessWidget {
  final String label;
  final int value;
  final Function(int) onChanged;

  const StatSliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 40, child: Text(label)),
        Expanded(
          child: Slider(
            min: 0,
            max: 32,
            value: value.toDouble(),
            divisions: 32,
            onChanged: (v) => onChanged(v.toInt()),
          ),
        ),
        Text(value.toString()),
      ],
    );
  }
}

/// =============================
/// 技カード
/// =============================

class MoveCard extends StatelessWidget {
  final Move move;

  const MoveCard({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(move.name),
        subtitle: Text("${move.type} / ${move.power}"),
      ),
    );
  }
}

/// =============================
/// ダメージ表示
/// =============================

class DamageSection extends StatelessWidget {
  final PokemonState attacker;
  final PokemonState defender;

  const DamageSection({
    super.key,
    required this.attacker,
    required this.defender,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Damage"),

        /// 攻撃→防御
        ...attacker.moves.map((m) {
          final result = DamageCalculator.calculate(attacker, defender, m);
          return DamageBar(result: result, label: m.name);
        }),

        const Divider(),

        /// 防御→攻撃
        ...defender.moves.map((m) {
          final result = DamageCalculator.calculate(defender, attacker, m);
          return DamageBar(result: result, label: m.name);
        }),
      ],
    );
  }
}

/// =============================
/// ダメージバー
/// =============================

class DamageBar extends StatelessWidget {
  final DamageResult result;
  final String label;

  const DamageBar({
    super.key,
    required this.result,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        LinearProgressIndicator(
          value: result.max / 100,
        ),
        Text("${result.min}% ~ ${result.max}%"),
      ],
    );
  }
}