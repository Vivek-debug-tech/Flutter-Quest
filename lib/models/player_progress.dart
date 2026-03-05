/// Represents the player's progress in the FlutterQuest learning game
/// Tracks XP, levels completed, stars earned, and learning statistics
class PlayerProgress {
  final int currentXP;
  final String currentLevelId;
  final List<String> completedLevels;
  final Map<String, int> levelStars; // levelId -> stars (1-3)
  final int starsEarned;
  final int dailyStreak;
  final int totalMistakes;
  final int totalHintsUsed;
  final DateTime lastPlayedDate;
  final Map<String, LevelStats> levelStatistics; // Detailed stats per level

  const PlayerProgress({
    this.currentXP = 0,
    this.currentLevelId = '',
    this.completedLevels = const [],
    this.levelStars = const {},
    this.starsEarned = 0,
    this.dailyStreak = 0,
    this.totalMistakes = 0,
    this.totalHintsUsed = 0,
    required this.lastPlayedDate,
    this.levelStatistics = const {},
  });

  /// Calculate player level based on XP (e.g., 100 XP per level)
  int get playerLevel => (currentXP / 100).floor() + 1;

  /// XP needed for next level
  int get xpForNextLevel => (playerLevel * 100) - currentXP;

  /// Progress percentage to next level (0-100)
  double get levelProgress {
    final currentLevelXP = currentXP % 100;
    return (currentLevelXP / 100) * 100;
  }

  /// Check if level is completed
  bool isLevelCompleted(String levelId) {
    return completedLevels.contains(levelId);
  }

  /// Get stars for a specific level (0-3)
  int getStarsForLevel(String levelId) {
    return levelStars[levelId] ?? 0;
  }

  /// Check if should update daily streak
  bool shouldUpdateStreak(DateTime now) {
    final difference = now.difference(lastPlayedDate);
    return difference.inDays == 1;
  }

  /// Check if streak is broken
  bool isStreakBroken(DateTime now) {
    final difference = now.difference(lastPlayedDate);
    return difference.inDays > 1;
  }

  /// Create a copy with updated values
  PlayerProgress copyWith({
    int? currentXP,
    String? currentLevelId,
    List<String>? completedLevels,
    Map<String, int>? levelStars,
    int? starsEarned,
    int? dailyStreak,
    int? totalMistakes,
    int? totalHintsUsed,
    DateTime? lastPlayedDate,
    Map<String, LevelStats>? levelStatistics,
  }) {
    return PlayerProgress(
      currentXP: currentXP ?? this.currentXP,
      currentLevelId: currentLevelId ?? this.currentLevelId,
      completedLevels: completedLevels ?? this.completedLevels,
      levelStars: levelStars ?? this.levelStars,
      starsEarned: starsEarned ?? this.starsEarned,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      totalMistakes: totalMistakes ?? this.totalMistakes,
      totalHintsUsed: totalHintsUsed ?? this.totalHintsUsed,
      lastPlayedDate: lastPlayedDate ?? this.lastPlayedDate,
      levelStatistics: levelStatistics ?? this.levelStatistics,
    );
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'currentXP': currentXP,
      'currentLevelId': currentLevelId,
      'completedLevels': completedLevels,
      'levelStars': levelStars,
      'starsEarned': starsEarned,
      'dailyStreak': dailyStreak,
      'totalMistakes': totalMistakes,
      'totalHintsUsed': totalHintsUsed,
      'lastPlayedDate': lastPlayedDate.toIso8601String(),
      'levelStatistics': levelStatistics.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }

