import 'package:flutter/material.dart';
import '../widgets/result_screen_widget.dart';
import '../models/challenge_models.dart';
import '../engine/challenge_engine.dart';

/// Integration Guide: How to use ResultScreen with ChallengeEngine
///
/// This file demonstrates best practices for showing the ResultScreen
/// after a user answers a challenge question.

class ResultScreenIntegration {
  /// Shows a result screen based on the current challenge and user's answer
  /// 
  /// Example usage in your challenge UI:
  /// ```dart
  /// ResultScreenIntegration.showResultForChallenge(
  ///   context: context,
  ///   engine: challengeEngine,
  ///   currentStep: currentChallengeStep,
  ///   userAnswer: userInputAnswer,
  ///   isCorrect: validationResult,
  ///   commonMistakes: level.commonMistakes, // Optional: level-specific mistakes
  ///   onNextStep: () {
  ///     // Move to next challenge or complete level
  ///     engine.nextStep();
  ///     Navigator.pop(context);
  ///   },
  /// );
  /// ```
  static void showResultForChallenge({
    required BuildContext context,
    required ChallengeEngine engine,
    required ChallengeStep currentStep,
    required String userAnswer,
    required bool isCorrect,
    List<String> commonMistakes = const [],
    required VoidCallback onNextStep,
  }) {
    // Calculate XP based on performance
    final stats = engine.getStats();
    final stepXP = isCorrect ? currentStep.xpReward : (currentStep.xpReward * 0.2).round();
    
    // Calculate stars based on mistakes
    final mistakes = stats.mistakesCount;
    final hintsUsed = engine.getHintsUsedForCurrentStep();
    int stars = 3;
    if (mistakes > 0 || hintsUsed > 0) stars = 2;
    if (mistakes > 2 || hintsUsed > 2) stars = 1;
    
    // Determine what to show based on challenge type
    String? correctCode;
    String? correctAnswer;
    
    switch (currentStep.type) {
      case ChallengeType.fixTheBug:
      case ChallengeType.buildWidget:
      case ChallengeType.interactiveCode:
        correctCode = currentStep.fixedCode;
        break;
      case ChallengeType.fillInBlank:
        correctAnswer = currentStep.correctAnswer;
        break;
      case ChallengeType.arrangeCode:
        correctAnswer = currentStep.correctOrder?.join('\n');
        break;
      case ChallengeType.multipleChoice:
        // Find the correct option
        try {
          final correctOption = currentStep.options?.firstWhere(
            (opt) => opt.isCorrect,
          );
          correctAnswer = correctOption?.text;
        } catch (e) {
          // No correct option found
          correctAnswer = null;
        }
        break;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: isCorrect,
          explanation: currentStep.explanation ?? 'Great job on completing this challenge!',
          correctAnswer: correctAnswer,
          correctCode: correctCode,
          commonMistakes: commonMistakes,
          xpEarned: stepXP,
          stars: stars,
          userAnswer: isCorrect ? null : userAnswer,
          onNextStep: () {
            Navigator.pop(context);
            onNextStep();
          },
        ),
      ),
    );
  }

  /// Quick helper for correct answers
  static void showCorrectResult({
    required BuildContext context,
    required ChallengeStep step,
    required int xpEarned,
    int stars = 3,
    List<String> commonMistakes = const [],
    required VoidCallback onNextStep,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: true,
          explanation: step.explanation ?? 'Excellent work on this challenge!',
          correctAnswer: _getCorrectAnswer(step),
          correctCode: step.fixedCode,
          commonMistakes: commonMistakes,
          xpEarned: xpEarned,
          stars: stars,
          onNextStep: () {
            Navigator.pop(context);
            onNextStep();
          },
        ),
      ),
    );
  }

  /// Quick helper for incorrect answers
  static void showIncorrectResult({
    required BuildContext context,
    required ChallengeStep step,
    required String userAnswer,
    List<String> commonMistakes = const [],
    required VoidCallback onNextStep,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: false,
          explanation: step.explanation ?? 'Let\'s review this concept and try again!',
          correctAnswer: _getCorrectAnswer(step),
          correctCode: step.fixedCode,
          commonMistakes: commonMistakes,
          xpEarned: (step.xpReward * 0.2).round(),
          stars: 1,
          userAnswer: userAnswer,
          onNextStep: () {
            Navigator.pop(context);
            onNextStep();
          },
        ),
      ),
    );
  }

  /// Helper to extract the correct answer from different challenge types
  static String? _getCorrectAnswer(ChallengeStep step) {
    switch (step.type) {
      case ChallengeType.fillInBlank:
        return step.correctAnswer;
      case ChallengeType.multipleChoice:
        try {
          final correctOption = step.options?.firstWhere(
            (opt) => opt.isCorrect,
          );
          return correctOption?.text;
        } catch (e) {
          // No correct option found - return null gracefully
          return null;
        }
      case ChallengeType.arrangeCode:
        return step.correctOrder?.join('\n');
      case ChallengeType.fixTheBug:
      case ChallengeType.buildWidget:
      case ChallengeType.interactiveCode:
        return null; // Code is shown instead
    }
  }
}

