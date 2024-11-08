import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game.dart';

class GameOverScreen extends StatelessWidget {
  final int score;

  const GameOverScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Game Over')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Game Over', style: TextStyle(fontSize: 36)),
            Text('Score: $score', style: const TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {
                // Restart game logic
                Navigator.pop(context);
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
