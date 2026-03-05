import '../models/challenge_models.dart';
import '../models/level_model_v2.dart';
import '../models/world_model_v2.dart';

/// Enhanced World Data with Full Phase 1 Features
/// 
/// Features Demonstrated:
/// - Multiple challenge types (multipleChoice, fillInBlank, fixTheBug, buildWidget, arrangeCode, interactiveCode)
/// - Hint system with progressive hints
/// - Explanation system for both correct and incorrect answers
/// - Step-by-step challenges within levels
/// - Code validation integration
/// - XP rewards with penalties for hints/mistakes
class EnhancedWorldData {
  /// Get all worlds with complete Phase 1 features
  static List<WorldModel> getAllWorlds() {
    return [
      _world1_FlutterFoundations(),
      _world2_WidgetMastery(),
      _world3_StateManagement(),
    ];
  }

  /// Get all levels across all worlds
  static List<LevelModel> getAllLevels() {
    return [
      ..._world1Levels(),
      ..._world2Levels(),
      ..._world3Levels(),
    ];
  }

  // ============================================
  // WORLD 1: Flutter Foundations
  // ============================================

  static WorldModel _world1_FlutterFoundations() {
    return const WorldModel(
      id: 'world_1',
      worldNumber: 1,
      title: 'Flutter Foundations',
      description: 'Master the fundamentals of Flutter development',
      icon: '🚀',
      theme: 'Basics',
      levelIds: [
        'w1_l1_hello_flutter',
        'w1_l2_widgets_intro',
        'w1_l3_stateless_widget',
      ],
      requiredStarsToUnlock: 0,
      isLocked: false,
      totalXP: 150,
      estimatedDuration: Duration(minutes: 45),
      nextWorldId: 'world_2',
    );
  }

  static List<LevelModel> _world1Levels() {
    return [
      _level_w1_l1_helloFlutter(),
      _level_w1_l2_widgetsIntro(),
      _level_w1_l3_statelessWidget(),
    ];
  }

