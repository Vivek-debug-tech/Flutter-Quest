import '../models/world_model_v2.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../data/levels_repository.dart';
import '../data/worlds_repository.dart';

/// Central data service for managing game data
/// Provides clean API for loading worlds and levels by ID
/// Separates data storage from business logic
class GameDataService {
  // Singleton pattern for global access
  static final GameDataService _instance = GameDataService._internal();
  factory GameDataService() => _instance;
  GameDataService._internal();

  // Data repositories (can be swapped with API/database later)
  final WorldsRepository _worldsRepo = WorldsRepository();
  final LevelsRepository _levelsRepo = LevelsRepository();

  // Cache for performance
  Map<String, WorldModel>? _worldsCache;
  Map<String, LevelModel>? _levelsCache;

  // ============================================
  // WORLDS
  // ============================================

  /// Get all worlds in the game
  List<WorldModel> getAllWorlds() {
    _ensureWorldsCacheLoaded();
    return _worldsCache!.values.toList()
      ..sort((a, b) => a.worldNumber.compareTo(b.worldNumber));
  }

  /// Get a specific world by ID
  WorldModel? getWorldById(String worldId) {
    _ensureWorldsCacheLoaded();
    return _worldsCache![worldId];
  }

  /// Get world by number (1-based)
  WorldModel? getWorldByNumber(int number) {
    _ensureWorldsCacheLoaded();
    return _worldsCache!.values
        .firstWhere((world) => world.worldNumber == number,
            orElse: () => throw Exception('World $number not found'));
  }

  /// Check if world is unlocked based on stars
  bool isWorldUnlocked(String worldId, int currentStars) {
    final world = getWorldById(worldId);
    if (world == null) return false;
    return currentStars >= world.requiredStarsToUnlock;
  }

  // ============================================
  // LEVELS
  // ============================================

  /// Get all levels across all worlds
  List<LevelModel> getAllLevels() {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.values.toList()
      ..sort((a, b) {
        final worldCompare = a.worldId.compareTo(b.worldId);
        if (worldCompare != 0) return worldCompare;
        return a.levelNumber.compareTo(b.levelNumber);
      });
  }

  /// Get a specific level by ID
  LevelModel? getLevelById(String levelId) {
    _ensureLevelsCacheLoaded();
    return _levelsCache![levelId];
  }

  /// Get all levels for a specific world
  List<LevelModel> getLevelsByWorldId(String worldId) {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.values
        .where((level) => level.worldId == worldId)
        .toList()
      ..sort((a, b) => a.levelNumber.compareTo(b.levelNumber));
  }

  /// Get level by world ID and level number
  LevelModel? getLevelByWorldAndNumber({
    required String worldId,
    required int levelNumber,
  }) {
    _ensureLevelsCacheLoaded();
    try {
      return _levelsCache!.values.firstWhere(
        (level) => level.worldId == worldId && level.levelNumber == levelNumber,
      );
    } catch (e) {
      return null;
    }
  }

  /// Get next level in sequence
  LevelModel? getNextLevel(String currentLevelId) {
    final currentLevel = getLevelById(currentLevelId);
    if (currentLevel == null) return null;

    // Try next level in same world
    final nextInWorld = getLevelByWorldAndNumber(
      worldId: currentLevel.worldId,
      levelNumber: currentLevel.levelNumber + 1,
    );

    if (nextInWorld != null) return nextInWorld;

    // If last level in world, get first level of next world
    final currentWorld = getWorldById(currentLevel.worldId);
    if (currentWorld?.nextWorldId != null) {
      return getLevelByWorldAndNumber(
        worldId: currentWorld!.nextWorldId!,
        levelNumber: 1,
      );
    }

    return null; // No more levels
  }

