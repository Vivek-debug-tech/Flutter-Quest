/// =============================================================================
/// DATA-DRIVEN DEMO APP
/// =============================================================================
///
/// Complete working example showing the data-driven architecture in action.
/// Run this to see how the system loads worlds and levels dynamically.
///
/// TO RUN:
/// 1. Replace your main.dart content with: 
///    import 'examples/data_driven_demo.dart';
///    void main() => runApp(const DataDrivenDemo());
///
/// 2. Hot reload and explore the app
///
/// =============================================================================

import 'package:flutter/material.dart';
import '../models/world_model_v2.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../services/game_data_service.dart';
import '../screens/challenge_engine_screen.dart';

void main() {
  runApp(const DataDrivenDemo());
}

class DataDrivenDemo extends StatelessWidget {
  const DataDrivenDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Learning - Data-Driven',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const WorldsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// =============================================================================
/// WORLDS SCREEN - Shows all available worlds
/// =============================================================================

class WorldsScreen extends StatelessWidget {
  const WorldsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();
    final worlds = gameData.getAllWorlds();
    
    // Get statistics
    final totalWorlds = gameData.getTotalWorldsCount();
    final totalLevels = gameData.getTotalLevelsCount();
    final totalXP = gameData.getTotalPossibleXP();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Learning Worlds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context, totalWorlds, totalLevels, totalXP),
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats banner
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatChip('$totalWorlds Worlds', Icons.public),
                _buildStatChip('$totalLevels Levels', Icons.layers),
                _buildStatChip('$totalXP XP', Icons.stars),
              ],
            ),
          ),

          // Worlds list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: worlds.length,
              itemBuilder: (context, index) {
                final world = worlds[index];
                return _buildWorldCard(context, world);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildWorldCard(BuildContext context, WorldModel world) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 3,
      child: InkWell(
        onTap: world.isLocked
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelsScreen(world: world),
                  ),
                );
              },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    world.icon,
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            world.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (world.isLocked)
                          const Icon(Icons.lock, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      world.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildInfoChip('${world.levelCount} levels', Colors.blue),
                        _buildInfoChip('${world.totalXP} XP', Colors.amber),
                        _buildInfoChip('${world.estimatedDuration} min', Colors.green),
                      ],
                    ),
                    if (world.isLocked && world.hasPrerequisites) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Requires ${world.requiredStarsToUnlock} ⭐ to unlock',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: color.withOpacity(0.9),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _showInfoDialog(BuildContext context, int worlds, int levels, int xp) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Statistics'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📚 Total Worlds: $worlds'),
            const SizedBox(height: 8),
            Text('🎯 Total Levels: $levels'),
            const SizedBox(height: 8),
            Text('⭐ Total XP Available: $xp'),
            const SizedBox(height: 16),
            const Text(
              'This entire UI is data-driven! All content comes from models, not hardcoded text.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

/// =============================================================================
/// LEVELS SCREEN - Shows all levels for a specific world
/// =============================================================================

class LevelsScreen extends StatelessWidget {
  final WorldModel world;

  const LevelsScreen({Key? key, required this.world}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();
    final levels = gameData.getLevelsByWorldId(world.id);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${world.icon} ${world.title}'),
            Text(
              '${levels.length} levels • ${world.theme}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
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
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: level.isLocked
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChallengeEngineScreen(level: level),
                  ),
                );
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Level number badge
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: _getDifficultyColor(level.difficulty).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${level.levelNumber}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getDifficultyColor(level.difficulty),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                level.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Concept
              Text(
                level.concept,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),

              // XP and difficulty
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBadge('${level.baseXP} XP', Colors.amber),
                  _buildBadge(
                    level.difficulty.name.substring(0, 3).toUpperCase(),
                    _getDifficultyColor(level.difficulty),
                  ),
                ],
              ),

              // Lock indicator
              if (level.isLocked) ...[
                const SizedBox(height: 8),
                const Icon(Icons.lock, size: 16, color: Colors.grey),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getDifficultyColor(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return Colors.green;
      case DifficultyLevel.intermediate:
        return Colors.orange;
      case DifficultyLevel.advanced:
        return Colors.red;
    }
  }
}

/// =============================================================================
/// DATA VALIDATION SCREEN - Shows data integrity check
/// =============================================================================

class DataValidationScreen extends StatelessWidget {
  const DataValidationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameData = GameDataService();
    final errors = gameData.validateDataIntegrity();

    return Scaffold(
      appBar: AppBar(title: const Text('Data Validation')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: errors.isEmpty
            ? _buildSuccessView()
            : _buildErrorsView(errors),
      ),
    );
  }

  Widget _buildSuccessView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 80),
          SizedBox(height: 16),
          Text(
            'Data Integrity: PASSED ✓',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('All level references are valid'),
        ],
      ),
    );
  }

  Widget _buildErrorsView(List<String> errors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.error, color: Colors.red, size: 60),
        const SizedBox(height: 16),
        const Text(
          'Data Integrity Errors:',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: errors.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.red[50],
                child: ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(errors[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// =============================================================================
/// SEARCH SCREEN - Demonstrates search functionality
/// =============================================================================

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final gameData = GameDataService();
  List<LevelModel> searchResults = [];
  final _searchController = TextEditingController();

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      searchResults = gameData.searchLevels(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search levels...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _performSearch,
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
        ],
      ),
      body: searchResults.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 16),
                  Text(
                    _searchController.text.isEmpty
                        ? 'Search for levels...'
                        : 'No results found',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final level = searchResults[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${level.levelNumber}'),
                  ),
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
