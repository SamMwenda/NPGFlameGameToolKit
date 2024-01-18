import 'package:flame/game.dart';

// Size of our player 32x32
final playerTextureSize = Vector2.all(32);

// Equivalent to 20fps or 50ms
const playerAnimationStepTime = 0.05;

/// Gravity of game world
const gravity = 19.8;

//jumpForce of characters
const jumpForce = 260.0;

//jumpForce for characters double jump
const doubleJumpForce = 200.0;

//#############################################
/// Start of values obtained from [gravity]

//terminalvelocity of characters
const terminalVelocity = 200.0;

//gravity while player is stuck on wall
const normalWallGravity = 2.8;

//gravity while player is stuck on wall
const normalWallJumpForce = 36.8;

//gravity while player is stuck on wall
const normalWallTerminalVelocity = 28.28;

/// End of values obtained from [gravity]
//#############################################