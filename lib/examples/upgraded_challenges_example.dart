import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';

/// Example of upgraded challenge steps showcasing all new features:
/// - New challenge types (arrangeCode)
/// - Hint system
/// - Explanation system
/// - XP rewards
/// - Multiple challenges per level

class UpgradedChallengeExamples {
  /// Example 1: Multiple Choice with Hints and Explanation
  static ChallengeStep multipleChoiceExample() {
    return ChallengeStep(
      id: 'w1_l1_step1',
      stepNumber: 1,
      type: ChallengeType.multipleChoice,
      question: 'What is the purpose of the main() function in Flutter?',
      description: 'Understanding the entry point of Flutter applications',
      options: [
        OptionModel(
          id: 'opt1',
          text: 'It\'s the entry point where the app starts execution',
          isCorrect: true,
          explanation: 'Correct! main() is where your Flutter app begins running.',
        ),
        OptionModel(
          id: 'opt2',
          text: 'It displays widgets on the screen',
          isCorrect: false,
          explanation: 'Not quite. That\'s the job of runApp() and build() methods.',
        ),
        OptionModel(
          id: 'opt3',
          text: 'It handles user input like button clicks',
          isCorrect: false,
          explanation: 'No, main() just starts the app. Event handlers manage input.',
        ),
      ],
      xpReward: 20,
      hints: [
        'Think about what happens first when you launch any app',
        'Every program needs a starting point - this is it!',
        'The word "entry" is a key hint here',
      ],
      explanation: '''
Correct! The main() function is the entry point of every Flutter app.

When you run your app, Dart looks for main() and starts executing from there.
Inside main(), we call runApp() to launch the widget tree.

Example:
void main() {
  runApp(MyApp());
}
''',
    );
  }

  /// Example 2: Fill in the Blank with Hints
  static ChallengeStep fillInBlankExample() {
    return ChallengeStep(
      id: 'w1_l1_step2',
      stepNumber: 2,
      type: ChallengeType.fillInBlank,
      question: 'Complete the code to launch a Flutter app:',
      description: 'Fill in the missing function name',
      blankPlaceholder: '______',
      correctAnswer: 'runApp',
      xpReward: 15,
      hints: [
        'This function "runs" your application',
        'It starts with "run" and ends with "App"',
        'The answer is: runApp',
      ],
      explanation: '''
Perfect! runApp() is the Flutter function that takes your root widget 
and displays it on the screen.

Code:
void main() {
  runApp(MyApp());  // ← This launches your app!
}

runApp() initializes the framework and attaches your widget tree to the screen.
''',
    );
  }

  /// Example 3: Fix the Code (fixTheBug type)
  static ChallengeStep fixCodeExample() {
    return ChallengeStep(
      id: 'w1_l1_step3',
      stepNumber: 3,
      type: ChallengeType.fixTheBug,
      question: 'This code won\'t work. What needs to be fixed?',
      description: 'Find and fix the bug in the code',
      brokenCode: '''
void start() {
  runApp(MyApp());
}
''',
      fixedCode: '''
void main() {
  runApp(MyApp());
}
''',
      bugHint: 'The function name is wrong. Flutter expects a specific name.',
      xpReward: 25,
      hints: [
        'Look at the function name - is it correct?',
        'Flutter apps must start with a function called main()',
        'Change "start" to "main"',
      ],
      explanation: '''
Great job! The bug was the function name.

❌ Wrong: void start()
✅ Correct: void main()

Flutter (and Dart) require the entry point to be named "main".
Using any other name like "start", "begin", or "launch" won't work.
''',
    );
  }

  /// Example 4: **NEW** Arrange Code Challenge
  static ChallengeStep arrangeCodeExample() {
    return ChallengeStep(
      id: 'w1_l1_step4',
      stepNumber: 4,
      type: ChallengeType.arrangeCode,
      question: 'Arrange these code pieces in the correct order:',
      description: 'Put the code lines in the right sequence',
      codePieces: [
        'runApp(MyApp());',
        'void main() {',
        '}',
      ],
      correctOrder: [
        'void main() {',
        '  runApp(MyApp());',
        '}',
      ],
      xpReward: 30,
      hints: [
        'What comes first - the function declaration or the function body?',
        'The function starts with "void main() {"',
        'Order: function declaration → function body → closing brace',
      ],
      explanation: '''
Excellent! You've arranged the code correctly.

The correct structure is:
1. Function declaration: void main() {
2. Function body: runApp(MyApp());
3. Closing brace: }

This is the basic structure of every Flutter app's entry point.
''',
    );
  }