/// Example: Full flow from challenge to result screen
class ChallengeWithResultExample extends StatefulWidget {
  final ChallengeStep challenge;
  final ChallengeEngine engine;

  const ChallengeWithResultExample({
    Key? key,
    required this.challenge,
    required this.engine,
  }) : super(key: key);

  @override
  State<ChallengeWithResultExample> createState() =>
      _ChallengeWithResultExampleState();
}

class _ChallengeWithResultExampleState
    extends State<ChallengeWithResultExample> {
  String userAnswer = '';

  void _submitAnswer() {
    // Validate answer using challenge engine
    final result = widget.engine.validateAnswer(userAnswer);

    // Show result screen
    ResultScreenIntegration.showResultForChallenge(
      context: context,
      engine: widget.engine,
      currentStep: widget.challenge,
      userAnswer: userAnswer,
      isCorrect: result.isCorrect,
      commonMistakes: widget.engine.level.commonMistakes, // Pass level mistakes
      onNextStep: () {
        // Handle next step
        if (widget.engine.canGoToNextStep()) {
          widget.engine.nextStep();
          setState(() {
            userAnswer = ''; // Reset for next challenge
          });
        } else {
          // Level complete - show summary or navigate away
          _showLevelComplete();
        }
      },
    );
  }

  void _showLevelComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Level Complete!'),
        content: const Text('You\'ve finished all challenges in this level.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Your challenge UI here
    return Scaffold(
      appBar: AppBar(title: const Text('Challenge')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.challenge.question),
            TextField(
              onChanged: (value) => setState(() => userAnswer = value),
              decoration: const InputDecoration(
                labelText: 'Your Answer',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Best Practices for ResultScreen Integration:
///
/// 1. **Always provide explanation** - Help users understand why an answer is correct/incorrect
/// 
/// 2. **Calculate XP fairly** - Correct = full XP, incorrect = partial XP (20%)
/// 
/// 3. **Stars based on performance**:
///    - 3 stars: Perfect (no mistakes, no hints)
///    - 2 stars: Good (1-2 mistakes or hints)
///    - 1 star: Completed (3+ mistakes/hints or incorrect)
/// 
/// 4. **Show correct code for coding challenges** - Visual reference helps learning
/// 
/// 5. **Display common mistakes** - Prevents future errors
/// 
/// 6. **Keep user's wrong answer** - Shows what they tried (learning opportunity)
/// 
/// 7. **Use Modal navigation** - Push ResultScreen so user can review before continuing
/// 
/// 8. **Clear onNextStep action** - Always define what happens after viewing results
///
/// 9. **Responsive design** - ResultScreen scrolls for long content
///
/// 10. **Professional tone** - Encouraging but not childish language
