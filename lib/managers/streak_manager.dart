class StreakResult {
  final int currentStreak;
  final DateTime lastLoginDate;

  const StreakResult({
    required this.currentStreak,
    required this.lastLoginDate,
  });
}

class StreakManager {
  static StreakResult updateStreak({
    required DateTime? lastLoginDate,
    required int currentStreak,
    DateTime? now,
  }) {
    final currentDate = _normalizeDate(now ?? DateTime.now());

    if (lastLoginDate == null) {
      return StreakResult(currentStreak: 1, lastLoginDate: currentDate);
    }

    final previousDate = _normalizeDate(lastLoginDate);
    final difference = currentDate.difference(previousDate).inDays;

    if (difference <= 0) {
      return StreakResult(
        currentStreak: currentStreak == 0 ? 1 : currentStreak,
        lastLoginDate: previousDate,
      );
    }

    if (difference == 1) {
      return StreakResult(
        currentStreak: currentStreak + 1,
        lastLoginDate: currentDate,
      );
    }

    return StreakResult(currentStreak: 1, lastLoginDate: currentDate);
  }

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