  /// Level 1: Hello Flutter - Multiple Choice Challenge
  static LevelModel _level_w1_l1_helloFlutter() {
    return LevelModel(
      id: 'w1_l1_hello_flutter',
      worldId: 'world_1',
      levelNumber: 1,
      title: 'Hello Flutter',
      concept: 'main() and runApp()',
      lessonText: '''
Every Flutter app starts with two essential functions:

**main()** - The entry point where your app begins execution
**runApp()** - Launches your Flutter app and displays the root widget

Think of main() as turning on your computer, and runApp() as launching your favorite application!
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
      learningObjective: 'Understand how Flutter apps start with main() and runApp()',
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l1_step1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What is the purpose of the main() function in Flutter?',
          description: 'Understanding the entry point of Flutter apps',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'It\'s the entry point where the app starts execution',
              isCorrect: true,
              explanation: 'Correct! main() is where every Dart program, including Flutter apps, begins execution.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'It displays widgets on the screen',
              isCorrect: false,
              explanation: 'Not quite! runApp() displays widgets. main() is just the starting point.',
            ),
            OptionModel(
              id: 'opt3',
              text: 'It handles user input',
              isCorrect: false,
              explanation: 'No, main() doesn\'t handle user input. It just starts the app.',
            ),
            OptionModel(
              id: 'opt4',
              text: 'It manages app state',
              isCorrect: false,
              explanation: 'State management comes later! main() simply starts your app.',
            ),
          ],
          xpReward: 20,
          hints: [
            'Think about where a program begins...',
            'The name "main" suggests it\'s the primary entry point',
            'Every Dart program needs a main() function to run',
          ],
          explanation: '''
The main() function is the entry point of every Flutter app. When you run your app, Dart looks for main() and starts executing code from there. Inside main(), we call runApp() to launch the Flutter framework and display our app.
''',
        ),
        ChallengeStep(
          id: 'w1_l1_step2',
          stepNumber: 2,
          type: ChallengeType.fillInBlank,
          question: 'Complete the code: void main() { ______(MyApp()); }',
          description: 'Fill in the function that launches the Flutter app',
          blankPlaceholder: '______',
          correctAnswer: 'runApp',
          xpReward: 15,
          hints: [
            'This function "runs" your app...',
            'It starts with "run" and ends with "App"',
            'The answer is runApp()',
          ],
          explanation: '''
runApp() is the Flutter function that launches your app. It takes a Widget (like MyApp) and makes it the root of your widget tree, then displays it on the screen.
''',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 10,
      hints: [
        'main() is where every Flutter app starts',
        'runApp() launches the widget tree',
      ],
      explanation: '''
Understanding main() and runApp() is fundamental:
• main() - Entry point (required in all Dart programs)
• runApp() - Launches Flutter framework
• Your widget becomes the app's root

This pattern appears in every Flutter app you'll ever create!
''',
      commonMistakes: [
        'Forgetting to call runApp() inside main()',
        'Not passing a widget to runApp()',
      ],
    );
  }

  /// Level 2: Widgets Intro - Fix the Bug Challenge
  static LevelModel _level_w1_l2_widgetsIntro() {
    return LevelModel(
      id: 'w1_l2_widgets_intro',
      worldId: 'world_1',
      levelNumber: 2,
      title: 'Understanding Widgets',
      concept: 'Everything is a Widget',
      lessonText: '''
In Flutter, EVERYTHING is a widget! Text, buttons, layouts, even padding and alignment - they're all widgets.

Widgets are like LEGO blocks - you combine small pieces to build something bigger and more complex.
''',
      codeExample: '''Container(
  padding: EdgeInsets.all(16),
  child: Column(
    children: [
      Text('Hello'),
      ElevatedButton(
        onPressed: () {},
        child: Text('Click Me'),
      ),
    ],
  ),
)''',
      learningObjective: 'Learn that widgets are the building blocks of Flutter UI',
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l2_step1',
          stepNumber: 1,
          type: ChallengeType.fixTheBug,
          question: 'Fix the broken code to create a Text widget',
          description: 'The code has a syntax error - find and fix it!',
          brokenCode: '''Container(
  child: Text('Hello World)
)''',
          fixedCode: '''Container(
  child: Text('Hello World'),
)''',
          bugHint: 'Look carefully at the string quotation marks',
          correctAnswer: 'Text(\'Hello World\')',
          validationRules: ['Text(', 'Hello World', '\')'],
          xpReward: 25,
          hints: [
            'Check if all quotation marks are properly closed',
            'The string needs a closing single quote',
            'Add \') after "Hello World"',
          ],
          explanation: '''
Strings in Dart must be properly closed with matching quotes. The string 'Hello World' was missing its closing quote, causing a syntax error.

Remember: 
• Single quotes: 'text'
• Double quotes: "text"
Both work, but be consistent!
''',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      hints: [
        'Widgets describe what the UI should look like',
        'Think of widgets as building blocks',
      ],
      explanation: '''
Widgets are the fundamental building blocks of Flutter apps. Everything you see on screen is a widget - text, buttons, layouts, and even invisible things like padding!
''',
    );
  }

  /// Level 3: StatelessWidget - Build Widget Challenge
  static LevelModel _level_w1_l3_statelessWidget() {
    return LevelModel(
      id: 'w1_l3_stateless_widget',
      worldId: 'world_1',
      levelNumber: 3,
      title: 'StatelessWidget',
      concept: 'Creating Custom Widgets',
      lessonText: '''
StatelessWidget is used for UI that doesn't change. It's immutable - once built, it stays the same until the entire widget is rebuilt.

Examples: Text, Icon, Image - they display something but don't change by themselves.
''',
      codeExample: '''class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text('Press Me'),
    );
  }
}''',
      learningObjective: 'Create custom widgets using StatelessWidget',
      challengeSteps: [
        ChallengeStep(
          id: 'w1_l3_step1',
          stepNumber: 1,
          type: ChallengeType.buildWidget,
          question: 'Create a StatelessWidget that displays "Hello Flutter!"',
          description: 'Write a complete StatelessWidget class with a build method',
          widgetRequirement: 'HelloWidget that returns Text widget',
          requiredWidgets: ['StatelessWidget', 'Text', 'build'],
          correctAnswer: 'class HelloWidget extends StatelessWidget',
          validationRules: [
            'extends StatelessWidget',
            'Widget build',
            'Text(',
            'Hello Flutter',
          ],
          xpReward: 30,
          hints: [
            'Start with: class HelloWidget extends StatelessWidget',
            'Add the build method that returns a Widget',
            'Return a Text widget with your message',
          ],
          explanation: '''
StatelessWidget requires:
1. A class that extends StatelessWidget
2. An override of the build() method
3. The build() method must return a Widget

Example:
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello!');
  }
}
''',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 60,
      hints: [
        'StatelessWidget is for UI that doesn\'t change',
        'Override the build() method',
      ],
      explanation: '''
