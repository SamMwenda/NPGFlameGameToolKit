import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

import '../../entities/entities.dart';
import '../../game.dart';
import '../colliisonblocks.dart';

class Level extends World with HasGameRef<PlayerGame> {
  late TiledComponent level;
  final player = Player.arrows();

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('playground.tmx', Vector2.all(16));

    //add level
    await add(level);

    //add walls
    _addWalls();
    _addPlayerSpawnPoint();

    return super.onLoad();
  }

  Future<void> _addWalls() async {
    final collisionsLayer =
        level.tileMap.getLayer<ObjectGroup>('collisionLayer');

    if (collisionsLayer != null) {
      for (final collision in collisionsLayer.objects) {
        final block = CollisionsBlocks(
          position: Vector2(collision.x, collision.y),
          size: Vector2(collision.width, collision.height),
        );
        player.collisionBlocks.add(block);
        await add(block);
      }
    }
  }

  Future<void> _addPlayerSpawnPoint() async {
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>('spawnLayer');

    if (spawnPointLayer != null) {
      // only have one spawn point
      final spawnPoint = spawnPointLayer.objects[0];
      player.position = Vector2(spawnPoint.x, spawnPoint.y);

      //add player
      await add(player);
    }
  }
}
