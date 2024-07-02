import 'package:flame/components.dart';
import 'package:shoot/game/duck.dart';
import 'package:shoot/game/my_game.dart';
import 'package:flame/collisions.dart';

class Hunter extends SpriteComponent
    with HasGameRef<MyGame>, CollisionCallbacks {
  static const double _speed = 200;
  Vector2 direction = Vector2(1, 0);

  Hunter(Sprite sprite)
      : super(
          sprite: sprite,
          size: Vector2(50, 50),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = gameRef.size / 2;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    final joystick = gameRef.joystick;
    position.add(joystick.delta * _speed * dt);
    if (joystick.delta.length != 0) {
      direction = joystick.delta.normalized();
    }

    _limitPositionToBounds();
  }

  void _limitPositionToBounds() {
    final gameSize = gameRef.size;
    position.x = position.x.clamp(size.x / 2, gameSize.x - size.x / 2);
    position.y = position.y.clamp(size.y / 2, gameSize.y - size.y / 2);
  }

  void die() {
    gameRef.pauseEngine();
    gameRef.showGameOverPopup();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Duck) {
      die();
    }
    super.onCollision(intersectionPoints, other);
  }
}