StatelessWidget is perfect for static UI:
• Immutable - doesn't change after creation
• Has a build() method that describes the UI
• Efficient - Flutter can optimize rendering

Use StatelessWidget when your UI doesn't need to change based on user interaction or data updates.
''',
    );
  }

  // ============================================
  // WORLD 2: Widget Mastery
  // ============================================

  static WorldModel _world2_WidgetMastery() {
    return const WorldModel(
      id: 'world_2',
      worldNumber: 2,
      title: 'Widget Mastery',
      description: 'Master layout and styling widgets',
      icon: '🎨',
      theme: 'Layouts',
      levelIds: [
        'w2_l1_container_padding',
        'w2_l2_row_column',
      ],
      requiredStarsToUnlock: 3,
      isLocked: true,
      totalXP: 200,
      estimatedDuration: Duration(minutes: 60),
      prerequisites: ['world_1'],
      nextWorldId: 'world_3',
    );
  }

  static List<LevelModel> _world2Levels() {
    return [
      _level_w2_l1_containerPadding(),
      _level_w2_l2_rowColumn(),
    ];
  }

  /// Level 1: Container & Padding
  static LevelModel _level_w2_l1_containerPadding() {
    return LevelModel(
      id: 'w2_l1_container_padding',
      worldId: 'world_2',
      levelNumber: 1,
      title: 'Container & Padding',
      concept: 'Layout Basics',
      lessonText: '''
Container is like a box that can hold other widgets. You can add:
• Padding (space inside)
• Margin (space outside)
• Colors and decorations
• Width and height

It's one of the most versatile widgets in Flutter!
''',
      codeExample: '''Container(
  padding: EdgeInsets.all(20),
  margin: EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('Hello'),
)''',
      learningObjective: 'Use Container and Padding for layout',
      challengeSteps: [
        ChallengeStep(
          id: 'w2_l1_step1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'What does padding do in a Container?',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'Adds space inside the container',
              isCorrect: true,
              explanation: 'Yes! Padding adds space between the container edges and its child.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'Adds space outside the container',
              isCorrect: false,
              explanation: 'That\'s margin! Padding adds space INSIDE.',
            ),
            OptionModel(
              id: 'opt3',
              text: 'Changes the container color',
              isCorrect: false,
              explanation: 'No, color is set separately in decoration.',
            ),
          ],
          xpReward: 20,
          hints: [
            'Think about where the space is added...',
            'Padding adds space INSIDE the container',
          ],
          explanation: 'Padding creates space inside the container, between its edges and its child widget.',
        ),
        ChallengeStep(
          id: 'w2_l1_step2',
          stepNumber: 2,
          type: ChallengeType.interactiveCode,
          question: 'Create a Container with padding of 16 on all sides',
          description: 'Use EdgeInsets.all() to add padding',
          correctAnswer: 'EdgeInsets.all(16)',
          validationRules: ['Container', 'padding', 'EdgeInsets.all', '16'],
          xpReward: 25,
          hints: [
            'Use Container widget',
            'Set padding property to EdgeInsets.all(16)',
          ],
          explanation: '''
EdgeInsets.all(16) adds 16 pixels of padding on all four sides.

Other options:
• EdgeInsets.symmetric(horizontal: 16, vertical: 8)
• EdgeInsets.only(left: 16, top: 8)
''',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 70,
      explanation: 'Container is a versatile widget for layout and decoration!',
    );
  }

  /// Level 2: Row & Column - Arrange Code Challenge
  static LevelModel _level_w2_l2_rowColumn() {
    return LevelModel(
      id: 'w2_l2_row_column',
      worldId: 'world_2',
      levelNumber: 2,
      title: 'Row & Column',
      concept: 'Layout Widgets',
      lessonText: '''
Row and Column are layout widgets:
• Row - Arranges children horizontally (left to right)
• Column - Arranges children vertically (top to bottom)

