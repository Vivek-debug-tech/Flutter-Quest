import 'package:hive/hive.dart';

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
    return (100 * (currentLevel * 1.2)).round();
  }

  // Calculate current level progress percentage
  double get levelProgress {
    int xpForPrevLevel = currentLevel > 1 
        ? (100 * ((currentLevel - 1) * 1.2)).round() 
        : 0;
    int xpNeeded = xpForNextLevel - xpForPrevLevel;
    int currentXPInLevel = totalXP - xpForPrevLevel;
    return (currentXPInLevel / xpNeeded).clamp(0.0, 1.0);
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
    
    // Check for level up
    while (totalXP >= xpForNextLevel) {
      currentLevel++;
    }
    
    save();
  }

  // Update daily streak
  void updateStreak() {
    final now = DateTime.now();
    
    if (lastLoginDate == null) {
      currentStreak = 1;
      lastLoginDate = now;
    } else {
      final difference = now.difference(lastLoginDate!).inDays;
      
      if (difference == 1) {
        // Consecutive day
        currentStreak++;
      } else if (difference > 1) {
        // Streak broken
        currentStreak = 1;
      }
      // Same day, no change
      
      lastLoginDate = now;
    }
    
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
    if (!earnedBadges.contains(badgeId)) {
      earnedBadges.add(badgeId);
      save();
    }
  }
}
