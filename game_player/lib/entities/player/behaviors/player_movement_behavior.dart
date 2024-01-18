import 'package:flame/components.dart';
import 'package:flame_behaviors/flame_behaviors.dart';
import 'package:flutter/services.dart';

import '../../../checkcollision/checkcollision.dart';
import '../../../components/components.dart';
import '../../../game.dart';
import '../../../values.dart/values.dart';
import '../player.dart';


class PlayerMovementBehavior extends Behavior<Player>
    with KeyboardHandler, HasGameRef<PlayerGame> {
  PlayerMovementBehavior(
      {required this.jumpKey, required this.leftKey, required this.rightKey});

  final LogicalKeyboardKey jumpKey;
  final LogicalKeyboardKey leftKey;
  final LogicalKeyboardKey rightKey;

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    parent.horizontalMovement = 0;
    parent.horizontalMovement += keysPressed.contains(leftKey) ? -1 : 0;
    parent.horizontalMovement += keysPressed.contains(rightKey) ? 1 : 0;

    parent.hasJumped = keysPressed.contains(jumpKey);

    parent.isLeftKeyPressed = keysPressed.contains(leftKey);
    parent.isRightKeyPressed = keysPressed.contains(rightKey);

    if ((parent.isLeftKeyPressed || parent.isRightKeyPressed) &&
        parent.isStuckToWall) {
      parent.isStuckToWall = false;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  void update(double dt) {
    _updatePlayerState();
    _updatePlayerMovement(dt);
    _checkHorizontalCollisions();
    _applyGravity(dt);
    _checkVerticalCollisions();

    super.update(dt);
  }

  void _updatePlayerState() {
    if (parent.velocity.x < 0 && parent.scale.x > 0) {
      parent.flipHorizontallyAroundCenter();
    } else if (parent.velocity.x > 0 && parent.scale.x < 0) {
      parent.flipHorizontallyAroundCenter();
    }

    // Check if moving, set running
    if (parent.velocity.x != 0 && parent.isBottomTouching) {
      parent.updateState(state: PlayerState.run);
    }

    // Check if Falling set to falling
    else if (parent.velocity.y > 0 && !parent.isStuckToWall) {
      parent.updateState(state: PlayerState.fall);
    }

    // Check if jumping, set to jumping
    else if (parent.velocity.y < 0 && parent.canDoubleJump) {
      parent.updateState(state: PlayerState.jump);
    }

    //Check if stuck on wall, set wallJump
    else if (parent.isStuckToWall && !parent.isBottomTouching) {
      parent.updateState(state: PlayerState.wallJump);
    }

    // Chcheck if doubleJump, set double jump
    else if (parent.velocity.y < 0 && !parent.canDoubleJump) {
      parent.updateState(state: PlayerState.doubleJump);
    } else {
      parent.updateState(state: PlayerState.idle);
    }
  }

  void _updatePlayerMovement(double dt) {
    if (parent.hasJumped && (parent.isBottomTouching || parent.isStuckToWall)) {
      _playerJump(dt);
    }

    if (parent.hasJumped && parent.canDoubleJump) _playerDoubleJump(dt);

    parent.velocity.x = parent.horizontalMovement * parent.moveSpeed;
    parent.position.x += parent.velocity.x * dt;
  }

  void _checkHorizontalCollisions() {
    for (final block in parent.collisionBlocks) {
      if (!block.isPlatform) {
        if (checkCollision(parent, block)) {
          if (parent.velocity.x > 0) {
            if (parent.velocity.y > 0 && parent.isRightKeyPressed) {
              parent.isStuckToWall = true;
            }
            parent.velocity.x = 0;
            parent.position.x =
                block.x - parent.hitbox.offsetX - parent.hitbox.width;
            break;
          }
          if (parent.velocity.x < 0) {
            if (parent.velocity.y > 0 && parent.isLeftKeyPressed) {
              parent.isStuckToWall = true;
            }
            parent.velocity.x = 0;
            parent.position.x = block.x +
                block.width +
                parent.hitbox.width +
                parent.hitbox.offsetX;
            break;
          }
        }
      }
    }
  }

  void _applyGravity(double dt) {
    if (parent.isStuckToWall) {
      parent.velocity.y += normalWallGravity;
      parent.velocity.y = parent.velocity.y
          .clamp(-normalWallJumpForce, normalWallTerminalVelocity);
      parent.position.y += parent.velocity.y * dt;
    } else {
      parent.velocity.y += gravity;
      parent.velocity.y = parent.velocity.y.clamp(-jumpForce, terminalVelocity);
      parent.position.y += parent.velocity.y * dt;
    }
  }

  void _checkVerticalCollisions() {
    for (final block in parent.collisionBlocks) {
      if (block.isPlatform) {
        if (checkCollision(parent, block)) {
          if (parent.velocity.y > 0) {
            parent.velocity.y = 0;
            parent.position.y =
                block.y - parent.hitbox.height - parent.hitbox.offsetY;
            parent.isBottomTouching = true;
            break;
          }
        }
      } else {
        if (checkCollision(parent, block)) {
          if (parent.velocity.y > 0) {
            parent.velocity.y = 0;
            parent.position.y =
                block.y - parent.hitbox.height - parent.hitbox.offsetY;
            parent.isBottomTouching = true;
            break;
          }
          if (parent.velocity.y < 0) {
            parent.velocity.y = 0;
            parent.position.y = block.y + block.height - parent.hitbox.offsetY;
          }
        }
      }
    }
  }

  void _playerJump(double dt) {
    parent.velocity.y = -jumpForce;
    parent.position.y += parent.velocity.y * dt;
    parent.isStuckToWall = false;
    parent.isBottomTouching = false;
    parent.hasJumped = false;
    parent.canDoubleJump = true;
  }

  void _playerDoubleJump(double dt) {
    parent.velocity.y = -doubleJumpForce;
    parent.position.y += parent.velocity.y * dt;
    parent.isStuckToWall = false;
    parent.isBottomTouching = false;
    parent.hasJumped = false;
    parent.canDoubleJump = false;
  }
}
