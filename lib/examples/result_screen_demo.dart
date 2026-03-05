import 'package:flutter/material.dart';
import '../widgets/result_screen_widget.dart';

/// Demo showcasing the ResultScreen widget
void main() {
  runApp(const ResultScreenDemo());
}

class ResultScreenDemo extends StatelessWidget {
  const ResultScreenDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result Screen Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ResultDemoHome(),
    );
  }
}

class ResultDemoHome extends StatelessWidget {
  const ResultDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Screen Examples'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Result Screen Scenarios',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'See different result screens based on user performance',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),

          // Correct answer - 3 stars
          _buildScenarioCard(
            context: context,
            title: 'Perfect Answer',
            description: 'Correct on first try - 3 stars, full XP',
            color: Colors.green,
            onTap: () => _showCorrectResult(context),
          ),

          const SizedBox(height: 16),

          // Correct with hints - 2 stars
          _buildScenarioCard(
            context: context,
            title: 'Good Answer',
            description: 'Correct with some hints - 2 stars, reduced XP',
            color: Colors.blue,
            onTap: () => _showCorrectWithHintsResult(context),
          ),

          const SizedBox(height: 16),

          // Incorrect answer
          _buildScenarioCard(
            context: context,
            title: 'Incorrect Answer',
            description: 'Wrong answer - learning opportunity',
            color: Colors.orange,
            onTap: () => _showIncorrectResult(context),
          ),

          const SizedBox(height: 16),

          // Code challenge result
          _buildScenarioCard(
            context: context,
            title: 'Code Challenge',
            description: 'Fix the bug challenge with code display',
            color: Colors.purple,
            onTap: () => _showCodeChallengeResult(context),
          ),

          const SizedBox(height: 16),

          // With common mistakes
          _buildScenarioCard(
            context: context,
            title: 'With Common Mistakes',
            description: 'Shows typical errors students make',
            color: Colors.amber,
            onTap: () => _showWithCommonMistakes(context),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard({
    required BuildContext context,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.play_circle_fill,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  void _showCorrectResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: true,
          explanation:
              'Excellent! The main() function is indeed the entry point of every Flutter application. '
              'When you run your app, Dart looks for the main() function and starts executing code from there. '
              'Without main(), your application won\'t know where to begin!',
          correctAnswer: 'main()',
          xpEarned: 50,
          stars: 3,
          onNextStep: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showCorrectWithHintsResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: true,
          explanation:
              'Good job! You identified that runApp() initializes and displays the root widget of your Flutter app. '
              'This function takes a Widget as an argument and makes it the root of your widget tree. '
              'While you used hints to get here, you still demonstrated understanding of this core concept.',
          correctAnswer: 'runApp()',
          xpEarned: 35,
          stars: 2,
          onNextStep: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showIncorrectResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: false,
          explanation:
              'Not quite! In Flutter, StatefulWidget is used when you need your widget to maintain '
              'state that can change over time. Examples include forms, animations, or any UI that '
              'responds to user interactions. StatelessWidget, on the other hand, is used when the '
              'widget doesn\'t need to keep track of any changing data.',
          correctAnswer: 'StatefulWidget',
          userAnswer: 'StatelessWidget',
          xpEarned: 10,
          stars: 1,
          commonMistakes: [
            'Confusing StatelessWidget with StatefulWidget - they have opposite purposes',
            'Thinking all widgets must be stateless by default',
          ],
          onNextStep: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showCodeChallengeResult(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: true,
          explanation:
              'Perfect! You successfully fixed the bug. The issue was a missing semicolon after the '
              'Text widget. In Dart, every statement must end with a semicolon. This is one of the most '
              'common syntax errors that beginners encounter.',
          correctCode: '''
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Text('Hello Flutter'),
    ),
  );
}''',
          xpEarned: 75,
          stars: 3,
          commonMistakes: [
            'Forgetting semicolons at the end of statements',
            'Mismatching parentheses in nested widget trees',
            'Missing import statements at the top of the file',
          ],
          onNextStep: () => Navigator.pop(context),
        ),
      ),
    );
  }

  void _showWithCommonMistakes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          isCorrect: false,
          explanation:
              'setState() is a special method that tells Flutter to rebuild the widget with new data. '
              'You must call setState() whenever you want to update the UI in a StatefulWidget. '
              'Simply changing a variable\'s value won\'t automatically update the screen - you need '
              'to explicitly tell Flutter "hey, something changed, please redraw!"',
          correctAnswer: 'setState(() { _counter++; })',
          userAnswer: '_counter++',
          xpEarned: 15,
          stars: 1,
          commonMistakes: [
            'Changing state variables without calling setState() - the UI won\'t update',
            'Calling setState() in a StatelessWidget - it doesn\'t exist there',
            'Using setState() during build() - this causes infinite loops',
            'Forgetting to wrap state changes inside setState\'s callback function',
          ],
          onNextStep: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
