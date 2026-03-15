/// Challenge types supported by the learning platform
enum ChallengeType {
  code,
  multipleChoice,
  fixCode,
  predictOutput,
}

/// Difficulty levels for game progression
enum DifficultyLevel {
  beginner,
  intermediate,
  advanced,
}

/// General-purpose challenge model supporting multiple types
class Challenge {
  final ChallengeType type;
  final String prompt;

  // For code challenges
  final List<String>? validationRules;

  // For multiple choice
  final List<String>? options;
  final int? correctIndex;

  // For fix code
  final String? brokenCode;
  final List<String>? fixRules;

  // For predict output
  final String? codeSnippet;
  final String? expectedOutput;

  Challenge({
    required this.type,
    required this.prompt,
    this.validationRules,
    this.options,
    this.correctIndex,
    this.brokenCode,
    this.fixRules,
    this.codeSnippet,
    this.expectedOutput,
  });
}

/// Represents a single option in a multiple choice question
class OptionModel {
  final String id;
  final String text;
  final bool isCorrect;
  final String? explanation; // Why this option is correct/incorrect

  const OptionModel({
    required this.id,
    required this.text,
    required this.isCorrect,
    this.explanation,
  });

  OptionModel copyWith({
    String? id,
    String? text,
    bool? isCorrect,
    String? explanation,
  }) {
    return OptionModel(
      id: id ?? this.id,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation ?? this.explanation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isCorrect': isCorrect,
      'explanation': explanation,
    };
  }

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      id: json['id'] as String,
      text: json['text'] as String,
      isCorrect: json['isCorrect'] as bool,
      explanation: json['explanation'] as String?,
    );
  }
}

/// Represents a single challenge step within a level
/// Each level can contain multiple challenge steps
class ChallengeStep {
  final String id;
  final int stepNumber;
  final ChallengeType type;
  final String question;
  final String? description; // Additional context for the challenge
  
  // For MCQ type
  final List<OptionModel>? options;
  
  // For FillInBlank type
  final String? blankPlaceholder; // e.g., "____" or specific hint
  final String? correctAnswer;
  
  // For FixTheBug type
  final String? brokenCode;
  final String? fixedCode;
  final String? bugHint;
  final String? codeSnippet; // For predict output
  
  // For BuildWidget type
  final String? widgetRequirement;
  final List<String>? requiredWidgets; // e.g., ['Container', 'Text', 'Column']
  final String? expectedOutput; // Description of expected UI
  
  // For ArrangeCode type
  final List<String>? codePieces; // Code pieces to arrange in correct order
  final List<String>? correctOrder; // Correct order of code pieces (by index or content)
  
  // Common fields
  final int xpReward;
  final List<String> hints;
  final String? explanation; // Explanation after completing this step
  final List<String>? validationRules; // Rules to validate the answer

  const ChallengeStep({
    required this.id,
    required this.stepNumber,
    required this.type,
    required this.question,
    this.description,
    this.options,
    this.blankPlaceholder,
    this.correctAnswer,
    this.brokenCode,
    this.fixedCode,
    this.bugHint,
    this.codeSnippet,
    this.widgetRequirement,
    this.requiredWidgets,
    this.expectedOutput,
    this.codePieces,
    this.correctOrder,
    this.xpReward = 10,
    this.hints = const [],
    this.explanation,
    this.validationRules,
  });

  ChallengeStep copyWith({
    String? id,
    int? stepNumber,
    ChallengeType? type,
    String? question,
    String? description,
    List<OptionModel>? options,
    String? blankPlaceholder,
    String? correctAnswer,
    String? brokenCode,
    String? fixedCode,
    String? bugHint,
    String? codeSnippet,
    String? widgetRequirement,
    List<String>? requiredWidgets,
    String? expectedOutput,
    List<String>? codePieces,
    List<String>? correctOrder,
    int? xpReward,
    List<String>? hints,
    String? explanation,
    List<String>? validationRules,
  }) {
    return ChallengeStep(
      id: id ?? this.id,
      stepNumber: stepNumber ?? this.stepNumber,
      type: type ?? this.type,
      question: question ?? this.question,
      description: description ?? this.description,
      options: options ?? this.options,
      blankPlaceholder: blankPlaceholder ?? this.blankPlaceholder,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      brokenCode: brokenCode ?? this.brokenCode,
      fixedCode: fixedCode ?? this.fixedCode,
      bugHint: bugHint ?? this.bugHint,
      codeSnippet: codeSnippet ?? this.codeSnippet,
      widgetRequirement: widgetRequirement ?? this.widgetRequirement,
      requiredWidgets: requiredWidgets ?? this.requiredWidgets,
      expectedOutput: expectedOutput ?? this.expectedOutput,
      codePieces: codePieces ?? this.codePieces,
      correctOrder: correctOrder ?? this.correctOrder,
      xpReward: xpReward ?? this.xpReward,
      hints: hints ?? this.hints,
      explanation: explanation ?? this.explanation,
      validationRules: validationRules ?? this.validationRules,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stepNumber': stepNumber,
      'type': type.name,
      'question': question,
      'description': description,
      'options': options?.map((o) => o.toJson()).toList(),
      'blankPlaceholder': blankPlaceholder,
      'correctAnswer': correctAnswer,
      'brokenCode': brokenCode,
      'fixedCode': fixedCode,
      'bugHint': bugHint,
      'codeSnippet': codeSnippet,
      'widgetRequirement': widgetRequirement,
      'requiredWidgets': requiredWidgets,
      'expectedOutput': expectedOutput,
      'codePieces': codePieces,
      'correctOrder': correctOrder,
      'xpReward': xpReward,
      'hints': hints,
      'explanation': explanation,
      'validationRules': validationRules,
    };
  }

  factory ChallengeStep.fromJson(Map<String, dynamic> json) {
    return ChallengeStep(
      id: json['id'] as String,
      stepNumber: json['stepNumber'] as int,
      type: ChallengeType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      question: json['question'] as String,
      description: json['description'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((o) => OptionModel.fromJson(Map<String, dynamic>.from(o as Map)))
          .toList(),
      blankPlaceholder: json['blankPlaceholder'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      brokenCode: json['brokenCode'] as String?,
      fixedCode: json['fixedCode'] as String?,
      bugHint: json['bugHint'] as String?,
      codeSnippet: json['codeSnippet'] as String?,
      widgetRequirement: json['widgetRequirement'] as String?,
      requiredWidgets: (json['requiredWidgets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expectedOutput: json['expectedOutput'] as String?,
      codePieces: (json['codePieces'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      correctOrder: (json['correctOrder'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      xpReward: json['xpReward'] as int? ?? 10,
      hints: (json['hints'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      explanation: json['explanation'] as String?,
      validationRules: (json['validationRules'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }
}
