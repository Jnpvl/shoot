import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class Joystick extends PositionComponent with DragCallbacks {
  final Paint knobPaint;
  final Paint backgroundPaint;
  late CircleComponent knob;
  Vector2 dragDeltaPosition = Vector2.zero();

  Joystick({
    required this.knobPaint,
    required this.backgroundPaint,
    required Vector2 position,
    double radius = 50,
  }) : super(
          position: position,
          size: Vector2.all(radius * 2),
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    knob = CircleComponent(radius: size.x / 4, paint: knobPaint);
    knob.position = size / 2;
    add(CircleComponent(radius: size.x / 2, paint: backgroundPaint));
    add(knob);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    dragDeltaPosition = event.localPosition - (size / 2);
    if (dragDeltaPosition.length > size.x / 2) {
      dragDeltaPosition = dragDeltaPosition.normalized() * (size.x / 2);
    }
    knob.position = (size / 2) + dragDeltaPosition;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    knob.position = size / 2;
    dragDeltaPosition = Vector2.zero();
  }

  Vector2 get delta => dragDeltaPosition.normalized();
}