  /// Example 5: Complete Level with Multiple Challenge Steps
  static LevelModel upgradedLevel() {
    return LevelModel(
      id: 'w1_l1_upgraded',
      worldId: 'world_1',
      levelNumber: 1,
      title: 'Flutter App Structure',
      concept: 'main() and runApp()',
      lessonText: '''
🎯 Welcome to Flutter!

Every Flutter app follows the same basic structure:

1. **main() function** - The entry point where your app starts
2. **runApp()** - Launches your widget tree
3. **MyApp widget** - Your app's root widget

Let's break it down:

void main() {          // ← App starts here
  runApp(MyApp());     // ← Widget tree launches
}

Think of it like starting a car:
🔑 main() = Turning the key
🚗 runApp() = Engine starting
🛣️ MyApp = Your journey begins
''',
      codeExample: '''
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First App',
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Flutter')),
        body: Center(child: Text('Welcome!')),
      ),
    );
  }
}
''',
      learningObjective: 'Understand Flutter app structure and entry points',
      analogy: '''
Building a Flutter app is like building a house:

🏗️ main() = Laying the foundation
🏠 runApp() = Raising the walls
🎨 Widgets = Interior decoration
''',
      keyTakeaways: [
        'Every Flutter app must have a main() function',
        'runApp() launches your widget tree',
        'main() is called automatically when app starts',
        'You can\'t rename main() to something else',
      ],
      challengeSteps: [
        multipleChoiceExample(),
        fillInBlankExample(),
        fixCodeExample(),
        arrangeCodeExample(),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 100,
      bonusXP: 30,
      explanation: '''
🎉 Congratulations! You've mastered Flutter app structure!

You now know:
✅ How Flutter apps start (main function)
✅ How to launch widgets (runApp)
✅ The correct code structure
✅ How to fix common mistakes

Next, you'll learn about StatelessWidget and building UI!
''',
      commonMistakes: [
        'Forgetting to call runApp() inside main()',
        'Trying to rename main() to something else',
        'Not understanding that main() is the entry point',
      ],
      isLocked: false,
      timeEstimate: Duration(minutes: 15),
    );
  }
}

/// Star Calculation Helper
/// (Already implemented in XPCalculator, but including reference here)
class StarSystemReference {
  /// Calculate stars based on performance
  static int calculateStars({
    required int mistakes,
    required int hintsUsed,
  }) {
    // ⭐⭐⭐ 3 stars: Perfect (0 mistakes, no hints)
    if (mistakes == 0 && hintsUsed == 0) {
      return 3;
    }

    // ⭐⭐ 2 stars: Good (1-2 mistakes OR 1-2 hints)
    if (mistakes <= 2 && hintsUsed <= 2) {
      return 2;
    }

    // ⭐ 1 star: Completed (any number of mistakes/hints)
    return 1;
  }

  /// Get performance message
  static String getMessage(int stars) {
    switch (stars) {
      case 3:
        return "🌟 Perfect! You're a Flutter master!";
      case 2:
        return "⭐ Great job! Keep learning!";
      case 1:
        return "✨ Good effort! Practice makes perfect!";
      default:
        return "Keep trying!";
    }
  }
}

/// Usage Example:
/// 
/// ```dart
/// // In your challenge screen
/// class ChallengeScreen extends StatefulWidget {
///   final LevelModel level;
///   
///   @override
///   _ChallengeScreenState createState() => _ChallengeScreenState();
/// }
/// 
/// class _ChallengeScreenState extends State<ChallengeScreen> {
///   int _hintsUsed = 0;
///   int _mistakes = 0;
///   
///   void _showHint() {
///     setState(() {
///       _hintsUsed++;
///     });
///     // Show hint dialog
///   }
///   
///   void _checkAnswer(String answer) {
///     if (answer != correctAnswer) {
///       setState(() {
///         _mistakes++;
///       });
///     }
///   }
///   
///   void _completeLevel() {
///     final stars = XPCalculator.calculateStars(
///       mistakes: _mistakes,
///       hintsUsed: _hintsUsed,
///     );
///     
///     final xp = XPCalculator.calculateXP(
///       baseXP: widget.level.baseXP,
///       mistakes: _mistakes,
///       hintsUsed: _hintsUsed,
///     );
///     
///     // Save progress
///     HiveProgressService.markLevelCompleted(
///       levelId: widget.level.id,
///       stars: stars,
///       xpEarned: xp,
///       mistakes: _mistakes,
///       hintsUsed: _hintsUsed,
///     );
///   }
/// }
/// ```
