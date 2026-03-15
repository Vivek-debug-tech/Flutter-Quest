import 'package:flutter/foundation.dart';
import '../models/user_progress_model.dart';
import '../models/level_model.dart';
import '../models/world_model.dart';
import 'storage_service.dart';
import '../managers/achievement_manager.dart';
import '../managers/star_manager.dart';
import '../managers/xp_manager.dart';

class ProgressService extends ChangeNotifier {
  final StorageService _storageService;
  late UserProgress _userProgress;

  ProgressService(this._storageService) {
    _userProgress = _storageService.getUserProgress();
    _checkDailyStreak();
  }

  UserProgress get userProgress => _userProgress;
  StorageService get storageService => _storageService;

  // Check and update daily streak
  void _checkDailyStreak() {
    _userProgress.updateStreak();
    _saveProgress();
  }

  // Save progress to storage
  Future<void> _saveProgress() async {
    await _storageService.saveUserProgress(_userProgress);
    notifyListeners();
  }

  // Complete a level
  Future<List<String>> completeLevel({
    required Level level,
    required int hintsUsed,
    required int mistakesMade,
  }) async {
    _userProgress.updateStreak();

    final xp = XPManager.calculateXP(hintsUsed);
    final stars = StarManager.calculateStars(hintsUsed);

    // Save level progress
    final levelProgress = LevelProgress(
      levelId: level.id,
      isCompleted: true,
      starsEarned: stars,
      xpEarned: xp,
      hintsUsed: hintsUsed,
      mistakesMade: mistakesMade,
      completedAt: DateTime.now(),
    );

    await _storageService.saveLevelProgress(level.id, levelProgress.toJson());

    // Update user progress
    _userProgress.completeLevel(level.id, xp, stars);

    await _storageService.setTotalXP(_userProgress.totalXP);
    final newlyUnlockedAchievements = await AchievementManager.updateAchievements(
      storageService: _storageService,
      userProgress: _userProgress,
      hintsUsed: hintsUsed,
    );

    _checkBadges(level);
    
    await _saveProgress();
    return newlyUnlockedAchievements;
  }

  // Check and award badges
  void _checkBadges(Level completedLevel) {
    // Scaffold Starter - Complete World 1
    if (completedLevel.worldId == 'world_1') {
      final world1Levels = _userProgress.completedLevels
          .where((id) => id.startsWith('w1-'))
          .length;
      if (world1Levels >= 5) {
        _userProgress.awardBadge('scaffold_starter');
      }
    }

    // No Hint Hero - 5 levels without hints
    int noHintCount = 0;
    for (var levelId in _userProgress.completedLevels) {
      final progress = _storageService.getLevelProgress(levelId);
      if (progress != null && progress['hintsUsed'] == 0) {
        noHintCount++;
      }
    }
    if (noHintCount >= 5) {
      _userProgress.awardBadge('no_hint_hero');
    }
  }

  // Unlock next level
  Future<void> unlockNextLevel(String currentLevelId) async {
    // Logic to unlock next level
    notifyListeners();
  }

  // Unlock world
  Future<void> unlockWorld(String worldId) async {
    _userProgress.unlockWorld(worldId);
    await _saveProgress();
  }

  // Check if level is unlocked
  bool isLevelUnlocked(Level level) {
    // First level of each world is always unlocked if world is unlocked
    if (level.levelNumber == 1) {
      return _userProgress.unlockedWorlds.contains(level.worldId);
    }

    // Check if previous level is completed
    final prevLevelId = '${level.worldId.replaceAll('world_', 'w')}-l${level.levelNumber - 1}';
    return _userProgress.completedLevels.contains(prevLevelId);
  }

  // Check if world is unlocked
  bool isWorldUnlocked(String worldId) {
    return _userProgress.unlockedWorlds.contains(worldId);
  }

  // Get level progress
  LevelProgress? getLevelProgress(String levelId) {
    final progressData = _storageService.getLevelProgress(levelId);
    if (progressData != null) {
      return LevelProgress.fromJson(Map<String, dynamic>.from(progressData));
    }
    return null;
  }

  // Get world completion percentage
  double getWorldCompletion(World world) {
    int completedCount = 0;
    for (var level in world.levels) {
      if (_userProgress.completedLevels.contains(level.id)) {
        completedCount++;
      }
    }
    return world.levels.isEmpty ? 0.0 : completedCount / world.levels.length;
  }

  // Get total stars for a world
  int getWorldStars(World world) {
    int totalStars = 0;
    for (var level in world.levels) {
      final progress = getLevelProgress(level.id);
      if (progress != null) {
        totalStars += progress.starsEarned;
      }
    }
    return totalStars;
  }

  // Reset progress (for testing)
  Future<void> resetProgress() async {
    await _storageService.clearAllData();
    _userProgress = _storageService.getUserProgress();
    notifyListeners();
  }
}
