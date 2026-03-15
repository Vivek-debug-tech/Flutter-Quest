import '../../models/challenge_models.dart' as challenge_model;
import '../../models/lesson_content_model.dart';
import '../../models/level_model.dart';
import '../../models/world_model.dart';

Level buildCurriculumLevel({
  required String id,
  required String worldId,
  required int levelNumber,
  required String title,
  required String concept,
  required String lessonText,
  required String guidedText,
  required String challengePrompt,
  required String expectedCode,
  required List<String> validationRules,
  List<challenge_model.Challenge>? challenges,
  List<String> keyPoints = const [],
  List<String> hints = const [],
  int baseXP = 60,
  DifficultyLevel difficulty = DifficultyLevel.easy,
}) {
  final resolvedKeyPoints = keyPoints.isEmpty
      ? <String>[
          '$title is a core Flutter concept.',
          'Use the correct widget and property names.',
          'Match the challenge prompt requirements.',
        ]
      : keyPoints;

  final resolvedHints = hints.isEmpty
      ? <String>[
          'Start with the main widget mentioned in the prompt.',
          'Use the syntax shown in the guided example.',
          expectedCode,
        ]
      : hints;

  final resolvedChallenges =
      challenges ??
      <challenge_model.Challenge>[
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: challengePrompt,
          validationRules: validationRules,
          codeSnippet: expectedCode,
        ),
      ];

  return Level(
    id: id,
    worldId: worldId,
    levelNumber: levelNumber,
    title: title,
    concept: concept,
    learningObjective: lessonText,
    challenges: resolvedChallenges,
    difficulty: difficulty,
    baseXP: baseXP,
    explanation:
        '$title teaches $concept. Follow the example structure and include the required validation patterns.',
    commonMistakes: const [
      'Misspelling widget or property names.',
      'Leaving out a required pattern from the prompt.',
      'Using the right widget with the wrong property.',
    ],
    hints: resolvedHints,
    isLocked: false,
    lessonContent: LessonContent(
      title: title,
      description: lessonText,
      codeExample: expectedCode,
      keyPoints: resolvedKeyPoints,
      conceptExplanation: lessonText,
    ),
    guidedExample: GuidedExample(
      title: 'Guided Example: $title',
      introduction: guidedText,
      steps: [
        GuidedStep(
          stepNumber: 1,
          title: 'Review the concept',
          description: lessonText,
          codeSnippet: expectedCode,
          highlights: resolvedKeyPoints.take(3).toList(),
          explanation: lessonText,
        ),
        GuidedStep(
          stepNumber: 2,
          title: 'Apply it in code',
          description: guidedText,
          codeSnippet: expectedCode,
          highlights: validationRules
              .map((rule) => 'Include $rule')
              .take(3)
              .toList(),
          explanation: challengePrompt,
        ),
      ],
      summary: 'You are ready to solve the $title challenge.',
    ),
  );
}

World buildCurriculumWorld({
  required String id,
  required String title,
  required String description,
  required String icon,
  required List<Level> levels,
  int requiredStars = 0,
  bool isLocked = false,
}) {
  return World(
    id: id,
    title: title,
    description: description,
    icon: icon,
    levels: levels,
    requiredStars: requiredStars,
    isLocked: isLocked,
  );
}
