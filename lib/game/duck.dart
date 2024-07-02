import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:shoot/game/hunter.dart';
import 'package:shoot/game/my_game.dart';

class Duck extends SpriteComponent with HasGameRef<MyGame>, CollisionCallbacks {
  static const double _minDistanceFromHunter = 100;

  static double baseSpeed = 1.0;
  double speed;

  Duck(Sprite sprite)
      : speed = baseSpeed,
        super(
          sprite: sprite,
          size: Vector2(30, 30),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());

    final hunter = gameRef.children.whereType<Hunter>().first;

    Vector2 initialPosition;
    do {
      initialPosition = Vector2(
        gameRef.size.x * gameRef.random.nextDouble(),
        gameRef.size.y * gameRef.random.nextDouble(),
      );
    } while (
        (initialPosition - hunter.position).length < _minDistanceFromHunter);

    position = initialPosition;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final hunter = gameRef.children.whereType<Hunter>().first;

    final direction = (hunter.position - position).normalized();

    final speed = 50 * dt;

    position += direction * speed;
  }

  void hit() {
    removeFromParent();
    gameRef.scoreController.increaseScore();
    gameRef.ducksKilled += 1;

    if (gameRef.ducksKilled % 10 == 0) {
      Duck.baseSpeed += 1.00;
      print('New duck base speed: ${Duck.baseSpeed}');
    }

    addDuckFarFromHunter();
  }

  void addDuckFarFromHunter() {
    final hunter = gameRef.children.whereType<Hunter>().first;
    Vector2 newPosition;
    do {
      newPosition = Vector2(
        gameRef.size.x * gameRef.random.nextDouble(),
        gameRef.size.y * gameRef.random.nextDouble(),
      );
    } while ((newPosition - hunter.position).length < _minDistanceFromHunter);
    gameRef.add(Duck(sprite!)..position = newPosition);
  }
}
