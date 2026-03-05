/// XP Reward Engine for FlutterQuest
/// Calculates XP based on performance, mistakes, and hints used
class XPCalculator {
  /// Base penalty for each mistake
  static const int mistakePenalty = 5;

  /// Penalty for each hint used
  static const int hintPenalty = 3;

  /// Minimum XP that can be earned (never goes below this)
  static const int minimumXP = 10;

  /// Perfect completion bonus (no mistakes, no hints)
  static const int perfectBonus = 20;

  /// Calculate final XP earned for a level
  ///
  /// [baseXP] - Base XP value for the level
  /// [mistakes] - Number of incorrect attempts
  /// [hintsUsed] - Number of hints requested
  /// [timeTaken] - Time taken to complete (optional, for time bonus)
  /// [expectedTime] - Expected completion time (optional)
  static int calculateXP({
    required int baseXP,
    required int mistakes,
    required int hintsUsed,
    Duration? timeTaken,
    Duration? expectedTime,
  }) {
    // Start with base XP
    int finalXP = baseXP;

    // Subtract penalties
    finalXP -= (mistakes * mistakePenalty);
    finalXP -= (hintsUsed * hintPenalty);

    // Add perfect bonus if applicable
    if (mistakes == 0 && hintsUsed == 0) {
      finalXP += perfectBonus;
    }

    // Add time bonus if completed faster than expected
    if (timeTaken != null && expectedTime != null) {
      finalXP += _calculateTimeBonus(timeTaken, expectedTime);
    }

    // Ensure minimum XP
    return finalXP < minimumXP ? minimumXP : finalXP;
  }

  /// Calculate bonus XP for completing faster than expected
  static int _calculateTimeBonus(Duration timeTaken, Duration expectedTime) {
    if (timeTaken >= expectedTime) return 0;

    final percentageFaster =
        ((expectedTime.inSeconds - timeTaken.inSeconds) /
            expectedTime.inSeconds) *
        100;

    // Award up to 15 bonus XP for being 50% faster or more
    if (percentageFaster >= 50) return 15;
    if (percentageFaster >= 30) return 10;
    if (percentageFaster >= 10) return 5;

    return 0;
  }

  /// Calculate XP multiplier based on difficulty
  static double getDifficultyMultiplier(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return 1.0;
      case 'intermediate':
        return 1.5;
      case 'advanced':
        return 2.0;
      default:
        return 1.0;
    }
  }

  /// Get XP breakdown for display to user
  static XPBreakdown getXPBreakdown({
    required int baseXP,
    required int mistakes,
    required int hintsUsed,
    Duration? timeTaken,
    Duration? expectedTime,
  }) {
    final mistakePenaltyTotal = mistakes * mistakePenalty;
    final hintPenaltyTotal = hintsUsed * hintPenalty;
    final isPerfect = mistakes == 0 && hintsUsed == 0;
    final timeBonus = (timeTaken != null && expectedTime != null)
        ? _calculateTimeBonus(timeTaken, expectedTime)
        : 0;

    final finalXP = calculateXP(
      baseXP: baseXP,
      mistakes: mistakes,
      hintsUsed: hintsUsed,
      timeTaken: timeTaken,
      expectedTime: expectedTime,
    );

    return XPBreakdown(
      baseXP: baseXP,
      mistakePenalty: mistakePenaltyTotal,
      hintPenalty: hintPenaltyTotal,
      perfectBonus: isPerfect ? perfectBonus : 0,
      timeBonus: timeBonus,
      finalXP: finalXP,
    );
  }

  /// Calculate stars earned (1-3) based on performance
  static int calculateStars({required int mistakes, required int hintsUsed}) {
    // 3 stars: Perfect (0 mistakes, no hints)
    if (mistakes == 0 && hintsUsed == 0) {
      return 3;
    }

    // 2 stars: Good (1-2 mistakes OR 1-2 hints)
    if (mistakes <= 2 && hintsUsed <= 2) {
      return 2;
    }

    // 1 star: Completed (any number of mistakes/hints)
    return 1;
  }

  /// Get performance message based on stars
  static String getPerformanceMessage(int stars) {
    switch (stars) {
      case 3:
        return "🌟 Perfect! You're a Flutter master!";
      case 2:
        return "⭐ Great job! Keep learning!";
      case 1:
        return "✨ Good effort! Practice makes perfect!";
      default:
        return "Keep trying!";
    }
  }

  /// Calculate streak bonus XP
  static int calculateStreakBonus(int dailyStreak) {
    if (dailyStreak < 3) return 0;
    if (dailyStreak < 7) return 10;
    if (dailyStreak < 14) return 20;
    if (dailyStreak < 30) return 30;
    return 50; // 30+ day streak
  }
}

/// Breakdown of XP calculation for display
class XPBreakdown {
  final int baseXP;
  final int mistakePenalty;
  final int hintPenalty;
  final int perfectBonus;
  final int timeBonus;
  final int finalXP;

  const XPBreakdown({
    required this.baseXP,
    required this.mistakePenalty,
    required this.hintPenalty,
    required this.perfectBonus,
    required this.timeBonus,
    required this.finalXP,
  });

  /// Get list of XP components for UI display
  List<XPComponent> get components {
    final List<XPComponent> items = [
      XPComponent(label: 'Base XP', value: baseXP, isPositive: true),
    ];

    if (mistakePenalty > 0) {
      items.add(
        XPComponent(
          label: 'Mistakes',
          value: -mistakePenalty,
          isPositive: false,
        ),
      );
    }

    if (hintPenalty > 0) {
      items.add(
        XPComponent(
          label: 'Hints Used',
          value: -hintPenalty,
          isPositive: false,
        ),
      );
    }

    if (perfectBonus > 0) {
      items.add(
        XPComponent(
          label: 'Perfect Bonus',
          value: perfectBonus,
          isPositive: true,
        ),
      );
    }

    if (timeBonus > 0) {
      items.add(
        XPComponent(label: 'Speed Bonus', value: timeBonus, isPositive: true),
      );
    }

    items.add(
      XPComponent(
        label: 'Total XP',
        value: finalXP,
        isPositive: true,
        isFinal: true,
      ),
    );

    return items;
  }
}

/// Single component of XP calculation
class XPComponent {
  final String label;
  final int value;
  final bool isPositive;
  final bool isFinal;

  const XPComponent({
    required this.label,
    required this.value,
    required this.isPositive,
    this.isFinal = false,
  });
}
