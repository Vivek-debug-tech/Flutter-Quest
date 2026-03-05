import 'lesson_content_model.dart';

enum ChallengeType {
  fixBrokenUI,
  buildFromScratch,
  dragAndDrop,
  multipleChoice,
}

enum DifficultyLevel {
  easy,
  medium,
  hard,
}

class Level {
  final String id;
  final String worldId;
  final int levelNumber;
  final String title;
  final String concept;
  final String learningObjective;
  final ChallengeType challengeType;
  final DifficultyLevel difficulty;
  final String challengeDescription;
  final String expectedCode;
  final List<String> validationRules;
  final int baseXP;
  final String explanation;
  final List<String> commonMistakes;
  final List<String> hints;
  final bool isLocked;
  
  // New learning flow components
  final LessonContent? lessonContent;
  final GuidedExample? guidedExample;

  Level({
    required this.id,
    required this.worldId,
    required this.levelNumber,
    required this.title,
    required this.concept,
    required this.learningObjective,
    required this.challengeType,
    this.difficulty = DifficultyLevel.easy,
    required this.challengeDescription,
    required this.expectedCode,
    required this.validationRules,
    required this.baseXP,
    required this.explanation,
    this.commonMistakes = const [],
    this.hints = const [],
    this.isLocked = true,
    this.lessonContent,
    this.guidedExample,
  });

  Level copyWith({
    String? id,
    String? worldId,
    int? levelNumber,
    String? title,
    String? concept,
    String? learningObjective,
    ChallengeType? challengeType,
    DifficultyLevel? difficulty,
    String? challengeDescription,
    String? expectedCode,
    List<String>? validationRules,
    int? baseXP,
    String? explanation,
    List<String>? commonMistakes,
    List<String>? hints,
    bool? isLocked,
    LessonContent? lessonContent,
    GuidedExample? guidedExample,
  }) {
    return Level(
      id: id ?? this.id,
      worldId: worldId ?? this.worldId,
      levelNumber: levelNumber ?? this.levelNumber,
      title: title ?? this.title,
      concept: concept ?? this.concept,
      learningObjective: learningObjective ?? this.learningObjective,
      challengeType: challengeType ?? this.challengeType,
      difficulty: difficulty ?? this.difficulty,
      challengeDescription: challengeDescription ?? this.challengeDescription,
      expectedCode: expectedCode ?? this.expectedCode,
      validationRules: validationRules ?? this.validationRules,
      baseXP: baseXP ?? this.baseXP,
      explanation: explanation ?? this.explanation,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      hints: hints ?? this.hints,
      isLocked: isLocked ?? this.isLocked,
      lessonContent: lessonContent ?? this.lessonContent,
      guidedExample: guidedExample ?? this.guidedExample,
    );
  }
}

class LevelProgress {
  final String levelId;
  final bool isCompleted;
  final int starsEarned;
  final int xpEarned;
  final int hintsUsed;
  final int mistakesMade;
  final DateTime? completedAt;

  LevelProgress({
    required this.levelId,
    this.isCompleted = false,
    this.starsEarned = 0,
    this.xpEarned = 0,
    this.hintsUsed = 0,
    this.mistakesMade = 0,
    this.completedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'levelId': levelId,
      'isCompleted': isCompleted,
      'starsEarned': starsEarned,
      'xpEarned': xpEarned,
      'hintsUsed': hintsUsed,
      'mistakesMade': mistakesMade,
      'completedAt': completedAt?.toIso8601String(),
    };
  }

  factory LevelProgress.fromJson(Map<String, dynamic> json) {
    return LevelProgress(
      levelId: json['levelId'],
      isCompleted: json['isCompleted'] ?? false,
      starsEarned: json['starsEarned'] ?? 0,
      xpEarned: json['xpEarned'] ?? 0,
      hintsUsed: json['hintsUsed'] ?? 0,
      mistakesMade: json['mistakesMade'] ?? 0,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt']) 
          : null,
    );
  }
}
