import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<FlameGame> {
  BackgroundComponent(Sprite sprite)
      : super(
          sprite: sprite,
          size: Vector2.all(double.infinity),
          anchor: Anchor.topLeft,
        );

  @override
  void onMount() {
    size = gameRef.size;
    super.onMount();
  }
}
