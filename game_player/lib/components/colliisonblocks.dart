import 'package:flame/components.dart';

class CollisionsBlocks extends PositionComponent {
  CollisionsBlocks({size, position, this.isPlatform = false})
      : super(
          size: size,
          position: position,
        ) {
    //debugMode = true;
  }

  bool isPlatform;
}