  /// Get previous level in sequence
  LevelModel? getPreviousLevel(String currentLevelId) {
    final currentLevel = getLevelById(currentLevelId);
    if (currentLevel == null) return null;

    // Try previous level in same world
    if (currentLevel.levelNumber > 1) {
      return getLevelByWorldAndNumber(
        worldId: currentLevel.worldId,
        levelNumber: currentLevel.levelNumber - 1,
      );
    }

    // If first level in world, get last level of previous world
    final currentWorld = getWorldById(currentLevel.worldId);
    if (currentWorld != null && currentWorld.worldNumber > 1) {
      final prevWorld = getWorldByNumber(currentWorld.worldNumber - 1);
      if (prevWorld != null) {
        final levelsInPrevWorld = getLevelsByWorldId(prevWorld.id);
        return levelsInPrevWorld.isNotEmpty ? levelsInPrevWorld.last : null;
      }
    }

    return null; // No previous level
  }

  // ============================================
  // SEARCH & FILTER
  // ============================================

  /// Search levels by concept or title
  List<LevelModel> searchLevels(String query) {
    _ensureLevelsCacheLoaded();
    final lowerQuery = query.toLowerCase();
    return _levelsCache!.values.where((level) {
      return level.title.toLowerCase().contains(lowerQuery) ||
          level.concept.toLowerCase().contains(lowerQuery) ||
          level.learningObjective.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  /// Get levels by difficulty
  List<LevelModel> getLevelsByDifficulty(DifficultyLevel difficulty) {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.values
        .where((level) => level.difficulty == difficulty)
        .toList();
  }

  /// Get levels that require prerequisites
  List<LevelModel> getLevelsWithPrerequisites() {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.values
        .where((level) =>
            level.prerequisites != null && level.prerequisites!.isNotEmpty)
        .toList();
  }

  // ============================================
  // STATISTICS
  // ============================================

  /// Get total number of worlds
  int getTotalWorldsCount() {
    _ensureWorldsCacheLoaded();
    return _worldsCache!.length;
  }

  /// Get total number of levels
  int getTotalLevelsCount() {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.length;
  }

  /// Get total XP across all levels
  int getTotalPossibleXP() {
    _ensureLevelsCacheLoaded();
    return _levelsCache!.values.fold(
      0,
      (sum, level) => sum + level.totalPossibleXP,
    );
  }

  /// Get level completion percentage for a world
  double getWorldProgress(String worldId, Set<String> completedLevelIds) {
    final levels = getLevelsByWorldId(worldId);
    if (levels.isEmpty) return 0.0;

    final completed = levels.where((l) => completedLevelIds.contains(l.id)).length;
    return (completed / levels.length) * 100;
  }

  // ============================================
  // CACHE MANAGEMENT
  // ============================================

  void _ensureWorldsCacheLoaded() {
    if (_worldsCache == null) {
      final worlds = _worldsRepo.loadWorlds();
      _worldsCache = {for (var world in worlds) world.id: world};
    }
  }

  void _ensureLevelsCacheLoaded() {
    if (_levelsCache == null) {
      final levels = _levelsRepo.loadLevels();
      _levelsCache = {for (var level in levels) level.id: level};
    }
  }

  /// Clear cache and reload data (useful for testing or data updates)
  void refreshData() {
    _worldsCache = null;
    _levelsCache = null;
  }

  // ============================================
  // VALIDATION
  // ============================================

  /// Validate that all level IDs in worlds exist in levels
  List<String> validateDataIntegrity() {
    _ensureWorldsCacheLoaded();
    _ensureLevelsCacheLoaded();

    final errors = <String>[];

    // Check that all level IDs referenced by worlds exist
    for (final world in _worldsCache!.values) {
      for (final levelId in world.levelIds) {
        if (!_levelsCache!.containsKey(levelId)) {
          errors.add('World ${world.id} references non-existent level: $levelId');
        }
      }
    }

    // Check that all levels have valid world IDs
    for (final level in _levelsCache!.values) {
      if (!_worldsCache!.containsKey(level.worldId)) {
        errors.add('Level ${level.id} references non-existent world: ${level.worldId}');
      }
    }

    return errors;
  }
}
