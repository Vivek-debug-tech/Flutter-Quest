/// =============================================================================
/// DATA-DRIVEN ARCHITECTURE GUIDE
/// =============================================================================
/// 
/// This document explains the fully data-driven structure for the Flutter
/// learning game. The UI automatically renders based on model data with no
/// static content in the UI layer.
///
/// =============================================================================

import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../models/world_model_v2.dart';
import '../models/level_model_v2.dart';
import '../services/game_data_service.dart';
import '../screens/challenge_engine_screen.dart';

/// =============================================================================
/// ARCHITECTURE OVERVIEW
/// =============================================================================
///
/// DATA LAYER (Models + Repositories)
///   ├─ WorldModel - Represents a learning world
///   ├─ LevelModel - Represents a single level
///   ├─ ChallengeStep - Individual challenges within levels
///   ├─ WorldsRepository - Contains all world data
///   └─ LevelsRepository - Contains all level data
///
/// SERVICE LAYER
///   └─ GameDataService - Provides clean API to access data
///
/// UI LAYER (Screens + Widgets)
///   ├─ Worlds Screen - Displays all worlds (data-driven)
///   ├─ Levels Screen - Shows levels for a world (data-driven)
///   ├─ Lesson Screen - Renders lesson content (data-driven)
///   └─ Challenge Screen - Displays challenges (data-driven)
///
/// BENEFITS:
/// ✓ Add 100+ levels without touching UI code
/// ✓ Easy to test and maintain
/// ✓ Can swap data source (local → API → database)
/// ✓ UI automatically adapts to data structure
/// ✓ Clean separation of concerns

/// =============================================================================
/// EXAMPLE 1: LOADING ALL WORLDS
/// =============================================================================

class WorldsScreenExample extends StatelessWidget {
  const WorldsScreenExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get data service instance
    final gameData = GameDataService();
    
    // Load all worlds - completely data-driven
    final worlds = gameData.getAllWorlds();

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Learning')),
      body: ListView.builder(
        itemCount: worlds.length,
        itemBuilder: (context, index) {
          final world = worlds[index];
          
          // UI renders based on data model
          return _buildWorldCard(context, world);
        },
      ),
    );
  }

  Widget _buildWorldCard(BuildContext context, WorldModel world) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: ListTile(
        leading: Text(
          world.icon,
          style: const TextStyle(fontSize: 40),
        ),
        title: Text(world.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(world.description),
            const SizedBox(height: 4),
            Text(
              '${world.levelCount} levels • ${world.totalXP} XP',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        trailing: world.isLocked
            ? Icon(Icons.lock, color: Colors.grey)
            : Icon(Icons.arrow_forward_ios),
        onTap: world.isLocked
            ? null
            : () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelsScreenExample(worldId: world.id),
                  ),
                ),
      ),
    );
  }
}

/// =============================================================================
/// EXAMPLE 2: LOADING LEVELS BY WORLD ID
/// =============================================================================

class LevelsScreenExample extends StatelessWidget {
  final String worldId;

  const LevelsScreenExample({Key? key, required this.worldId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();
    
    // Load world by ID
    final world = gameData.getWorldById(worldId);
    if (world == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('World not found')),
      );
    }

    // Load all levels for this world - data-driven
    final levels = gameData.getLevelsByWorldId(worldId);

