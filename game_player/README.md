# Game player

## Overview

The "Game Player" mini project serves as a comprehensive illustration of setting up a character within a Flame game environment using a Tiled map. Tiled maps are an efficient way to design and structure game worlds, and this project demonstrates how to seamlessly integrate characters into these maps.

The mini project not only covers the basics of character setup but also delves into the intricacies of character interaction within a Tiled map. It provides insights into handling character movement, collision detection, and other crucial aspects that contribute to a dynamic and engaging gaming experience.

By following this guide, developers can gain a solid understanding of how to synchronize character movements with Tiled maps, ensuring a smooth and immersive gameplay experience. Whether you're a novice game developer looking to enhance your skills or an experienced developer seeking a streamlined approach to character integration, the "Game Player" mini project offers valuable insights and a practical foundation for your Flame game development journey.

## Packages

1. [**flame 1.14.0**](https://pub.dev/packages/flame)

2. [**flame_tiled 1.18.3**](https://pub.dev/packages/flame_tiled)

3. [**flame_behaviors: ^1.1.0**](https://pub.dev/packages/flame_behaviors)

## info

1. **Collision Detection** : While using flame_behaviors collisionDetection can be defined as a entity behavior. For example **PlayerCollisionBehavior**, I tried going this route as I was making the project but I had a really wonky collision detection that was buggy and unpredictable.I really can't pin point why my collision detection system was not working. If you are intrested in trying out flames built in collision detection try the following material

    1. [One-Dungeon](https://github.com/BBarisKilic/One-Dungeon/tree/master) by **BBarisKilic**

    2. [Introduction to Flame Behaviors](https://verygood.ventures/blog/build-games-with-flame-behaviors) by **VGVentures**
for the project I applied a collision detection system by [**Spellthorn**](https://www.youtube.com/@Spellthorn) checkout the series [Create an Amazing Game with Flutter & Flame](https://www.youtube.com/playlist?list=PLRRATgFqhVCh8qD7xmaSbwG1vfaCddvCM) in the Spellthorn channel. Video 4 in the series sums up collision detection but I would recommend the entire series as it is what got me started with flame.

In regards to collision detection any breakthroughs or insights that can help improve the code  are appreciated.

## Contribute

1. **Does the [PlayerMovementBehavior](https://github.com/SamMwenda/NPGFlameGameToolKit/blob/main/game_player/lib/entities/player/behaviors/player_movement_behavior.dart) class make sense or does it ignore the purpose of flame_behaviors**(<https://github.com/SamMwenda/NPGFlameGameToolKit/issues/1>)

2. **Does it make sense to include the 'values' folder in a Flame project? What are the reasons for having it, and why might one choose not to include it?**(<https://github.com/SamMwenda/NPGFlameGameToolKit/issues/2>)

3. **How do you detect collsions in your flame game?**(<https://github.com/SamMwenda/NPGFlameGameToolKit/issues/3>)

4. **What is the future of flame engine**(<https://github.com/SamMwenda/NPGFlameGameToolKit/issues/4>)

## Credits

1. [**BBarisKilic**](https://github.com/BBarisKilic)
2. [**Pixel Frog**](https://pixelfrog-assets.itch.io/)
3. [**Spellthorn**](https://www.youtube.com/@Spellthorn)
4. [**Nisa Pixel Games**](https://twitter.com/nisapixelgames)

### Watch out for the next mini project

### Happy Flame Game Development! 🚀