  /// Create from JSON
  factory PlayerProgress.fromJson(Map<String, dynamic> json) {
    return PlayerProgress(
      currentXP: json['currentXP'] as int? ?? 0,
      currentLevelId: json['currentLevelId'] as String? ?? '',
      completedLevels: (json['completedLevels'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      levelStars: (json['levelStars'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, value as int),
          ) ??
          {},
      starsEarned: json['starsEarned'] as int? ?? 0,
      dailyStreak: json['dailyStreak'] as int? ?? 0,
      totalMistakes: json['totalMistakes'] as int? ?? 0,
      totalHintsUsed: json['totalHintsUsed'] as int? ?? 0,
      lastPlayedDate: json['lastPlayedDate'] != null
          ? DateTime.parse(json['lastPlayedDate'] as String)
          : DateTime.now(),
      levelStatistics: (json['levelStatistics'] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(
              key,
              LevelStats.fromJson(Map<String, dynamic>.from(value as Map)),
            ),
          ) ??
          {},
    );
  }

  /// Create initial progress for new player
  factory PlayerProgress.initial() {
    return PlayerProgress(
      currentXP: 0,
      currentLevelId: 'w1_l1',
      completedLevels: const [],
      levelStars: const {},
      starsEarned: 0,
      dailyStreak: 0,
      totalMistakes: 0,
      totalHintsUsed: 0,
      lastPlayedDate: DateTime.now(),
      levelStatistics: const {},
    );
  }
}

/// Detailed statistics for a single level
class LevelStats {
  final String levelId;
  final int attempts;
  final int mistakes;
  final int hintsUsed;
  final int starsEarned;
  final int xpEarned;
  final DateTime? firstCompletedAt;
  final DateTime? lastAttemptedAt;
  final Duration? bestTime;

  const LevelStats({
    required this.levelId,
    this.attempts = 0,
    this.mistakes = 0,
    this.hintsUsed = 0,
    this.starsEarned = 0,
    this.xpEarned = 0,
    this.firstCompletedAt,
    this.lastAttemptedAt,
    this.bestTime,
  });

  LevelStats copyWith({
    String? levelId,
    int? attempts,
    int? mistakes,
    int? hintsUsed,
    int? starsEarned,
    int? xpEarned,
    DateTime? firstCompletedAt,
    DateTime? lastAttemptedAt,
    Duration? bestTime,
  }) {
    return LevelStats(
      levelId: levelId ?? this.levelId,
      attempts: attempts ?? this.attempts,
      mistakes: mistakes ?? this.mistakes,
      hintsUsed: hintsUsed ?? this.hintsUsed,
      starsEarned: starsEarned ?? this.starsEarned,
      xpEarned: xpEarned ?? this.xpEarned,
      firstCompletedAt: firstCompletedAt ?? this.firstCompletedAt,
      lastAttemptedAt: lastAttemptedAt ?? this.lastAttemptedAt,
      bestTime: bestTime ?? this.bestTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'levelId': levelId,
      'attempts': attempts,
      'mistakes': mistakes,
      'hintsUsed': hintsUsed,
      'starsEarned': starsEarned,
      'xpEarned': xpEarned,
      'firstCompletedAt': firstCompletedAt?.toIso8601String(),
      'lastAttemptedAt': lastAttemptedAt?.toIso8601String(),
      'bestTime': bestTime?.inSeconds,
    };
  }

  factory LevelStats.fromJson(Map<String, dynamic> json) {
    return LevelStats(
      levelId: json['levelId'] as String,
      attempts: json['attempts'] as int? ?? 0,
      mistakes: json['mistakes'] as int? ?? 0,
      hintsUsed: json['hintsUsed'] as int? ?? 0,
      starsEarned: json['starsEarned'] as int? ?? 0,
      xpEarned: json['xpEarned'] as int? ?? 0,
      firstCompletedAt: json['firstCompletedAt'] != null
          ? DateTime.parse(json['firstCompletedAt'] as String)
          : null,
      lastAttemptedAt: json['lastAttemptedAt'] != null
          ? DateTime.parse(json['lastAttemptedAt'] as String)
          : null,
      bestTime: json['bestTime'] != null
          ? Duration(seconds: json['bestTime'] as int)
          : null,
    );
  }
}
