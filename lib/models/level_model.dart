import 'challenge_models.dart';
import 'lesson_content_model.dart';

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
  final List<Challenge> challenges;
  final DifficultyLevel difficulty;
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
    required this.challenges,
    this.difficulty = DifficultyLevel.easy,
    required this.baseXP,
    required this.explanation,
    this.commonMistakes = const [],
    this.hints = const [],
    this.isLocked = true,
    this.lessonContent,
    this.guidedExample,
  }) : assert(challenges.length > 0, 'Level must contain at least one challenge');

  Level copyWith({
    String? id,
    String? worldId,
    int? levelNumber,
    String? title,
    String? concept,
    String? learningObjective,
    List<Challenge>? challenges,
    DifficultyLevel? difficulty,
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
      challenges: challenges ?? this.challenges,
      difficulty: difficulty ?? this.difficulty,
      baseXP: baseXP ?? this.baseXP,
      explanation: explanation ?? this.explanation,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      hints: hints ?? this.hints,
      isLocked: isLocked ?? this.isLocked,
      lessonContent: lessonContent ?? this.lessonContent,
      guidedExample: guidedExample ?? this.guidedExample,
    );
  }

  Challenge get primaryChallenge => challenges.first;

  Challenge? get primaryCodeChallenge {
    for (final challenge in challenges) {
      if (challenge.type == ChallengeType.code ||
          challenge.type == ChallengeType.fixCode) {
        return challenge;
      }
    }
    return challenges.isNotEmpty ? challenges.first : null;
  }

  String get challengeDescription => primaryChallenge.prompt;

  List<String> get validationRules =>
      primaryCodeChallenge?.validationRules ??
      primaryCodeChallenge?.fixRules ??
      const [];

  String get expectedCode =>
      lessonContent?.codeExample ??
      primaryCodeChallenge?.codeSnippet ??
      primaryChallenge.prompt;
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
