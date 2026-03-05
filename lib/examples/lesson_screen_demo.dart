import 'package:flutter/material.dart';
import '../widgets/lesson_screen_widget.dart';
import '../models/level_model_v2.dart';
import '../data/sample_level_data.dart';

/// Demo app showcasing the LessonScreen widget
void main() {
  runApp(const LessonScreenDemo());
}

class LessonScreenDemo extends StatelessWidget {
  const LessonScreenDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lesson Screen Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LessonDemoHome(),
    );
  }
}

class LessonDemoHome extends StatelessWidget {
  const LessonDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Screen Demo'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Available Lessons',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          // Sample Level from data
          _buildLessonCard(
            context: context,
            level: SampleLevelData.getWorld1Level1(),
            description: 'Learn the basics of Flutter app structure',
          ),

          const SizedBox(height: 16),

          // Custom example lesson
          _buildLessonCard(
            context: context,
            level: _createCustomLesson(),
            description: 'Learn about StatefulWidgets and setState',
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard({
    required BuildContext context,
    required LevelModel level,
    required String description,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LessonScreen(level: level),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.shade600,
                          Colors.purple.shade600,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 24,
                    ),
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
                          level.concept,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(
                    icon: Icons.quiz,
                    label: '${level.challengeSteps.length} Challenges',
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _buildInfoChip(
                    icon: Icons.stars,
                    label: '${level.totalPossibleXP} XP',
                    color: Colors.amber,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  LevelModel _createCustomLesson() {
    return LevelModel(
      id: 'custom-1',
      worldId: 'world-1',
      levelNumber: 2,
      title: 'StatefulWidget & setState',
      concept: 'State Management',
      learningObjective:
          'Understand how to create interactive widgets that can change over time using StatefulWidget and setState().',
      lessonText:
          'In Flutter, most widgets are stateless - they never change once built. But sometimes you need widgets that can update themselves when things change, like a counter that increases when you tap a button.\n\n'
          'That\'s where StatefulWidget comes in! A StatefulWidget is paired with a State class that holds mutable data (called "state"). When that state changes, you call setState() to tell Flutter to rebuild the widget with the new data.',
      analogy:
          'Think of a StatefulWidget like a scoreboard at a sports game. The scoreboard itself doesn\'t change, but the numbers on it do. The State class is like the person operating the scoreboard - they update the numbers when teams score, and everyone watching sees the new score.',
      codeExample: '''
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \$_counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: Text('Increment'),
        ),
      ],
    );
  }
}''',
      challengeSteps: [], // Empty for this demo
      baseXP: 100,
      bonusXP: 50,
      explanation:
          'StatefulWidget allows you to create interactive UI elements that respond to user actions and update dynamically. This is essential for building engaging Flutter apps!',
      isLocked: false,
      keyTakeaways: [
        'StatefulWidget creates widgets that can change over time',
        'The State class holds your mutable data',
        'Call setState() whenever you want to update the UI',
        'Flutter automatically rebuilds the widget when setState() is called',
      ],
    );
  }
}
