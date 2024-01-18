import 'dart:async';

import 'package:flame/components.dart';

import '../../game.dart';
import '../../values/values.dart';

enum PlayerState { doubleJump, fall, hit, idle, jump, run, wallJump }

class PlayerSprite extends SpriteAnimationGroupComponent
    with HasGameRef<PlayerGame> {
  PlayerSprite({required this.characterName, position})
      : super(
          position: position,
        );
  final String characterName;

  //declare animations
  late SpriteAnimation doubleJumpAnimation;
  late SpriteAnimation fallAnimation;
  late SpriteAnimation hitAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation wallJumpAnimation;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  ///Load all player animations
  _loadAllAnimations() {
    doubleJumpAnimation = _spriteAnimation('doubleJump', 6);
    fallAnimation = _spriteAnimation('fall', 1);
    hitAnimation = _spriteAnimation('hit', 7)..loop = false;
    idleAnimation = _spriteAnimation('idle', 11);
    jumpAnimation = _spriteAnimation('jump', 1);
    runAnimation = _spriteAnimation('run', 12);
    wallJumpAnimation = _spriteAnimation('wallJump', 5);

    animations = {
      PlayerState.doubleJump: doubleJumpAnimation,
      PlayerState.fall: fallAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.idle: idleAnimation,
      PlayerState.jump: jumpAnimation,
      PlayerState.run: runAnimation,
      PlayerState.wallJump: wallJumpAnimation,
    };

    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('player/$characterName/$state.png'),
      SpriteAnimationData.sequenced(
          amount: amount,
          stepTime: playerAnimationStepTime,
          textureSize: playerTextureSize,
          texturePosition: position),
    );
  }

  /// method used to update state
  /// ensures correct animation is playing
  void updateState({required PlayerState state}) {
    if (current != state) current = state;
  }
}
