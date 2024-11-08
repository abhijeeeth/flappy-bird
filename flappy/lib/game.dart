import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'dart:math';

class FlappyBirdGame extends FlameGame {
  late final Bird bird;
  late final PipeSpawner pipeSpawner;
  late final Background background;
  int score = 0;

  @override
  Future<void> onLoad() async {
    background = Background();
    add(background);
    bird = Bird();
    add(bird);
    pipeSpawner = PipeSpawner();
    add(pipeSpawner);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (bird.y < 0 || bird.y > size.y) {
      // Game Over logic
      gameOver();
    }
  }

  void gameOver() {
    // Handle game over, reset score or display end screen
  }

  @override
  void onTap() {
    bird.flap();
  }
}

class Bird extends SpriteComponent with HasGameRef {
  double velocity = 0;
  static const double gravity = 0.5;
  static const double jumpForce = -10;

  Bird() : super(size: Vector2(50, 50));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('bird.png');
    position = Vector2(100, gameRef.size.y / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity += gravity;
    position.y += velocity;

    if (position.y > gameRef.size.y) {
      position.y = gameRef.size.y;
    }
  }

  void flap() {
    velocity = jumpForce;
  }
}

class PipeSpawner extends Component with HasGameRef {
  double spawnTimer = 0;
  List<Pipe> pipes = [];

  @override
  void update(double dt) {
    super.update(dt);
    spawnTimer += dt;
    if (spawnTimer > 2) {
      spawnTimer = 0;
      spawnPipe();
    }

    pipes.forEach((pipe) => pipe.update(dt));
  }

  void spawnPipe() {
    final pipe = Pipe();
    pipes.add(pipe);
    add(pipe);
  }
}

class Pipe extends SpriteComponent with HasGameRef {
  double speed = -3;
  double topHeight = Random().nextDouble() * 100 + 150;
  double bottomHeight = 150;

  Pipe() : super(size: Vector2(80, 600));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('pipe.png');
    position = Vector2(gameRef.size.x, 0);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += speed;

    if (position.x < -width) {
      removeFromParent();
    }
  }
}

class Background extends SpriteComponent with HasGameRef {
  Background() : super(size: Vector2(600, 800));

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('background.png');
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 1;
    if (position.x < -size.x) {
      position.x = 0;
    }
  }
}
