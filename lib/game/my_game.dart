import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:shoot/components/backoground_component.dart';
import 'package:shoot/controller/score_controller.dart';
import 'package:shoot/screens/start_screen.dart';
import 'hunter.dart';
import 'duck.dart';
import 'joystick.dart';
import 'bullet.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with HasCollisionDetection {
  late Joystick _joystick;
  final Random random = Random();
  late Sprite duckSprite;
  late Sprite backgroundSprite;
  late Sprite hunterSprite;
  late BuildContext _buildContext;
  final ScoreController scoreController;
  int ducksKilled = 0;

  MyGame(this.scoreController);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final duckImage = await images.load('pato.png');
    duckSprite = Sprite(duckImage);

    final backgroundImage = await images.load('fondo.jpeg');
    backgroundSprite = Sprite(backgroundImage);

    final hunterImage = await images.load('hunter.png');
    hunterSprite = Sprite(hunterImage);

    add(BackgroundComponent(backgroundSprite));

    _joystick = Joystick(
      knobPaint: Paint()..color = Colors.red,
      backgroundPaint: Paint()..color = Colors.grey.withAlpha(100),
      position: Vector2(50, size.y - 110),
    );
    add(_joystick);

    add(Hunter(hunterSprite));

    for (int i = 0; i < 5; i++) {
      add(Duck(duckSprite));
    }

    add(ButtonComponent(
      position: Vector2(size.x - 100, size.y - 100),
      size: Vector2(80, 80),
      button: CircleComponent(radius: 40, paint: Paint()..color = Colors.red),
      onPressed: () {
        final hunter = children.whereType<Hunter>().first;
        add(Bullet(direction: hunter.direction.normalized())
          ..position = hunter.position);
      },
    ));
  }

  void setBuildContext(BuildContext context) {
    _buildContext = context;
  }

  void showGameOverPopup() {
    showDialog(
      context: _buildContext,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You have been caught by a duck.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StartScreen(),
                  ),
                );
              },
              child: Text('Back to Start'),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    children.whereType<Hunter>().forEach((component) {
      component.removeFromParent();
    });
    children.whereType<Duck>().forEach((component) {
      component.removeFromParent();
    });
    children.whereType<Bullet>().forEach((component) {
      component.removeFromParent();
    });

    scoreController.resetScore();
    ducksKilled = 0;
    Duck.baseSpeed = 1.0;
    print('Duck base speed reset to: ${Duck.baseSpeed}');

    onLoad();
    resumeEngine();
  }

  Joystick get joystick => _joystick;
}