They're like shelves: Row is a horizontal shelf, Column is a vertical shelf!
''',
      codeExample: '''Column(
  children: [
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)''',
      learningObjective: 'Arrange widgets using Row and Column',
      challengeSteps: [
        ChallengeStep(
          id: 'w2_l2_step1',
          stepNumber: 1,
          type: ChallengeType.arrangeCode,
          question: 'Arrange these code pieces to create a Column with two Text widgets',
          description: 'Put the code in the correct order',
          codePieces: [
            'Column(',
            '  children: [',
            '    Text(\'First\'),',
            '    Text(\'Second\'),',
            '  ],',
            ')',
          ],
          correctOrder: [
            'Column(',
            '  children: [',
            '    Text(\'First\'),',
            '    Text(\'Second\'),',
            '  ],',
            ')',
          ],
          xpReward: 30,
          hints: [
            'Start with Column(',
            'Add the children property',
            'Add two Text widgets in the children list',
          ],
          explanation: '''
Column arranges its children vertically. The structure is:
1. Column( - Start the Column widget
2. children: [ - List of child widgets
3. Text widgets - Your content
4. ] - Close the list
5. ) - Close the Column
''',
        ),
      ],
      difficulty: DifficultyLevel.beginner,
      baseXP: 80,
      explanation: 'Row and Column are essential for creating layouts in Flutter!',
    );
  }

  // ============================================
  // WORLD 3: State Management
  // ============================================

  static WorldModel _world3_StateManagement() {
    return const WorldModel(
      id: 'world_3',
      worldNumber: 3,
      title: 'State Management',
      description: 'Make your apps interactive',
      icon: '⚡',
      theme: 'Interactivity',
      levelIds: [
        'w3_l1_stateful_widget',
      ],
      requiredStarsToUnlock: 6,
      isLocked: true,
      totalXP: 250,
      estimatedDuration: Duration(minutes: 90),
      prerequisites: ['world_1', 'world_2'],
    );
  }

  static List<LevelModel> _world3Levels() {
    return [
      _level_w3_l1_statefulWidget(),
    ];
  }

  /// Level 1: StatefulWidget
  static LevelModel _level_w3_l1_statefulWidget() {
    return LevelModel(
      id: 'w3_l1_stateful_widget',
      worldId: 'world_3',
      levelNumber: 1,
      title: 'StatefulWidget',
      concept: 'Managing State',
      lessonText: '''
StatefulWidget is for UI that CAN change. It has state - data that can change over time.

Examples: Buttons that change color when pressed, counters that increment, text fields where users type.

State + setState() = Interactive UI!
''',
      codeExample: '''class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \$count'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: Text('Increment'),
        ),
      ],
    );
  }
}''',
      learningObjective: 'Create interactive widgets with state',
      challengeSteps: [
        ChallengeStep(
          id: 'w3_l1_step1',
          stepNumber: 1,
          type: ChallengeType.multipleChoice,
          question: 'When do you use StatefulWidget instead of StatelessWidget?',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'When the UI needs to change based on user interaction',
              isCorrect: true,
              explanation: 'Correct! StatefulWidget is for dynamic, changing UI.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'When displaying static text',
              isCorrect: false,
              explanation: 'No, static UI should use StatelessWidget.',
            ),
            OptionModel(
              id: 'opt3',
              text: 'When the UI never changes',
              isCorrect: false,
              explanation: 'That\'s when you use StatelessWidget!',
            ),
          ],
          xpReward: 25,
          hints: [
            'Think about interactive vs static UI',
            'Stateful = can change state',
          ],
          explanation: '''
Use StatefulWidget when:
• UI needs to change based on user actions
• You need to track changing data
• Widgets need to be rebuilt with new data

Use StatelessWidget when:
• UI is static and doesn't change
• Widget just displays data passed to it
''',
        ),
        ChallengeStep(
          id: 'w3_l1_step2',
          stepNumber: 2,
          type: ChallengeType.fillInBlank,
          question: 'What method do you call to update the UI? Set_____()',
          correctAnswer: 'setState',
          xpReward: 20,
          hints: [
            'It starts with "set" and ends with "State"',
            'setState() tells Flutter to rebuild the widget',
          ],
          explanation: '''
setState() is THE method for updating UI in StatefulWidget.

Call setState() when you change state variables, and Flutter will rebuild your widget with the new data.

setState(() {
  // Change your state here
  count++;
});
''',
        ),
      ],
      difficulty: DifficultyLevel.intermediate,
      baseXP: 100,
      explanation: '''
StatefulWidget brings your apps to life:
• Has mutable state
• Uses setState() to trigger rebuilds
• Perfect for interactive UI

Remember: StatelessWidget for static, StatefulWidget for dynamic!
''',
    );
  }
}
