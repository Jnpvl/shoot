import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/material.dart';
import 'package:shoot/game/my_game.dart';
import 'duck.dart';

class Bullet extends CircleComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  Vector2 direction;

  Bullet({required this.direction})
      : super(
          radius: 5,
          paint: Paint()..color = Colors.yellow,
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(CircleHitbox());

    final nearestDuck = _findNearestDuck();
    if (nearestDuck != null) {
      direction = (nearestDuck.position - position).normalized();
    }
  }

  Duck? _findNearestDuck() {
    Duck? nearestDuck;
    double minDistance = double.infinity;

    for (final duck in gameRef.children.whereType<Duck>()) {
      final distance = (duck.position - position).length;
      if (distance < minDistance) {
        minDistance = distance;
        nearestDuck = duck;
      }
    }

    return nearestDuck;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direction.normalized() * 300 * dt;

    if (position.x < 0 ||
        position.x > gameRef.size.x ||
        position.y < 0 ||
        position.y > gameRef.size.y) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Duck) {
      other.hit();
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }
}
