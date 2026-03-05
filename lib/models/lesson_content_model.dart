/// Represents the lesson/concept explanation phase of learning
class LessonContent {
  final String title;
  final String description;
  final String codeExample;
  final List<String> keyPoints;
  final String conceptExplanation;
  final String analogy;

  LessonContent({
    required this.title,
    required this.description,
    required this.codeExample,
    required this.keyPoints,
    required this.conceptExplanation,
    this.analogy = '',
  });

  LessonContent copyWith({
    String? title,
    String? description,
    String? codeExample,
    List<String>? keyPoints,
    String? conceptExplanation,
    String? analogy,
  }) {
    return LessonContent(
      title: title ?? this.title,
      description: description ?? this.description,
      codeExample: codeExample ?? this.codeExample,
      keyPoints: keyPoints ?? this.keyPoints,
      conceptExplanation: conceptExplanation ?? this.conceptExplanation,
      analogy: analogy ?? this.analogy,
    );
  }
}

/// Represents a single step in the guided example
class GuidedStep {
  final int stepNumber;
  final String title;
  final String description;
  final String codeSnippet;
  final List<String> highlights;
  final String explanation;

  GuidedStep({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.codeSnippet,
    required this.highlights,
    required this.explanation,
  });

  GuidedStep copyWith({
    int? stepNumber,
    String? title,
    String? description,
    String? codeSnippet,
    List<String>? highlights,
    String? explanation,
  }) {
    return GuidedStep(
      stepNumber: stepNumber ?? this.stepNumber,
      title: title ?? this.title,
      description: description ?? this.description,
      codeSnippet: codeSnippet ?? this.codeSnippet,
      highlights: highlights ?? this.highlights,
      explanation: explanation ?? this.explanation,
    );
  }
}

/// Container for all guided example steps
class GuidedExample {
  final String title;
  final String introduction;
  final List<GuidedStep> steps;
  final String summary;

  GuidedExample({
    required this.title,
    required this.introduction,
    required this.steps,
    required this.summary,
  });

  GuidedExample copyWith({
    String? title,
    String? introduction,
    List<GuidedStep>? steps,
    String? summary,
  }) {
    return GuidedExample(
      title: title ?? this.title,
      introduction: introduction ?? this.introduction,
      steps: steps ?? this.steps,
      summary: summary ?? this.summary,
    );
  }
}
