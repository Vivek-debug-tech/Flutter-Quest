import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';

/// Repository for Level data
/// Contains all level definitions organized by world
/// Scales to 100+ levels with clean organization
class LevelsRepository {
  /// Load all levels in the game
  List<LevelModel> loadLevels() {
    return [
      // World 1: Flutter Basics
      ..._world1Levels(),
      // World 2: Widgets (add more as needed)
      ..._world2Levels(),
      // World 3: State Management (add more as needed)
      ..._world3Levels(),
      // Add more worlds here
    ];
  }

  // ============================================
  // WORLD 1: FLUTTER BASICS
  // ============================================

  List<LevelModel> _world1Levels() {
    return [
      _w1_l1_helloFlutter(),
      _w1_l2_statelessWidget(),
      _w1_l3_statefulWidget(),
      _w1_l4_widgetTree(),
      _w1_l5_hotReload(),
    ];
  }

  /// World 1, Level 1: Hello Flutter
  LevelModel _w1_l1_helloFlutter() {
    return LevelModel(
      id: 'w1_l1',
      worldId: 'world_1',
      levelNumber: 1,
      title: 'Hello Flutter',
      concept: 'main() and runApp()',
      lessonText: '''
Welcome to Flutter! Every Flutter app starts with two essential components: the main() function and runApp().

**The main() Function:**
This is the entry point of your app - where everything begins. Just like a story needs a first page, your app needs a starting point. That's main().

**The runApp() Function:**
This Flutter function takes your app's root widget and displays it on the screen. It initializes all the Flutter magic behind the scenes.

**How They Work Together:**
1. Your app starts by running main()
2. Inside main(), you call runApp()
3. runApp() takes a widget and makes it your app
4. Your app appears on the screen!
''',
      codeExample: '''void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hello Flutter')),
        body: Center(child: Text('My First App!')),
      ),
    );
  }
}''',
      learningObjective: 'Understand how Flutter apps start and the role of main() and runApp()',
      analogy: '''
Think of building a Flutter app like starting a car:

🔑 main() = Turning the key in the ignition
🚗 runApp() = The engine starting and the car coming to life
🛣️ Your Widget = The road you'll drive on

Without turning the key (main), the engine can't start (runApp), and you can't go anywhere (no app)!
''',
      keyTakeaways: [
        'Every Flutter app must have a main() function',
        'runApp() is called inside main() to launch your app',
        'runApp() takes a widget as parameter - your app\'s root',
        'StatelessWidget is used for UI that doesn\'t change',
        'MaterialApp provides Material Design styling for your app',
      ],
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l1_c1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What is the purpose of the main() function in Flutter?',
          description: 'Let\'s test your understanding of the main() function.',
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
              explanation: 'Not quite. That\'s the job of runApp() and the build() method.',
            ),
            OptionModel(
              id: 'opt3',
              text: 'It handles user input like button clicks',
              isCorrect: false,
              explanation: 'No, main() just starts the app. Event handlers manage user input.',
            ),
          ],
          xpReward: 15,
          hints: [
            'Think about what happens first when you launch any app',
            'Every program needs a starting point',
            'The word "entry" is a key hint here',
          ],
          explanation: 'main() is the entry point - the first function that runs when your app starts.',
        ),
        ChallengeStep(
          id: 'w1_l1_c2',
          stepNumber: 2,
          type: ChallengeType.fillInBlank,
          question: 'Complete the code: void main() { _____(MyApp()); }',
          description: 'Fill in the function that launches the app.',
          correctAnswer: 'runApp',
          xpReward: 15,
          hints: [
            'This function "runs" your application',
            'It starts with "run"',
            'runApp is the answer!',
          ],
          explanation: 'runApp() is the Flutter function that takes your root widget and displays it.',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 20,
      explanation: 'Great job! You now understand how Flutter apps start with main() and runApp().',
      commonMistakes: [
        'Forgetting to call runApp() inside main()',
        'Not wrapping your app in MaterialApp',
      ],
      isLocked: false,
      timeEstimate: Duration(minutes: 10),
    );
  }

  /// World 1, Level 2: StatelessWidget
  LevelModel _w1_l2_statelessWidget() {
    return LevelModel(
      id: 'w1_l2',
      worldId: 'world_1',
      levelNumber: 2,
      title: 'StatelessWidget Basics',
      concept: 'StatelessWidget',
      lessonText: '''
StatelessWidget is the foundation of Flutter UI. It's a widget that describes part of your user interface that doesn't change over time.

**When to Use StatelessWidget:**
- When your UI doesn't need to change dynamically
- For displaying static text, images, or layouts
- When you don't need to track state

**Key Characteristics:**
- Immutable (cannot change after creation)
- Rebuilds when parent widget changes
- Lightweight and efficient
''',
      codeExample: '''class MyCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const MyCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}''',
      learningObjective: 'Understand StatelessWidget and when to use it',
      keyTakeaways: [
        'StatelessWidget is for UI that doesn\'t change',
        'Must override the build() method',
        'Can accept parameters via constructor',
        'Immutable and efficient',
      ],
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l2_c1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'When should you use StatelessWidget?',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'When the UI doesn\'t change over time',
              isCorrect: true,
              explanation: 'Correct! StatelessWidget is for static UI.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'When you need to track changing data',
              isCorrect: false,
              explanation: 'That\'s StatefulWidget territory!',
            ),
          ],
          xpReward: 15,
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 20,
      explanation: 'You now understand StatelessWidget!',
      isLocked: false,
    );
  }

  /// World 1, Level 3: StatefulWidget
  LevelModel _w1_l3_statefulWidget() {
    return LevelModel(
      id: 'w1_l3',
      worldId: 'world_1',
      levelNumber: 3,
      title: 'StatefulWidget Introduction',
      concept: 'StatefulWidget & setState()',
      lessonText: '''
StatefulWidget is used when your UI needs to change dynamically based on user interaction or data changes.

**When to Use StatefulWidget:**
- When data changes over time
- For interactive elements (buttons, forms)
- When you need to update the UI

**Key Method: setState()**
- Call setState() when data changes
- Triggers a rebuild of the widget
- Updates the UI with new data
''',
      codeExample: '''class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Count: \$count');
  }
}''',
      learningObjective: 'Understand StatefulWidget and setState()',
      keyTakeaways: [
        'StatefulWidget is for changing UI',
        'setState() triggers UI updates',
        'State is stored in a separate State class',
      ],
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l3_c1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What does setState() do?',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'Triggers a rebuild of the widget',
              isCorrect: true,
              explanation: 'Yes! setState() tells Flutter to rebuild the widget with new data.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'Creates a new widget',
              isCorrect: false,
              explanation: 'No, it rebuilds the existing widget.',
            ),
          ],
          xpReward: 20,
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 60,
      bonusXP: 25,
      explanation: 'Great! You understand StatefulWidget and setState().',
      isLocked: false,
    );
  }

  /// World 1, Level 4: Widget Tree
  LevelModel _w1_l4_widgetTree() {
    return LevelModel(
      id: 'w1_l4',
      worldId: 'world_1',
      levelNumber: 4,
      title: 'Understanding Widget Tree',
      concept: 'Widget Tree & Build Context',
      lessonText: '''
Flutter builds your UI as a tree of widgets. Understanding this tree is crucial for effective Flutter development.

**Widget Tree Basics:**
- Every widget has a parent (except the root)
- Widgets can have children
- Data flows down the tree
- Events bubble up

**Why It Matters:**
- Helps you structure your UI logically
- Explains how setState() works
- Essential for understanding context
''',
      codeExample: '''// Widget Tree Example
MaterialApp           // Root
  └─ Scaffold
      ├─ AppBar
      │   └─ Text
      └─ Column
          ├─ Text
          └─ Text''',
      learningObjective: 'Understand how Flutter builds UI as a widget tree',
      keyTakeaways: [
        'Flutter UI is a tree of widgets',
        'Parent widgets contain child widgets',
        'Understanding the tree helps debug issues',
      ],
      challengeSteps: [
        // Add challenges here
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 20,
      explanation: 'You now understand the widget tree concept!',
      isLocked: false,
    );
  }

  /// World 1, Level 5: Hot Reload
  LevelModel _w1_l5_hotReload() {
    return LevelModel(
      id: 'w1_l5',
      worldId: 'world_1',
      levelNumber: 5,
      title: 'Hot Reload & Hot Restart',
      concept: 'Development Workflow',
      lessonText: '''
Flutter's hot reload feature makes development fast and enjoyable!

**Hot Reload (⚡):**
- Injects updated code into running app
- Preserves app state
- Takes milliseconds
- Use: Ctrl+S or ⚡ button

**Hot Restart (🔄):**
- Restarts app from scratch
- Resets all state
- Takes a few seconds
- Use when hot reload doesn't work
''',
      codeExample: '''// Change text and hit Ctrl+S to see instant update!
Text('Hello World')  →  Text('Hello Flutter')
// App updates without losing state!''',
      learningObjective: 'Master Flutter\'s development workflow with hot reload',
      keyTakeaways: [
        'Hot reload speeds up development',
        'Preserves app state during updates',
        'Hot restart for major changes',
      ],
      challengeSteps: [
        // Add challenges
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 40,
      bonusXP: 15,
      explanation: 'You\'re now ready to develop Flutter apps efficiently!',
      isLocked: false,
    );
  }

  // ============================================
  // WORLD 2: WIDGETS (Sample levels)
  // ============================================

  List<LevelModel> _world2Levels() {
    return [
      // Add World 2 levels here
      // _w2_l1_container(),
      // _w2_l2_rowColumn(),
      // etc.
    ];
  }

  // ============================================
  // WORLD 3: STATE MANAGEMENT (Sample levels)
  // ============================================

  List<LevelModel> _world3Levels() {
    return [
      // Add World 3 levels here
      // _w3_l1_setStateBasics(),
      // etc.
    ];
  }

  // NOTE: Continue adding levels for other worlds following the same pattern
  // This structure easily scales to 100+ levels while keeping code organized
}
