import 'dart:math';
import '../models/level_model.dart';

class XPService {
  // Calculate XP based on performance
  static int calculateXP({
    required int baseXP,
    required int hintsUsed,
    required int mistakesMade,
    required ChallengeType challengeType,
  }) {
    int xp = baseXP;
    
    // Bonus XP based on challenge type
    switch (challengeType) {
      case ChallengeType.buildFromScratch:
        xp += 25; // Hardest challenge
        break;
      case ChallengeType.fixBrokenUI:
        xp += 10; // Medium difficulty
        break;
      case ChallengeType.dragAndDrop:
        xp += 5; // Easier challenge
        break;
      case ChallengeType.multipleChoice:
        xp += 0; // Easiest challenge
        break;
    }
    
    // Accuracy bonus (no mistakes)
    if (mistakesMade == 0) {
      xp += 10;
    }
    
    // Hint penalty
    xp -= (hintsUsed * 5);
    
    // Ensure minimum XP
    return max(10, xp);
  }

  // Calculate star rating
  static int calculateStars({
    required int hintsUsed,
    required int mistakesMade,
  }) {
    if (hintsUsed == 0 && mistakesMade == 0) {
      return 3; // Perfect!
    } else if ((hintsUsed <= 1 && mistakesMade <= 2) || 
               (hintsUsed == 0 && mistakesMade <= 3)) {
      return 2; // Good
    } else {
      return 1; // Completed
    }
  }

  // Calculate XP required for level
  static int xpRequiredForLevel(int level) {
    return (100 * pow(level, 1.2)).round();
  }

  // Calculate current level from total XP
  static int calculateLevelFromXP(int totalXP) {
    int level = 1;
    while (totalXP >= xpRequiredForLevel(level)) {
      level++;
    }
    return level - 1;
  }

  // Get level title
  static String getLevelTitle(int level) {
    if (level <= 3) return 'Flutter Beginner';
    if (level <= 6) return 'Widget Explorer';
    if (level <= 10) return 'Layout Master';
    if (level <= 15) return 'State Architect';
    return 'Flutter Pro';
  }

  // Calculate daily streak bonus
  static int calculateStreakBonus(int streakDays) {
    if (streakDays >= 14) {
      return 50; // 2 week milestone
    } else if (streakDays >= 7) {
      return 50; // 1 week milestone
    } else if (streakDays >= 3) {
      return 15; // 3 day milestone
    } else if (streakDays > 0) {
      return 5 * streakDays; // Daily bonus
    }
    return 0;
  }

  // Check if should unlock next world
  static bool shouldUnlockNextWorld({
    required List<LevelProgress> worldProgress,
    required int requiredStars,
  }) {
    if (worldProgress.isEmpty) return false;
    
    // Calculate average stars
    int totalStars = worldProgress.fold(0, (sum, progress) => sum + progress.starsEarned);
    double averageStars = totalStars / worldProgress.length;
    
    return averageStars >= requiredStars;
  }

  // Calculate completion percentage for a world
  static double calculateWorldCompletion(List<LevelProgress> worldProgress, int totalLevels) {
    if (totalLevels == 0) return 0.0;
    
    int completedLevels = worldProgress.where((p) => p.isCompleted).length;
    return completedLevels / totalLevels;
  }
}
