/// Simplified Lesson model for data-driven content
/// This consolidates all lesson, guided example, and challenge data in one place
class Lesson {
  final int id;
  final String title;
  final String subtitle;
  final String conceptExplanation;
  final String exampleCode;
  final String challengeQuestion;
  final String starterCode;
  final String correctCode;
  final List<String> hints;
  final String difficulty;
  final int xp;
  final List<String> keyPoints;
  final List<GuidedStepData> guidedSteps;

  Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.conceptExplanation,
    required this.exampleCode,
    required this.challengeQuestion,
    required this.starterCode,
    required this.correctCode,
    required this.hints,
    required this.difficulty,
    required this.xp,
    required this.keyPoints,
    required this.guidedSteps,
  });
}

/// Represents a single step in the guided example
class GuidedStepData {
  final int stepNumber;
  final String title;
  final String explanation;
  final String code;

  GuidedStepData({
    required this.stepNumber,
    required this.title,
    required this.explanation,
    required this.code,
  });
}