    return Scaffold(
      appBar: AppBar(
        title: Text('${world.title} - ${world.theme}'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return _buildLevelCard(context, level);
        },
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, LevelModel level) {
    return GestureDetector(
      onTap: () {
        // Navigate to lesson screen with level data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeEngineScreen(level: level),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Level ${level.levelNumber}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                level.title,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Text(
                '${level.baseXP} XP',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// =============================================================================
/// EXAMPLE 3: LOADING A SINGLE LEVEL BY ID
/// =============================================================================

void navigateToLevelExample(BuildContext context, String levelId) {
  final gameData = GameDataService();
  
  // Load specific level by ID
  final level = gameData.getLevelById(levelId);
  
  if (level != null) {
    // Navigate with complete level data
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeEngineScreen(level: level),
      ),
    );
  } else {
    // Handle missing level
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Level not found')),
    );
  }
}

/// =============================================================================
/// EXAMPLE 4: SEARCH FUNCTIONALITY
/// =============================================================================

class SearchLevelsExample extends StatefulWidget {
  const SearchLevelsExample({Key? key}) : super(key: key);

  @override
  State<SearchLevelsExample> createState() => _SearchLevelsExampleState();
}

class _SearchLevelsExampleState extends State<SearchLevelsExample> {
  final gameData = GameDataService();
  List<LevelModel> searchResults = [];
  String query = '';

  void _performSearch(String searchQuery) {
    setState(() {
      query = searchQuery;
      searchResults = gameData.searchLevels(searchQuery);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search levels...',
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
        ),
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final level = searchResults[index];
          return ListTile(
            title: Text(level.title),
            subtitle: Text(level.concept),
            trailing: Text('${level.baseXP} XP'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeEngineScreen(level: level),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// =============================================================================
/// EXAMPLE 5: NAVIGATION BETWEEN LEVELS
/// =============================================================================

class LevelNavigationExample extends StatefulWidget {
  final String initialLevelId;

  const LevelNavigationExample({Key? key, required this.initialLevelId})
      : super(key: key);

  @override
  State<LevelNavigationExample> createState() => _LevelNavigationExampleState();
}

class _LevelNavigationExampleState extends State<LevelNavigationExample> {
  late String currentLevelId;
  final gameData = GameDataService();

  @override
  void initState() {
    super.initState();
    currentLevelId = widget.initialLevelId;
  }

  void _goToNextLevel() {
    final nextLevel = gameData.getNextLevel(currentLevelId);
    if (nextLevel != null) {
      setState(() {
        currentLevelId = nextLevel.id;
      });
    } else {
      // No more levels - show completion
      _showCompletionDialog();
    }
  }

  void _goToPreviousLevel() {
    final prevLevel = gameData.getPreviousLevel(currentLevelId);
    if (prevLevel != null) {
      setState(() {
        currentLevelId = prevLevel.id;
      });
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You\'ve completed all available levels!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final level = gameData.getLevelById(currentLevelId);
    
    if (level == null) {
      return const Scaffold(
        body: Center(child: Text('Level not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Level ${level.levelNumber}: ${level.title}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChallengeEngineScreen(level: level),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _goToPreviousLevel,
                child: const Text('← Previous'),
              ),
              ElevatedButton(
                onPressed: _goToNextLevel,
                child: const Text('Next →'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// =============================================================================
/// EXAMPLE 6: FILTERING LEVELS BY DIFFICULTY
/// =============================================================================

class FilterByDifficultyExample extends StatelessWidget {
  final DifficultyLevel difficulty;

  const FilterByDifficultyExample({Key? key, required this.difficulty})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();
    
    // Filter levels by difficulty - completely data-driven
    final levels = gameData.getLevelsByDifficulty(difficulty);

    return Scaffold(
      appBar: AppBar(
        title: Text('${difficulty.name.toUpperCase()} Levels'),
      ),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          return ListTile(
            title: Text(level.title),
            subtitle: Text(level.concept),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChallengeEngineScreen(level: level),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// =============================================================================
/// EXAMPLE 7: STATISTICS & ANALYTICS
/// =============================================================================

class StatsExample extends StatelessWidget {
  const StatsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();

    return Scaffold(
      appBar: AppBar(title: const Text('Game Statistics')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatCard(
              'Total Worlds',
              gameData.getTotalWorldsCount().toString(),
              Icons.public,
            ),
            _buildStatCard(
              'Total Levels',
              gameData.getTotalLevelsCount().toString(),
              Icons.layers,
            ),
            _buildStatCard(
              'Total XP Available',
              gameData.getTotalPossibleXP().toString(),
              Icons.stars,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 40),
        title: Text(value, style: const TextStyle(fontSize: 32)),
        subtitle: Text(label),
      ),
    );
  }
}

/// =============================================================================
/// KEY FUNCTIONS REFERENCE
/// =============================================================================

/// Example of all key GameDataService functions:
void apiReferenceExample() {
  final gameData = GameDataService();

  // WORLDS
  final allWorlds = gameData.getAllWorlds();
  final world = gameData.getWorldById('world_1');
  final worldByNumber = gameData.getWorldByNumber(1);
  final isUnlocked = gameData.isWorldUnlocked('world_2', 15);
  print('Total worlds: ${allWorlds.length}, World 1: ${world?.title}, By number: ${worldByNumber?.id}, Unlocked: $isUnlocked');

  // LEVELS
  final allLevels = gameData.getAllLevels();
  final level = gameData.getLevelById('w1_l1');
  final worldLevels = gameData.getLevelsByWorldId('world_1');
  final specificLevel = gameData.getLevelByWorldAndNumber(
    worldId: 'world_1',
    levelNumber: 1,
  );
  print('Total levels: ${allLevels.length}, Level: ${level?.title}');

  // NAVIGATION
  final nextLevel = gameData.getNextLevel('w1_l1');
  final prevLevel = gameData.getPreviousLevel('w1_l2');
  print('World 1 levels: ${worldLevels.length}, Next: ${nextLevel?.id}, Prev: ${prevLevel?.id}');

  // SEARCH & FILTER
  final searchResults = gameData.searchLevels('widget');
  final beginnerLevels = gameData.getLevelsByDifficulty(DifficultyLevel.beginner);
  print('Specific level: ${specificLevel?.title}, Search results: ${searchResults.length}');

  // STATISTICS
  final worldCount = gameData.getTotalWorldsCount();
  final levelCount = gameData.getTotalLevelsCount();
  final totalXP = gameData.getTotalPossibleXP();
  print('Beginner levels: ${beginnerLevels.length}, Count: $worldCount/$levelCount, Total XP: $totalXP');

  // VALIDATION
  final errors = gameData.validateDataIntegrity();
  if (errors.isNotEmpty) {
    print('Data integrity issues found:');
    for (var error in errors) {
      print('- $error');
    }
  }

  // CACHE
  gameData.refreshData(); // Reload data from repositories
}

/// =============================================================================
/// SCALING TO 100+ LEVELS
/// =============================================================================

/// HOW TO ADD NEW CONTENT:
///
/// 1. Add level IDs to WorldModel in WorldsRepository:
///    levelIds: ['w1_l1', 'w1_l2', ..., 'w1_l100']
///
/// 2. Create level methods in LevelsRepository:
///    LevelModel _w1_l6_newLevel() { return LevelModel(...); }
///
/// 3. Add to loadLevels() return list:
///    return [..., _w1_l6_newLevel(), ...];
///
/// 4. UI AUTOMATICALLY UPDATES - No UI code changes needed!
///
/// ORGANIZATIONAL TIPS:
/// - Group levels by world in separate files if needed
/// - Use consistent naming: _w{world}_l{level}_{shortName}()
/// - Keep level methods focused and readable
/// - Add comments for complex levels
/// - Consider level builders for repetitive patterns

/// =============================================================================
/// FUTURE ENHANCEMENTS
/// =============================================================================

/// POTENTIAL IMPROVEMENTS:
///
/// 1. PERSISTENCE:
///    - Save completed levels to local storage
///    - Track stars and XP earned
///    - User progress tracking
///
/// 2. REMOTE DATA:
///    - Load levels from API
///    - Dynamic content updates
///    - A/B testing different level designs
///
/// 3. LEVEL GENERATION:
///    - Template-based level creation
///    - Procedural content generation
///    - Level difficulty scaling
///
/// 4. ANALYTICS:
///    - Track completion rates
///    - Identify difficult levels
///    - Optimize learning paths

/// =============================================================================
