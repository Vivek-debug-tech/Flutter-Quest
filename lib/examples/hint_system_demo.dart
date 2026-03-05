import 'package:flutter/material.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../screens/challenge_engine_screen.dart';

/// Demo showcasing the hint system in action
/// This demonstrates:
/// - Multiple hints per challenge
/// - Progressive hint difficulty (stronger after 2 hints)
/// - XP penalty tracking (-5 XP per hint)
/// - Hint display UI
void main() {
  runApp(const HintSystemDemoApp());
}

class HintSystemDemoApp extends StatelessWidget {
  const HintSystemDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hint System Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HintSystemDemoHome(),
    );
  }
}

class HintSystemDemoHome extends StatelessWidget {
  const HintSystemDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hint System Demo'),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildInfoCard(),
          const SizedBox(height: 20),
          _buildDemoCard(
            context: context,
            title: 'MCQ with Progressive Hints',
            description: '4 hints: gentle → stronger → very strong',
            icon: Icons.quiz,
            color: Colors.blue,
            onTap: () => _launchMCQDemo(context),
          ),
          const SizedBox(height: 12),
          _buildDemoCard(
            context: context,
            title: 'Fill in the Blank with Hints',
            description: '3 hints guiding to the answer',
            icon: Icons.edit,
            color: Colors.green,
            onTap: () => _launchFillBlankDemo(context),
          ),
          const SizedBox(height: 12),
          _buildDemoCard(
            context: context,
            title: 'Fix the Bug with Hints',
            description: '5 hints showing bug location',
            icon: Icons.bug_report,
            color: Colors.orange,
            onTap: () => _launchFixBugDemo(context),
          ),
          const SizedBox(height: 12),
          _buildDemoCard(
            context: context,
            title: 'Build Widget with Hints',
            description: '3 hints for widget structure',
            icon: Icons.widgets,
            color: Colors.purple,
            onTap: () => _launchBuildWidgetDemo(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.amber.shade100, Colors.orange.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade300, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Hint System Features',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildFeatureRow(Icons.check, 'Multiple hints per challenge'),
          _buildFeatureRow(Icons.trending_up, 'Progressive difficulty (stronger after 2 hints)'),
          _buildFeatureRow(Icons.remove_circle, '-5 XP penalty per hint'),
          _buildFeatureRow(Icons.visibility, 'All hints remain visible'),
          _buildFeatureRow(Icons.lock, 'Hints unlock one at a time'),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.amber.shade700),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 18),
          ],
        ),
      ),
    );
  }

  void _launchMCQDemo(BuildContext context) {
    final level = LevelModel(
      id: 'hint_demo_mcq',
      worldId: 'world1',
      levelNumber: 1,
      title: 'MCQ with Progressive Hints',
      concept: 'Multiple Choice Questions',
      lessonText: 'This demo shows how hints work with multiple choice questions.',
      learningObjective: 'Learn to use progressive hints in MCQ challenges',
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 20,
      explanation: 'Multiple choice with 4 progressive hints',
      isLocked: false,
      challengeSteps: [
        const ChallengeStep(
          id: 'mcq_hint_demo',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What is the main function in Flutter used to run the app?',
          description: 'This is the entry point of every Flutter application.',
          options: [
            OptionModel(id: '1', text: 'main()', isCorrect: false),
            OptionModel(id: '2', text: 'runApp()', isCorrect: true),
            OptionModel(id: '3', text: 'startApp()', isCorrect: false),
            OptionModel(id: '4', text: 'initApp()', isCorrect: false),
          ],
          xpReward: 15,
          hints: [
            'Think about what function you call inside main() to start the app.',
            'The function name suggests "running" the application.',
            'After 2 hints, here\'s stronger guidance: It\'s a Flutter-specific function that takes a Widget as a parameter.',
            'STRONGEST HINT: The answer contains the word "run" and "App".',
          ],
          explanation: 'runApp() is the function that inflates the given Widget and attaches it to the screen.',
        ),
      ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeEngineScreen(level: level),
      ),
    );
  }

  void _launchFillBlankDemo(BuildContext context) {
    final level = LevelModel(
      id: 'hint_demo_fill',
      worldId: 'world1',
      levelNumber: 2,
      title: 'Fill in the Blank with Hints',
      concept: 'Fill in the Blank',
      lessonText: 'This demo shows how hints work with fill-in-the-blank challenges.',
      learningObjective: 'Learn to use hints for completing code snippets',
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 20,
      explanation: 'Complete the code with helpful hints',
      isLocked: false,
      challengeSteps: [
        const ChallengeStep(
          id: 'fill_hint_demo',
          stepNumber: 1,
          type: ChallengeType.fillInBlank,
          question: 'Flutter uses ____ programming language.',
          description: 'Fill in the programming language used by Flutter.',
          blankPlaceholder: '____',
          correctAnswer: 'Dart',
          xpReward: 15,
          hints: [
            'It\'s a language developed by Google.',
            'The language name starts with the letter "D".',
            'STRONGER HINT: It\'s a 4-letter word that rhymes with "start".',
          ],
          explanation: 'Flutter uses Dart, a modern language optimized for UI development.',
        ),
      ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeEngineScreen(level: level),
      ),
    );
  }

  void _launchFixBugDemo(BuildContext context) {
    final level = LevelModel(
      id: 'hint_demo_fix',
      worldId: 'world1',
      levelNumber: 3,
      title: 'Fix the Bug with Hints',
      concept: 'Debugging',
      lessonText: 'This demo shows how hints work when fixing bugs in code.',
      learningObjective: 'Learn to use progressive hints for debugging',
      difficulty: DifficultyLevel.intermediate,
      baseXP: 75,
      bonusXP: 25,
      explanation: 'Find and fix the bug with progressive hints',
      isLocked: false,
      challengeSteps: [
        const ChallengeStep(
          id: 'fix_hint_demo',
          stepNumber: 1,
          type: ChallengeType.fixTheBug,
          question: 'Fix the syntax error in this Flutter widget',
          description: 'There\'s a missing piece in this StatelessWidget.',
          brokenCode: '''class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hello");
  }
''',
          fixedCode: '''class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Hello");
  }
}''',
          xpReward: 20,
          hints: [
            'Look at the structure of the class definition.',
            'Every opening character needs a closing one.',
            'STRONGER HINT: Count the curly braces { and }.',
            'The class definition is not properly closed.',
            'STRONGEST HINT: Add a closing curly brace } at the end.',
          ],
          explanation: 'Every class definition needs matching curly braces to close the class body.',
          validationRules: ['}'],
        ),
      ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeEngineScreen(level: level),
      ),
    );
  }

  void _launchBuildWidgetDemo(BuildContext context) {
    final level = LevelModel(
      id: 'hint_demo_build',
      worldId: 'world1',
      levelNumber: 4,
      title: 'Build Widget with Hints',
      concept: 'Widget Building',
      lessonText: 'This demo shows how hints work when building widgets from scratch.',
      learningObjective: 'Learn to use hints for widget construction',
      difficulty: DifficultyLevel.intermediate,
      baseXP: 75,
      bonusXP: 25,
      explanation: 'Create a widget with helpful hints',
      isLocked: false,
      challengeSteps: [
        const ChallengeStep(
          id: 'build_hint_demo',
          stepNumber: 1,
          type: ChallengeType.buildWidget,
          question: 'Build a Column widget with two Text children',
          description: 'Create a simple vertical layout.',
          widgetRequirement: 'Create a Column widget containing two Text widgets',
          requiredWidgets: ['Column', 'Text'],
          xpReward: 20,
          hints: [
            'Start with a Column widget, which arranges children vertically.',
            'Column has a children property that takes a list of widgets.',
            'STRONGER HINT: Use two Text widgets inside the children list.',
          ],
          explanation: 'Column is a layout widget that displays children vertically. It takes a children parameter which is a List<Widget>.',
        ),
      ],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChallengeEngineScreen(level: level),
      ),
    );
  }
}
