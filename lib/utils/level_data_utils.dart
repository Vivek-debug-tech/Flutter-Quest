import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';

/// Utility functions for working with the Level and Challenge models
/// Demonstrates how to use the scalable data structure
class LevelDataUtils {
  /// Get all MCQ challenges from a level
  static List<ChallengeStep> getMCQChallenges(LevelModel level) {
    return level.challengeSteps
        .where((step) => step.type == ChallengeType.multipleChoice)
        .toList();
  }

  /// Get all coding challenges (BuildWidget + FixTheBug)
  static List<ChallengeStep> getCodingChallenges(LevelModel level) {
    return level.challengeSteps
        .where((step) =>
            step.type == ChallengeType.buildWidget ||
            step.type == ChallengeType.fixTheBug)
        .toList();
  }

  /// Get all FillInBlank challenges
  static List<ChallengeStep> getFillInBlankChallenges(LevelModel level) {
    return level.challengeSteps
        .where((step) => step.type == ChallengeType.fillInBlank)
        .toList();
  }

  /// Calculate progress percentage for a level
  static double calculateProgress(
    LevelModel level,
    Set<String> completedStepIds,
  ) {
    if (level.challengeSteps.isEmpty) return 0.0;
    
    final completedCount = level.challengeSteps
        .where((step) => completedStepIds.contains(step.id))
        .length;
    
    return (completedCount / level.challengeSteps.length) * 100;
  }

  /// Calculate XP earned for completed steps
  static int calculateEarnedXP(
    LevelModel level,
    Set<String> completedStepIds,
    bool perfectCompletion,
  ) {
    int earnedXP = level.baseXP;

    // Add XP from completed challenge steps
    for (final step in level.challengeSteps) {
      if (completedStepIds.contains(step.id)) {
        earnedXP += step.xpReward;
      }
    }

    // Add bonus XP if perfect completion (no hints used, no mistakes)
    if (perfectCompletion && completedStepIds.length == level.challengeSteps.length) {
      earnedXP += level.bonusXP;
    }

    return earnedXP;
  }

  /// Get the correct answer for an MCQ challenge
  static OptionModel? getCorrectOption(ChallengeStep mcqStep) {
    if (mcqStep.type != ChallengeType.multipleChoice || mcqStep.options == null) {
      return null;
    }

    return mcqStep.options!.firstWhere(
      (option) => option.isCorrect,
      orElse: () => mcqStep.options!.first,
    );
  }

  /// Validate user answer for different challenge types
  static bool validateAnswer(ChallengeStep step, String userAnswer) {
    switch (step.type) {
      case ChallengeType.multipleChoice:
        // Check if the selected option ID is correct
        final correctOption = getCorrectOption(step);
        return correctOption?.id == userAnswer;

      case ChallengeType.fillInBlank:
        // Check if answer matches (case-sensitive by default)
        return step.correctAnswer?.trim() == userAnswer.trim();

      case ChallengeType.arrangeCode:
        // Check if the arranged order matches the correct order
        return userAnswer == step.correctOrder?.join(',');

      case ChallengeType.fixTheBug:
      case ChallengeType.buildWidget:
      case ChallengeType.interactiveCode:
        // For code challenges, validation would need more sophisticated checking
        // This is a placeholder - real validation would check against validation rules
        return _validateCode(userAnswer, step.validationRules ?? []);
    }
  }

  /// Basic code validation against rules
  static bool _validateCode(String code, List<String> rules) {
    if (rules.isEmpty) return true;

    for (final rule in rules) {
      // Simple contains check - in production, use regex or AST parsing
      if (!code.contains(rule)) {
        return false;
      }
    }

    return true;
  }

  /// Get next uncompleted challenge step
  static ChallengeStep? getNextChallenge(
    LevelModel level,
    Set<String> completedStepIds,
  ) {
    for (final step in level.challengeSteps) {
      if (!completedStepIds.contains(step.id)) {
        return step;
      }
    }
    return null; // All completed
  }

  /// Check if level is fully completed
  static bool isLevelComplete(
    LevelModel level,
    Set<String> completedStepIds,
  ) {
    return level.challengeSteps.every(
      (step) => completedStepIds.contains(step.id),
    );
  }

  /// Get difficulty emoji for display
  static String getDifficultyEmoji(DifficultyLevel difficulty) {
    switch (difficulty) {
      case DifficultyLevel.beginner:
        return '⭐';
      case DifficultyLevel.intermediate:
        return '⭐⭐';
      case DifficultyLevel.advanced:
        return '⭐⭐⭐';
    }
  }

  /// Get challenge type icon
  static String getChallengeTypeIcon(ChallengeType type) {
    switch (type) {
      case ChallengeType.multipleChoice:
        return '📝';
      case ChallengeType.fillInBlank:
        return '✏️';
      case ChallengeType.arrangeCode:
        return '🧩';
      case ChallengeType.fixTheBug:
        return '🐛';
      case ChallengeType.buildWidget:
        return '🔨';
      case ChallengeType.interactiveCode:
        return '💻';
    }
  }

  /// Get challenge type display name
  static String getChallengeTypeName(ChallengeType type) {
    switch (type) {
      case ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case ChallengeType.fillInBlank:
        return 'Fill in the Blank';
      case ChallengeType.arrangeCode:
        return 'Arrange Code';
      case ChallengeType.fixTheBug:
        return 'Fix the Bug';
      case ChallengeType.buildWidget:
        return 'Build Widget';
      case ChallengeType.interactiveCode:
        return 'Interactive Code';
    }
  }

  /// Group challenges by type for analytics
  static Map<ChallengeType, int> getChallengeTypeDistribution(LevelModel level) {
    final distribution = <ChallengeType, int>{};

    for (final step in level.challengeSteps) {
      distribution[step.type] = (distribution[step.type] ?? 0) + 1;
    }

    return distribution;
  }

  /// Generate level summary for display
  static String getLevelSummary(LevelModel level) {
    final distribution = getChallengeTypeDistribution(level);
    final parts = <String>[];

    distribution.forEach((type, count) {
      parts.add('$count ${getChallengeTypeName(type)}');
    });

    return '''
📚 ${level.title}
${getDifficultyEmoji(level.difficulty)} ${level.difficulty.name}
⏱️ ${level.timeEstimate?.inMinutes ?? '?'} minutes
🎯 ${level.challengeSteps.length} challenges: ${parts.join(', ')}
💰 ${level.totalPossibleXP} XP available
''';
  }
}
