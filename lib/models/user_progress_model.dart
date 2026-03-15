import 'package:hive/hive.dart';
import '../managers/level_manager.dart';
import '../managers/streak_manager.dart';

part 'user_progress_model.g.dart';

@HiveType(typeId: 0)
class UserProgress extends HiveObject {
  @HiveField(0)
  int totalXP;

  @HiveField(1)
  int currentLevel;

  @HiveField(2)
  List<String> unlockedWorlds;

  @HiveField(3)
  List<String> completedLevels;

  // Deprecated: replaced by unlockedAchievements
  @HiveField(4)
  List<String> earnedBadges;

  @HiveField(5)
  int currentStreak;

  @HiveField(6)
  DateTime? lastLoginDate;

  @HiveField(7)
  Map<dynamic, dynamic> levelProgressMap;

  UserProgress({
    this.totalXP = 0,
    this.currentLevel = 1,
    List<String>? unlockedWorlds,
    List<String>? completedLevels,
    // Deprecated: replaced by unlockedAchievements
    List<String>? earnedBadges,
    this.currentStreak = 0,
    this.lastLoginDate,
    Map<dynamic, dynamic>? levelProgressMap,
  })  : unlockedWorlds = unlockedWorlds ?? ['world_1'],
        completedLevels = completedLevels ?? [],
        earnedBadges = earnedBadges ?? [],
        levelProgressMap = levelProgressMap ?? {};

  // Calculate XP required for next level
  int get xpForNextLevel {
    return LevelManager.getNextLevelXP(currentLevel);
  }

  // Calculate current level progress percentage
  double get levelProgress {
    return LevelManager.getXPProgress(totalXP);
  }

  // Get user title based on level
  String get userTitle {
    if (currentLevel <= 3) return 'Flutter Beginner';
    if (currentLevel <= 6) return 'Widget Explorer';
    if (currentLevel <= 10) return 'Layout Master';
    if (currentLevel <= 15) return 'State Architect';
    return 'Flutter Pro';
  }

  // Add XP and handle level ups
  void addXP(int xp) {
    totalXP += xp;
    currentLevel = LevelManager.getCurrentLevel(totalXP);
    save();
  }

  // Update daily streak
  void updateStreak() {
    final result = StreakManager.updateStreak(
      lastLoginDate: lastLoginDate,
      currentStreak: currentStreak,
    );
    currentStreak = result.currentStreak;
    lastLoginDate = result.lastLoginDate;
    save();
  }

  // Get streak bonus XP
  int get streakBonusXP {
    if (currentStreak == 0) return 0;
    if (currentStreak >= 14) return 50;
    if (currentStreak >= 7) return 50;
    if (currentStreak >= 3) return 15;
    return 5 * currentStreak;
  }

  // Mark level as completed
  void completeLevel(String levelId, int xp, int stars) {
    if (!completedLevels.contains(levelId)) {
      completedLevels.add(levelId);
    }
    
    addXP(xp);
    save();
  }

  // Unlock world
  void unlockWorld(String worldId) {
    if (!unlockedWorlds.contains(worldId)) {
      unlockedWorlds.add(worldId);
      save();
    }
  }

  // Award badge
  void awardBadge(String badgeId) {
    // Deprecated: replaced by unlockedAchievements
    if (!earnedBadges.contains(badgeId)) {
      earnedBadges.add(badgeId);
      save();
    }
  }
}
