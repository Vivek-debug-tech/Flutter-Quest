import '../models/lesson.dart';
import '../models/level_model.dart';
import '../models/lesson_content_model.dart';

/// Converts a simple Lesson to a complete Level object
/// This allows easy integration with the existing UI screens
class LessonConverter {
  /// Convert a Lesson to Level format
  static Level lessonToLevel(Lesson lesson, String worldId) {
    return Level(
      id: 'w${worldId}_l${lesson.id}',
      worldId: worldId,
      levelNumber: lesson.id,
      title: lesson.title,
      concept: lesson.subtitle,
      learningObjective: lesson.subtitle,
      challengeType: ChallengeType.buildFromScratch,
      difficulty: _getDifficultyLevel(lesson.difficulty),
      challengeDescription: lesson.challengeQuestion,
      expectedCode: lesson.correctCode,
      validationRules: [
        'Must match expected code structure',
      ],
      baseXP: lesson.xp,
      explanation: lesson.conceptExplanation,
      hints: lesson.hints,
      lessonContent: _createLessonContent(lesson),
      guidedExample: _createGuidedExample(lesson),
    );
  }

  /// Convert a list of Lessons to Levels
  static List<Level> lessonsToLevels(List<Lesson> lessons, String worldId) {
    return lessons.map((lesson) => lessonToLevel(lesson, worldId)).toList();
  }

  /// Create LessonContent from Lesson
  static LessonContent _createLessonContent(Lesson lesson) {
    return LessonContent(
      title: lesson.title,
      description: lesson.subtitle,
      conceptExplanation: lesson.conceptExplanation,
      codeExample: lesson.exampleCode,
      keyPoints: lesson.keyPoints,
      analogy: '',
    );
  }

  /// Create GuidedExample from Lesson
  static GuidedExample _createGuidedExample(Lesson lesson) {
    return GuidedExample(
      title: 'Building ${lesson.title}',
      introduction: 'Let\'s walk through ${lesson.title.toLowerCase()} step by step.',
      summary: 'Great job! You\'ve learned ${lesson.title.toLowerCase()}. This is an important concept in Flutter development.',
      steps: lesson.guidedSteps.map((stepData) {
        return GuidedStep(
          stepNumber: stepData.stepNumber,
          title: stepData.title,
          description: stepData.explanation,
          codeSnippet: stepData.code,
          highlights: [],
          explanation: stepData.explanation,
        );
      }).toList(),
    );
  }

  /// Convert difficulty string to DifficultyLevel enum
  static DifficultyLevel _getDifficultyLevel(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return DifficultyLevel.easy;
      case 'medium':
        return DifficultyLevel.medium;
      case 'hard':
        return DifficultyLevel.hard;
      default:
        return DifficultyLevel.easy;
    }
  }
}

/// Example usage:
/// 
/// ```dart
/// import 'package:your_app/data/lesson_data.dart';
/// import 'package:your_app/utils/lesson_converter.dart';
/// 
/// // Convert all lessons to levels
/// final levels = LessonConverter.lessonsToLevels(flutterBasicsLessons, '1');
/// 
/// // Or convert a single lesson
/// final lesson = flutterBasicsLessons[0];
/// final level = LessonConverter.lessonToLevel(lesson, '1');
/// ```
