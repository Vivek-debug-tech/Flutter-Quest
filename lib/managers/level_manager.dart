class LevelProgressInfo {
  final int currentLevel;
  final int currentLevelStartXP;
  final int nextLevelXP;
  final int currentLevelXP;
  final int xpNeededForNextLevel;
  final double progress;

  const LevelProgressInfo({
    required this.currentLevel,
    required this.currentLevelStartXP,
    required this.nextLevelXP,
    required this.currentLevelXP,
    required this.xpNeededForNextLevel,
    required this.progress,
  });
}

class LevelManager {
  static const int xpPerLevel = 120;

  static int getCurrentLevel(int totalXP) {
    if (totalXP < 0) {
      return 1;
    }

    return (totalXP ~/ xpPerLevel) + 1;
  }

  static int getNextLevelXP(int level) {
    return level * xpPerLevel;
  }

  static double getXPProgress(int totalXP) {
    final progressXP = totalXP % xpPerLevel;
    return progressXP / xpPerLevel;
  }

  static LevelProgressInfo getLevelProgressInfo(int totalXP) {
    final currentLevel = getCurrentLevel(totalXP);
    final currentLevelStartXP = (currentLevel - 1) * xpPerLevel;
    final nextLevelXP = getNextLevelXP(currentLevel);
    final currentLevelXP = totalXP - currentLevelStartXP;

    return LevelProgressInfo(
      currentLevel: currentLevel,
      currentLevelStartXP: currentLevelStartXP,
      nextLevelXP: nextLevelXP,
      currentLevelXP: currentLevelXP,
      xpNeededForNextLevel: xpPerLevel,
      progress: getXPProgress(totalXP),
    );
  }
}
