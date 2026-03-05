import 'challenge_models.dart';

/// Represents a complete learning level in the game
/// Each level contains lesson content and multiple challenge steps
class LevelModel {
  // Basic identification
  final String id;
  final String worldId;
  final int levelNumber;
  final String title;
  final String concept; // Main concept being taught (e.g., "StatelessWidget")
  
  // Lesson content
  final String lessonText; // Main teaching content
  final String? codeExample; // Example code to demonstrate the concept
  final String learningObjective; // What the user will learn
  final String? analogy; // Real-world analogy to explain the concept
  final List<String> keyTakeaways; // Key points to remember
  
  // Challenge content
  final List<ChallengeStep> challengeSteps; // Multiple challenges per level
  
  // Metadata
  final DifficultyLevel difficulty;
  final int baseXP; // Base XP for completing the level
  final int bonusXP; // Bonus XP for perfect completion
  
  // Learning aids
  final List<String> hints; // General hints for the level
  final String explanation; // Overall explanation after completion
  final List<String> commonMistakes; // Common mistakes to watch out for
  final List<String>? prerequisites; // Previous concepts needed
  final List<String>? relatedConcepts; // Related topics to explore
  
  // Game mechanics
  final bool isLocked;
  final int? requiredStars; // Stars needed to unlock (if locked)
  final Duration? timeEstimate; // Estimated time to complete

  const LevelModel({
    required this.id,
    required this.worldId,
    required this.levelNumber,
    required this.title,
    required this.concept,
    required this.lessonText,
    this.codeExample,
    required this.learningObjective,
    this.analogy,
    this.keyTakeaways = const [],
    required this.challengeSteps,
    this.difficulty = DifficultyLevel.beginner,
    required this.baseXP,
    this.bonusXP = 0,
    this.hints = const [],
    required this.explanation,
    this.commonMistakes = const [],
    this.prerequisites,
    this.relatedConcepts,
    this.isLocked = true,
    this.requiredStars,
    this.timeEstimate,
  });

  /// Calculate total XP for this level (base + all challenge steps)
  int get totalPossibleXP {
    final challengeXP = challengeSteps.fold<int>(
      0,
      (sum, step) => sum + step.xpReward,
    );
    return baseXP + bonusXP + challengeXP;
  }

  /// Get total number of challenges in this level
  int get totalChallenges => challengeSteps.length;

  /// Check if level has any MCQ challenges
  bool get hasMultipleChoice =>
      challengeSteps.any((step) => step.type == ChallengeType.multipleChoice);

  /// Check if level requires coding
  bool get requiresCoding =>
      challengeSteps.any((step) =>
          step.type == ChallengeType.buildWidget ||
          step.type == ChallengeType.fixTheBug);

  LevelModel copyWith({
    String? id,
    String? worldId,
    int? levelNumber,
    String? title,
    String? concept,
    String? lessonText,
    String? codeExample,
    String? learningObjective,
    String? analogy,
    List<String>? keyTakeaways,
    List<ChallengeStep>? challengeSteps,
    DifficultyLevel? difficulty,
    int? baseXP,
    int? bonusXP,
    List<String>? hints,
    String? explanation,
    List<String>? commonMistakes,
    List<String>? prerequisites,
    List<String>? relatedConcepts,
    bool? isLocked,
    int? requiredStars,
    Duration? timeEstimate,
  }) {
    return LevelModel(
      id: id ?? this.id,
      worldId: worldId ?? this.worldId,
      levelNumber: levelNumber ?? this.levelNumber,
      title: title ?? this.title,
      concept: concept ?? this.concept,
      lessonText: lessonText ?? this.lessonText,
      codeExample: codeExample ?? this.codeExample,
      learningObjective: learningObjective ?? this.learningObjective,
      analogy: analogy ?? this.analogy,
      keyTakeaways: keyTakeaways ?? this.keyTakeaways,
      challengeSteps: challengeSteps ?? this.challengeSteps,
      difficulty: difficulty ?? this.difficulty,
      baseXP: baseXP ?? this.baseXP,
      bonusXP: bonusXP ?? this.bonusXP,
      hints: hints ?? this.hints,
      explanation: explanation ?? this.explanation,
      commonMistakes: commonMistakes ?? this.commonMistakes,
      prerequisites: prerequisites ?? this.prerequisites,
      relatedConcepts: relatedConcepts ?? this.relatedConcepts,
      isLocked: isLocked ?? this.isLocked,
      requiredStars: requiredStars ?? this.requiredStars,
      timeEstimate: timeEstimate ?? this.timeEstimate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'worldId': worldId,
      'levelNumber': levelNumber,
      'title': title,
      'concept': concept,
      'lessonText': lessonText,
      'codeExample': codeExample,
      'learningObjective': learningObjective,
      'analogy': analogy,
      'keyTakeaways': keyTakeaways,
      'challengeSteps': challengeSteps.map((s) => s.toJson()).toList(),
      'difficulty': difficulty.name,
      'baseXP': baseXP,
      'bonusXP': bonusXP,
      'hints': hints,
      'explanation': explanation,
      'commonMistakes': commonMistakes,
      'prerequisites': prerequisites,
      'relatedConcepts': relatedConcepts,
      'isLocked': isLocked,
      'requiredStars': requiredStars,
      'timeEstimate': timeEstimate?.inMinutes,
    };
  }

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'] as String,
      worldId: json['worldId'] as String,
      levelNumber: json['levelNumber'] as int,
      title: json['title'] as String,
      concept: json['concept'] as String,
      lessonText: json['lessonText'] as String,
      codeExample: json['codeExample'] as String?,
      learningObjective: json['learningObjective'] as String,
      analogy: json['analogy'] as String?,
      keyTakeaways: (json['keyTakeaways'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      challengeSteps: (json['challengeSteps'] as List<dynamic>)
          .map((s) => ChallengeStep.fromJson(Map<String, dynamic>.from(s as Map)))
          .toList(),
      difficulty: DifficultyLevel.values.firstWhere(
        (e) => e.name == json['difficulty'],
        orElse: () => DifficultyLevel.beginner,
      ),
      baseXP: json['baseXP'] as int,
      bonusXP: json['bonusXP'] as int? ?? 0,
      hints: (json['hints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      explanation: json['explanation'] as String,
      commonMistakes: (json['commonMistakes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      prerequisites: (json['prerequisites'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      relatedConcepts: (json['relatedConcepts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isLocked: json['isLocked'] as bool? ?? true,
      requiredStars: json['requiredStars'] as int?,
      timeEstimate: json['timeEstimate'] != null
          ? Duration(minutes: json['timeEstimate'] as int)
          : null,
    );
  }
}
