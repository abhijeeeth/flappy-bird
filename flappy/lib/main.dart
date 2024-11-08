import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flappy Bird',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GameWidget(game: FlappyBirdGame()),
    );
  }
}
