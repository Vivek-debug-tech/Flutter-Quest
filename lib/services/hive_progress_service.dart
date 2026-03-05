import 'package:hive/hive.dart';
import '../models/player_progress.dart';
import 'xp_calculator.dart';

/// Hive-based service for persisting player progress
/// Handles saving, loading, and updating player progress with local storage
class HiveProgressService {
  static const String _boxName = 'player_progress';
  static const String _progressKey = 'current_progress';

  /// Initialize Hive and open the progress box
  /// Call this in main.dart before runApp()
  static Future<void> initialize() async {
    // Note: Call Hive.initFlutter() in main.dart before this
    // Example: await Hive.initFlutter();
    await Hive.openBox<Map>(_boxName);
  }

  /// Get the progress box
  static Box<Map> get _box => Hive.box<Map>(_boxName);

  /// Load player progress from storage
  /// Returns existing progress or creates initial progress for new players
  static Future<PlayerProgress> loadProgress() async {
    try {
      final data = _box.get(_progressKey);
      if (data != null) {
        return PlayerProgress.fromJson(Map<String, dynamic>.from(data));
      }
    } catch (e) {
      print('Error loading progress: $e');
    }
    // Return initial progress for new players
    return PlayerProgress.initial();
  }

  /// Save player progress to storage
  static Future<void> saveProgress(PlayerProgress progress) async {
    try {
      await _box.put(_progressKey, progress.toJson());
    } catch (e) {
      print('Error saving progress: $e');
      rethrow;
    }
  }

  /// Add XP to player progress
  /// 
  /// [xpEarned] - Amount of XP to add
  /// Returns updated PlayerProgress
  static Future<PlayerProgress> addXP(int xpEarned) async {
    final progress = await loadProgress();
    final now = DateTime.now();

    // Update streak
    int newStreak = progress.dailyStreak;
    if (progress.shouldUpdateStreak(now)) {
      newStreak++;
    } else if (progress.isStreakBroken(now)) {
      newStreak = 1;
    }

    // Add streak bonus
    final streakBonus = XPCalculator.calculateStreakBonus(newStreak);
    final totalXP = xpEarned + streakBonus;

    final updatedProgress = progress.copyWith(
      currentXP: progress.currentXP + totalXP,
      dailyStreak: newStreak,
      lastPlayedDate: now,
    );

    await saveProgress(updatedProgress);
    return updatedProgress;
  }

  /// Mark a level as completed and award stars
  /// 
  /// [levelId] - ID of the completed level
  /// [stars] - Stars earned (1-3)
  /// [xpEarned] - XP earned
  /// [mistakes] - Number of mistakes made
  /// [hintsUsed] - Number of hints used
  /// Returns updated PlayerProgress
  static Future<PlayerProgress> markLevelCompleted({
    required String levelId,
    required int stars,
    required int xpEarned,
    required int mistakes,
    required int hintsUsed,
    Duration? timeTaken,
  }) async {
    final progress = await loadProgress();
    final now = DateTime.now();

    // Update completed levels list
    final completedLevels = List<String>.from(progress.completedLevels);
    if (!completedLevels.contains(levelId)) {
      completedLevels.add(levelId);
    }

    // Update level stars (keep highest)
    final levelStars = Map<String, int>.from(progress.levelStars);
    final currentStars = levelStars[levelId] ?? 0;
    if (stars > currentStars) {
      levelStars[levelId] = stars;
    }

    // Calculate total stars
    final totalStars = levelStars.values.fold(0, (sum, s) => sum + s);

    // Update level statistics
    final levelStats = Map<String, LevelStats>.from(progress.levelStatistics);
    final existingStats = levelStats[levelId];
    
    final newStats = LevelStats(
      levelId: levelId,
      attempts: (existingStats?.attempts ?? 0) + 1,
      mistakes: mistakes,
      hintsUsed: hintsUsed,
      starsEarned: stars,
      xpEarned: xpEarned,
      firstCompletedAt: existingStats?.firstCompletedAt ?? now,
      lastAttemptedAt: now,
      bestTime: _updateBestTime(existingStats?.bestTime, timeTaken),
    );

    levelStats[levelId] = newStats;

    // Update streak
    int newStreak = progress.dailyStreak;
    if (progress.shouldUpdateStreak(now)) {
      newStreak++;
    } else if (progress.isStreakBroken(now)) {
      newStreak = 1;
    }

    final updatedProgress = progress.copyWith(
      currentXP: progress.currentXP + xpEarned,
      currentLevelId: levelId,
      completedLevels: completedLevels,
      levelStars: levelStars,
      starsEarned: totalStars,
      dailyStreak: newStreak,
      totalMistakes: progress.totalMistakes + mistakes,
      totalHintsUsed: progress.totalHintsUsed + hintsUsed,
      lastPlayedDate: now,
      levelStatistics: levelStats,
    );

    await saveProgress(updatedProgress);
    return updatedProgress;
  }

  /// Update best time (keep fastest)
  static Duration? _updateBestTime(Duration? currentBest, Duration? newTime) {
    if (newTime == null) return currentBest;
    if (currentBest == null) return newTime;
    return newTime < currentBest ? newTime : currentBest;
  }

  /// Set current level
  static Future<PlayerProgress> setCurrentLevel(String levelId) async {
    final progress = await loadProgress();
    final updatedProgress = progress.copyWith(currentLevelId: levelId);
    await saveProgress(updatedProgress);
    return updatedProgress;
  }

  /// Get statistics for a specific level
  static Future<LevelStats?> getLevelStats(String levelId) async {
    final progress = await loadProgress();
    return progress.levelStatistics[levelId];
  }

  /// Reset all progress (use with caution!)
  static Future<void> resetProgress() async {
    final initialProgress = PlayerProgress.initial();
    await saveProgress(initialProgress);
  }

  /// Export progress as JSON (for backup or debugging)
  static Future<Map<String, dynamic>> exportProgress() async {
    final progress = await loadProgress();
    return progress.toJson();
  }

  /// Import progress from JSON (for restore)
  static Future<void> importProgress(Map<String, dynamic> json) async {
    final progress = PlayerProgress.fromJson(Map<String, dynamic>.from(json));
    await saveProgress(progress);
  }

  /// Close the Hive box (call when app closes)
  static Future<void> close() async {
    await _box.close();
  }
}

/// Example usage in main.dart:
/// 
/// ```dart
/// void main() async {
///   WidgetsFlutterBinding.ensureInitialized();
///   await Hive.initFlutter();
///   await HiveProgressService.initialize();
///   runApp(MyApp());
/// }
/// ```
/// 
/// Example usage in a screen:
/// 
/// ```dart
/// // Load progress
/// final progress = await HiveProgressService.loadProgress();
/// print('Current XP: ${progress.currentXP}');
/// 
/// // Complete a level
/// final updated = await HiveProgressService.markLevelCompleted(
///   levelId: 'w1_l1',
///   stars: 3,
///   xpEarned: 50,
///   mistakes: 0,
///   hintsUsed: 0,
/// );
/// 
/// // Add XP
/// await HiveProgressService.addXP(100);
/// ```
