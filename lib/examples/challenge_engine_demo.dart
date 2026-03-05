import 'package:flutter/material.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../data/sample_level_data.dart';
import '../screens/challenge_engine_screen.dart';

/// Demo app showing the Challenge Engine in action
/// Run this to test the challenge system
class ChallengeEngineDemo extends StatelessWidget {
  const ChallengeEngineDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge Engine Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Engine Demo'),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Test the Challenge Engine',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different challenge types with dynamic XP calculation',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 32),

            // Sample Level Card
            _buildLevelCard(
              context,
              level: SampleLevelData.getWorld1Level1(),
              icon: Icons.rocket_launch,
              color: Colors.blue,
            ),
            
            const SizedBox(height: 16),
            
            // Custom demo level
            _buildLevelCard(
              context,
              level: _createMixedChallengeLevel(),
              icon: Icons.psychology,
              color: Colors.purple,
            ),

            const Spacer(),

            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.indigo.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.indigo.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Challenge Engine Features',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildFeature('✅ Multiple challenge types per level'),
                  _buildFeature('✅ Progress tracking (Step X of Y)'),
                  _buildFeature('✅ Mistakes counter'),
                  _buildFeature('✅ Hint system with penalty'),
                  _buildFeature('✅ Dynamic XP calculation'),
                  _buildFeature('✅ Clean logic/UI separation'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context, {
    required LevelModel level,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChallengeEngineScreen(level: level),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      level.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${level.challengeSteps.length} challenges • ${level.totalPossibleXP} XP',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      level.concept,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }

  // Create a mixed challenge level for testing
  LevelModel _createMixedChallengeLevel() {
    return LevelModel(
      id: 'demo_mixed',
      worldId: 'demo',
      levelNumber: 2,
      title: 'Mixed Challenge Demo',
      concept: 'All Challenge Types',
      lessonText: '''
This demo level showcases all challenge types:
• Multiple Choice Questions
• Fill in the Blank
• Fix the Bug
• Build Widget

Test the engine's capabilities!
''',
      learningObjective: 'Experience all challenge types in one level',
      challengeSteps: [
        ChallengeStep(
          id: 'demo_c1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What does setState() do in Flutter?',
          description: 'Test your understanding of state management.',
          options: [
            OptionModel(
              id: 'a',
              text: 'Rebuilds the widget when state changes',
              isCorrect: true,
              explanation: 'Correct! setState() triggers a rebuild.',
            ),
            OptionModel(
              id: 'b',
              text: 'Saves data to a database',
              isCorrect: false,
              explanation: 'No, setState() only rebuilds UI.',
            ),
            OptionModel(
              id: 'c',
              text: 'Creates a new widget',
              isCorrect: false,
              explanation: 'setState() rebuilds existing widgets.',
            ),
          ],
          xpReward: 15,
          hints: ['Think about what happens when data changes'],
        ),
        ChallengeStep(
          id: 'demo_c2',
          stepNumber: 2,
          type: ChallengeType.fillInBlank,
          question: 'Complete: class MyWidget extends _____Widget { }',
          blankPlaceholder: '_____',
          correctAnswer: 'Stateless',
          xpReward: 10,
          hints: ['This type of widget doesn\'t change'],
        ),
        ChallengeStep(
          id: 'demo_c3',
          stepNumber: 3,
          type: ChallengeType.fixTheBug,
          question: 'Fix the broken Text widget',
          brokenCode: '''Widget build(BuildContext context) {
  return Text(
    'Hello World'
    style: TextStyle(fontSize: 20),
  );
}''',
          fixedCode: '''Widget build(BuildContext context) {
  return Text(
    'Hello World',
    style: TextStyle(fontSize: 20),
  );
}''',
          bugHint: 'Missing a comma after the text!',
          xpReward: 20,
          hints: [
            'Check the syntax carefully',
            'Text() needs a comma between parameters',
          ],
          validationRules: ['Hello World,'],
        ),
      ],
      baseXP: 30,
      bonusXP: 20,
      explanation: 'Great job mastering all challenge types!',
      isLocked: false,
    );
  }
}

// ============================================
// HOW TO RUN THIS DEMO
// ============================================

void main() {
  runApp(const ChallengeEngineDemo());
}

/// To test in your main.dart:
/// 
/// Import this file:
/// import 'examples/challenge_engine_demo.dart';
/// 
/// Then in main():
/// void main() {
///   runApp(const ChallengeEngineDemo());
/// }
/// 
/// Or navigate to it from your existing app:
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => ChallengeEngineScreen(
///       level: SampleLevelData.getWorld1Level1(),
///     ),
///   ),
/// );
