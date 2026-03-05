class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final int xpReward;
  final AchievementType type;
  final int targetValue;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.xpReward,
    required this.type,
    this.targetValue = 1,
  });
}

enum AchievementType {
  completeWorld,
  perfectStars,
  fixBugs,
  noHints,
  dailyStreak,
  levelUp,
}

class Badge {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final bool isEarned;

  Badge({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    this.isEarned = false,
  });

  Badge copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    bool? isEarned,
  }) {
    return Badge(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      isEarned: isEarned ?? this.isEarned,
    );
  }
}
