import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/components.dart';
import 'values/values.dart';

class PlayerGame extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {

  /// Instance of [World].
  late final World oinkWorld;

  /// Instance of [CameraComponent].
  late final CameraComponent cameraComponent;

  int currentLevelIndex = 0;

  @override
  Color backgroundColor() => gameMapBGColor;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    await _createCameraAndWorld();
    _loadLevel();

    return super.onLoad();
  }

  Future<void> _createCameraAndWorld() async {}

  @override
  @mustCallSuper
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    super.onKeyEvent(event, keysPressed);

    return KeyEventResult.handled;
  }

  Future<void> _loadLevel() async {
    Level world = Level(
      
    );

    cameraComponent = CameraComponent.withFixedResolution(
      world: world,
      width: 16 * 30,
      height: 16 * 30,
    );

    cameraComponent.viewfinder.zoom = 1.0;
    cameraComponent.viewfinder.anchor = Anchor.topLeft;

    await addAll([cameraComponent, world]);
  }
}
