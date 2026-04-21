import 'package:flutter/material.dart';

class MatchUI extends StatefulWidget {
  const MatchUI({super.key});

  @override
  State<MatchUI> createState() => _MatchUIState();
}

class _MatchUIState extends State<MatchUI> {
  final TextEditingController _controller = TextEditingController();
  String _output = "";

  void _handleSubmit(String value) {
    setState(() {
      _output = value;
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeMatch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: _handleSubmit,
              decoration: const InputDecoration(
                labelText: 'ポケモン名を入力',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _output,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}