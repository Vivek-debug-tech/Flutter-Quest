import '../models/world_model.dart';
import 'worlds/async_world.dart';
import 'worlds/basics_world.dart';
import 'worlds/interaction_world.dart';
import 'worlds/layout_world.dart';
import 'worlds/lists_world.dart';
import 'worlds/navigation_world.dart';
import 'worlds/state_world.dart';
import 'worlds/styling_world.dart';

final List<World> worlds = [
  flutterBasicsWorld,
  layoutWorld,
  stylingWorld,
  interactionWorld,
  navigationWorld,
  listsWorld,
  stateWorld,
  asyncWorld,
];

class GameData {
  static List<World> getAllWorlds() {
    return worlds;
  }
}
