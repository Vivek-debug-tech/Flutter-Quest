import '../models/user_progress_model.dart';
import '../services/storage_service.dart';

class AchievementIds {
  static const String firstChallenge = 'FIRST_CHALLENGE';
  static const String tenChallenges = 'TEN_CHALLENGES';
  static const String noHintMaster = 'NO_HINT_MASTER';
  static const String hundredXP = 'HUNDRED_XP';
}

class AchievementManager {
  static const Map<String, String> achievementTitles = {
    AchievementIds.firstChallenge: 'First Challenge',
    AchievementIds.tenChallenges: 'Ten Challenges',
    AchievementIds.noHintMaster: 'No Hint Master',
    AchievementIds.hundredXP: 'Hundred XP',
  };

  static Future<List<String>> updateAchievements({
    required StorageService storageService,
    required UserProgress userProgress,
    required int hintsUsed,
  }) async {
    final unlocked = storageService.getUnlockedAchievements().toSet();
    final newlyUnlocked = <String>[];

    void unlockIfNeeded(String achievementId, bool shouldUnlock) {
      if (shouldUnlock && !unlocked.contains(achievementId)) {
        unlocked.add(achievementId);
        newlyUnlocked.add(achievementId);
      }
    }

    unlockIfNeeded(
      AchievementIds.firstChallenge,
      userProgress.completedLevels.isNotEmpty,
    );
    unlockIfNeeded(
      AchievementIds.tenChallenges,
      userProgress.completedLevels.length >= 10,
    );
    unlockIfNeeded(AchievementIds.noHintMaster, hintsUsed == 0);
    unlockIfNeeded(AchievementIds.hundredXP, userProgress.totalXP >= 100);

    if (newlyUnlocked.isNotEmpty) {
      await storageService.setUnlockedAchievements(unlocked.toList());
    }

    return newlyUnlocked;
  }

  static String getTitle(String achievementId) {
    return achievementTitles[achievementId] ?? achievementId;
  }
}
