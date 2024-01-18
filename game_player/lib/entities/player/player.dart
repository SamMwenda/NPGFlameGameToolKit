export 'behaviors/behaviors.dart';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

import '../../components/components.dart';
import '../../values.dart/values.dart';
import 'player.dart';

class Player extends PositionedEntity {
  Player(
      {required LogicalKeyboardKey jumpKey,
      required LogicalKeyboardKey leftKey,
      required LogicalKeyboardKey rightKey,
      Vector2? center})
      : this._(
          center: center ?? Vector2(200, 200),
          behaviors: [

            PlayerMovementBehavior(
                jumpKey: jumpKey, leftKey: leftKey, rightKey: rightKey),
           
          ],
          playerSprite: PlayerSprite(characterName: 'maskDude'),
        );

  Player._({
    required Vector2 center,
    required Iterable<Behavior> behaviors,
    required PlayerSprite playerSprite,
    Vector2? velocity,
  })  : _playerSprite = playerSprite,
        velocity = velocity ?? Vector2.zero(),
        super(
          size: playerTextureSize,
          position: center,
          behaviors: behaviors,
          children: [
            playerSprite,
          ],
        );

  Player.wasd({
    Vector2? center,
  }) : this(
            center: center,
            jumpKey: LogicalKeyboardKey.keyW,
            leftKey: LogicalKeyboardKey.keyA,
            rightKey: LogicalKeyboardKey.keyD);
  Player.arrows({
    Vector2? center,
  }) : this(
            center: center,
            jumpKey: LogicalKeyboardKey.arrowUp,
            leftKey: LogicalKeyboardKey.arrowLeft,
            rightKey: LogicalKeyboardKey.arrowRight);

  //variables
  final PlayerSprite _playerSprite;
  final Vector2 velocity;

  double horizontalMovement = 0;
  double moveSpeed = 100;

    List<CollisionsBlocks> collisionBlocks = [];


  CustomHitbox hitbox = CustomHitbox(
    offsetX: 7,
    offsetY: 4,
    width: 20,
    height: 28,
  );

  bool isBottomTouching = false;
  bool isLeftKeyPressed = false;
  bool isRightKeyPressed = false;
  bool hasJumped = false;
  bool isStuckToWall = false;
  bool canDoubleJump = false;

  void updateState({required PlayerState state}) =>
      _playerSprite.updateState(state: state);

  @override
  void onLoad() {
    //debugMode = true;

    add(RectangleHitbox(
      position: Vector2(hitbox.offsetX, hitbox.offsetY),
      size: Vector2(hitbox.width, hitbox.height),
    ));
    super.onLoad();
  }
}
