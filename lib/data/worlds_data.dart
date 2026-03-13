import '../models/level_model.dart';
import '../models/world_model.dart';
import '../models/lesson_content_model.dart';

class GameData {
  static List<World> getAllWorlds() {
    return [
      _getWorld1(),
      _getWorld2(),
      _getWorld3(),
    ];
  }

  // WORLD 1: Flutter Basics
  static World _getWorld1() {
    return World(
      id: 'world_1',
      title: 'Flutter Basics',
      description: 'Master the fundamentals of Flutter development',
      icon: '🚀',
      levels: [
        Level(
          id: 'w1-l1',
          worldId: 'world_1',
          levelNumber: 1,
          title: 'Hello Flutter',
          concept: 'main.dart & runApp()',
          learningObjective: 'Understand how Flutter apps start and the purpose of main.dart',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Write a basic Flutter app with main() function that calls runApp()',
          expectedCode: '''void main() {
  runApp(MyApp());
}''',
          validationRules: [
            'main()',
            'runApp(',
          ],
          baseXP: 60,
          explanation: '''
The main() function is the entry point of every Flutter app.

• main() - Starting point of your app
• runApp() - Takes a widget and displays it on screen
• MyApp() - Your root widget

Think of main() as opening a book, and runApp() as showing the first page to the reader.
''',
          commonMistakes: [
            'Forgetting to call runApp()',
            'Not wrapping app in a widget',
          ],
          hints: [
            'Every Flutter app needs a main() function',
            'You should call runApp() inside main() to start the widget tree',
            '''void main() {
  runApp(MyApp());
}''',
          ],
          lessonContent: LessonContent(
            title: 'Introduction to Flutter Apps',
            description: 'Learn how every Flutter app begins with the main() function and runApp().',
            conceptExplanation: '''Flutter apps always start with a main() function - just like many programming languages. This is the entry point where your app begins execution.

Inside main(), we call runApp() which takes a Widget and makes it the root of your app. The widget you pass to runApp() becomes the foundation of your entire app's widget tree.

Key points:
• main() is required - without it, your app won't run
• runApp() initializes the Flutter framework
• The widget passed to runApp() becomes your app's root
• This pattern is used in every single Flutter app''',
            analogy: 'Think of main() as turning on a television, and runApp() as selecting which channel (your app) to display. Without turning on the TV first, you can\'t watch anything!',
            codeExample: '''void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Hello Flutter!'),
    );
  }
}''',
            keyPoints: [
              'main() is the entry point of every Flutter app',
              'runApp() launches your app and displays the first widget',
              'The widget tree starts from the widget passed to runApp()',
              'StatelessWidget is used for widgets that don\'t change',
              'MaterialApp provides Material Design styling',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Building Your First Flutter App',
            introduction: 'Let\'s walk through creating a simple Flutter app step by step. By the end, you\'ll understand exactly how main(), runApp(), and widgets work together.',
            summary: 'Congratulations! You\'ve learned how Flutter apps start with main(), use runApp() to launch, and build a widget tree. This pattern is the foundation of every Flutter app you\'ll create.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Step 1: Create the main() function',
                description: 'The main() function is where every Flutter app starts. This is required and must be present.',
                codeSnippet: '''void main() {
  // App starts here
}''',
                highlights: [
                  'void means this function doesn\'t return any value',
                  'main() is the function name - it must be exactly "main"',
                  'Every Dart program needs a main() function to run',
                ],
                explanation: 'When you run your Flutter app, the Dart runtime looks for the main() function and starts executing code from there. Without it, your app won\'t know where to begin.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Step 2: Call runApp()',
                description: 'Inside main(), we need to call runApp() to actually launch our Flutter app.',
                codeSnippet: '''void main() {
  runApp(MyApp());
}''',
                highlights: [
                  'runApp() is a Flutter function that initializes your app',
                  'It takes a Widget as parameter - MyApp() in this case',
                  'This widget becomes the root of your widget tree',
                ],
                explanation: 'runApp() tells Flutter "here\'s my app, please display it!" It sets up all the internal Flutter mechanisms and shows your widget on the screen.',
              ),
              GuidedStep(
                stepNumber: 3,
                title: 'Step 3: Create MyApp widget',
                description: 'MyApp is your root widget. Let\'s create it as a StatelessWidget.',
                codeSnippet: '''class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Hello Flutter!'),
    );
  }
}''',
                highlights: [
                  'StatelessWidget is for widgets that don\'t change over time',
                  'build() method describes how the widget looks',
                  'MaterialApp provides Material Design features',
                  'home property sets what users see first',
                ],
                explanation: 'The build() method is called by Flutter when it needs to display your widget. It returns a widget tree that describes what should appear on screen. MaterialApp is a convenient widget that sets up Material Design for your app.',
              ),
            ],
          ),
          isLocked: false,
        ),
        Level(
          id: 'w1-l2',
          worldId: 'world_1',
          levelNumber: 2,
          title: 'Scaffold Basics',
          concept: 'Scaffold Widget',
          learningObjective: 'Learn how Scaffold provides basic app structure',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Fix the broken code to create a screen with an AppBar titled "Home"',
          expectedCode: '''Scaffold(
  appBar: AppBar(
    title: Text("Home"),
  ),
  body: Center(
    child: Text("Welcome to Flutter!"),
  ),
)''',
          validationRules: [
            'Scaffold(',
            'appBar: AppBar(',
            'title: Text(',
          ],
          baseXP: 60,
          explanation: '''
Scaffold is like a blueprint for your screen:

• appBar - Top bar with title
• body - Main content area
• floatingActionButton - Round button (optional)
• drawer - Side menu (optional)

Scaffold gives you ready-made components for common UI patterns!
''',
          commonMistakes: [
            'Forgetting to add AppBar',
            'Not wrapping Text in a widget',
          ],
          hints: [
            'Scaffold needs an appBar property',
            'AppBar needs a title property',
            '''Scaffold(
  appBar: AppBar(
    title: Text('My App'),
  ),
)''',
          ],
          lessonContent: LessonContent(
            title: 'Scaffold Basics',
            description: 'Learn the foundation of Flutter screen layouts',
            conceptExplanation: '''Scaffold is one of the most important widgets in Flutter. It provides a basic visual structure for your app, including an AppBar, body, floating action buttons, and more.

Think of Scaffold as the skeleton or framework of a house - it provides the structure that everything else is built upon.

Why use Scaffold?
• Provides consistent Material Design layout
• Includes built-in slots for AppBar, body, drawer, bottom navigation, etc.
• Handles responsive behavior automatically
• Makes your app look professional with minimal code

Almost every screen in a Flutter app uses Scaffold as its foundation.''',
            analogy: 'Scaffold is like the frame of a building - it provides the structure (walls, roof, foundation) that everything else is built upon. The AppBar is the roof, the body is the main living space!',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My First App'),
      ),
      body: Center(
        child: Text('Hello Scaffold!'),
      ),
    ),
  ));
}''',
            keyPoints: [
              'Scaffold provides the basic Material Design structure',
              'AppBar goes at the top of the screen',
              'body contains the main content',
              'Scaffold is used in nearly every Flutter screen',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Building a Scaffold Screen',
            introduction: 'Let\'s create a complete screen using Scaffold. You\'ll learn how to add an AppBar and body content.',
            summary: 'Great! You now know how to use Scaffold to create structured screens with AppBars and body content.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Start with Scaffold',
                description: 'Scaffold is a container widget that provides the basic structure for a screen.',
                codeSnippet: 'home: Scaffold(\n  \n)',
                highlights: ['Scaffold provides the layout framework', 'Most Flutter screens use Scaffold'],
                explanation: 'Scaffold gives you a pre-built structure following Material Design guidelines.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add an AppBar',
                description: 'The appBar property adds a title bar at the top of your screen.',
                codeSnippet: 'home: Scaffold(\n  appBar: AppBar(\n    title: Text(\'Welcome\'),\n  ),\n)',
                highlights: ['appBar is optional but commonly used', 'AppBar displays at the top of the screen', 'title property sets the AppBar text'],
                explanation: 'AppBar is the colored bar at the top showing your screen title and optional actions.',
              ),
              GuidedStep(
                stepNumber: 3,
                title: 'Add a Body',
                description: 'The body property contains the main content.',
                codeSnippet: 'Scaffold(\n  appBar: AppBar(\n    title: Text(\'Welcome\'),\n  ),\n  body: Center(\n    child: Text(\'Hello!\'),\n  ),\n)',
                highlights: ['body is where your main content goes', 'Can contain any widget', 'Center widget centers the content'],
                explanation: 'The body fills the remaining space below the AppBar with your content.',
              ),
            ],
          ),
        ),
        Level(
          id: 'w1-l3',
          worldId: 'world_1',
          levelNumber: 3,
          title: 'StatelessWidget',
          concept: 'StatelessWidget',
          learningObjective: 'Create your first custom widget',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.medium,
          challengeDescription: 'Create a StatelessWidget called "WelcomeScreen" with a Scaffold',
          expectedCode: '''class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome")),
      body: Center(child: Text("Hello!")),
    );
  }
}''',
          validationRules: [
            'extends StatelessWidget',
            '@override',
            'build(BuildContext context)',
          ],
          baseXP: 75,
          explanation: '''
StatelessWidget is a widget that doesn't change:

• Extends StatelessWidget
• Overrides build() method
• Returns UI structure
• Immutable (doesn't change)

Use StatelessWidget when your UI doesn't need to update based on user interaction.
''',
          commonMistakes: [
            'Forgetting @override annotation',
            'Not returning a widget',
          ],
          hints: [
            'Use the extends keyword',
            'build() method must return a Widget',
            '''class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello');
  }
}''',
          ],
          lessonContent: LessonContent(
            title: 'StatelessWidget',
            description: 'Create reusable, immutable widgets',
            conceptExplanation: '''StatelessWidget is a widget that doesn't change over time. Once it's built, its properties remain constant. This makes it perfect for static UI elements.

Key Characteristics:
• Immutable - properties cannot change after creation
• Lightweight - no state management overhead
• Reusable - can be used multiple times throughout your app
• Efficient - Flutter can optimize rendering since it never changes

When to use StatelessWidget:
• Static text, images, or icons
• Layouts that don't change
• Reusable UI components without interactive behavior''',
            analogy: 'Think of StatelessWidget like a printed poster - once it\'s created, it doesn\'t change. If you want to show different content, you need to create a new poster (widget).',
            codeExample: '''import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text('I am a reusable card!'),
      ),
    );
  }
}''',
            keyPoints: [
              'StatelessWidget is immutable and doesn\'t change',
              'Must override the build() method',
              'Perfect for static UI elements',
              'Use extends keyword to create a StatelessWidget',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Creating Your First StatelessWidget',
            introduction: 'Let\'s create a custom widget that you can reuse throughout your app.',
            summary: 'Excellent! You\'ve created a reusable StatelessWidget that can be used anywhere in your app.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Declare the class',
                description: 'Create a class that extends StatelessWidget.',
                codeSnippet: 'class WelcomeScreen extends StatelessWidget {\n  \n}',
                highlights: ['Use the class keyword', 'extends StatelessWidget makes it a widget', 'Give it a descriptive name'],
                explanation: 'By extending StatelessWidget, we tell Flutter this is a widget that won\'t change.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Override build method',
                description: 'Add the build() method that returns UI.',
                codeSnippet: 'class WelcomeScreen extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    \n  }\n}',
                highlights: ['@override indicates we\'re overriding a parent method', 'build() must return a Widget', 'context provides information about the widget\'s location'],
                explanation: 'The build method describes what this widget looks like.',
              ),
              GuidedStep(
                stepNumber: 3,
                title: 'Return a widget',
                description: 'Return a Scaffold with content.',
                codeSnippet: 'class WelcomeScreen extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Scaffold(\n      appBar: AppBar(title: Text("Welcome")),\n      body: Center(child: Text("Hello!")),\n    );\n  }\n}',
                highlights: ['return keyword sends the widget back', 'Scaffold provides screen structure', 'This widget is now reusable!'],
                explanation: 'Now you can use WelcomeScreen() anywhere in your app!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w1-l4',
          worldId: 'world_1',
          levelNumber: 4,
          title: 'AppBar Styling',
          concept: 'AppBar customization',
          learningObjective: 'Customize AppBar with colors and actions',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Add a blue background color to the AppBar',
          expectedCode: '''AppBar(
  title: Text("Styled App"),
  backgroundColor: Colors.blue,
)''',
          validationRules: [
            'backgroundColor:',
            'Colors.blue',
          ],
          baseXP: 60,
          explanation: '''
AppBar can be customized with many properties:

• backgroundColor - Change the background color
• title - The main text
• actions - Buttons on the right side
• leading - Widget on the left side

Colors.blue is one of Material Design's predefined colors!
''',
          hints: [
            'Use the backgroundColor property',
            'Colors.blue is a predefined color',
            '''AppBar(
  backgroundColor: Colors.blue,
  title: Text('My App'),
)''',
          ],
          lessonContent: LessonContent(
            title: 'AppBar Styling',
            description: 'Customize AppBar appearance with colors and styles',
            conceptExplanation: '''AppBar is highly customizable! You can change its background color, add action buttons, customize the title, and much more.

Common AppBar properties:
• backgroundColor - Sets the AppBar background color
• title - The main text displayed
• actions - List of widgets shown on the right (like buttons)
• leading - Widget shown on the left (like back button)
• elevation - Shadow depth below the AppBar

Flutter provides the Colors class with many predefined colors like Colors.blue, Colors.red, Colors.green, etc.''',
            analogy: 'Think of AppBar styling like decorating the header of a document - you can change the background color, add logos, and customize the text to match your brand.',
            codeExample: '''import 'package:flutter/material.dart';

AppBar(
  title: Text('Styled App'),
  backgroundColor: Colors.blue,
  elevation: 4,
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
)''',
            keyPoints: [
              'backgroundColor changes the AppBar color',
              'Colors class provides predefined colors',
              'actions property adds buttons on the right',
              'AppBar styling makes your app look professional',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Styling Your AppBar',
            introduction: 'Let\'s customize an AppBar with colors to make it look great!',
            summary: 'Perfect! You now know how to style AppBars to match your app\'s design.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Start with AppBar',
                description: 'Create a basic AppBar with a title.',
                codeSnippet: 'AppBar(\n  title: Text(\'Styled App\'),\n)',
                highlights: ['AppBar displays at the top', 'title shows the screen name'],
                explanation: 'This creates a default-styled AppBar.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add Background Color',
                description: 'Use backgroundColor to change the AppBar color.',
                codeSnippet: 'AppBar(\n  title: Text(\'Styled App\'),\n  backgroundColor: Colors.blue,\n)',
                highlights: ['backgroundColor is a property of AppBar', 'Colors.blue is a predefined color', 'The entire AppBar becomes blue'],
                explanation: 'Now your AppBar has a beautiful blue background!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w1-l5',
          worldId: 'world_1',
          levelNumber: 5,
          title: 'Center Widget',
          concept: 'Center & Alignment',
          learningObjective: 'Learn how to center widgets on screen',
          challengeType: ChallengeType.multipleChoice,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Which widget centers its child in the available space?',
          expectedCode: '''Center(
  child: Text("I'm centered!"),
)''',
          validationRules: [
            'Must use Center widget',
            'Must have child property',
          ],
          baseXP: 60,
          explanation: '''
Center widget centers its child widget:

• Takes any widget as child
• Centers it both horizontally and vertically
• Expands to fill available space

Other alignment options: Align, Positioned, Container with alignment
''',
          hints: [
            'The widget name is literally "Center"',
            'It wraps around other widgets',
            '''Center(
  child: Text('Centered Text'),
)''',
          ],
          lessonContent: LessonContent(
            title: 'Center Widget',
            description: 'Learn how to center widgets on screen',
            conceptExplanation: '''The Center widget is one of the simplest and most useful layout widgets in Flutter. It takes a single child widget and positions it in the center of its available space.

Key features:
• Centers child both horizontally AND vertically
• Expands to fill available space
• Works with any widget as a child
• Very commonly used for simple layouts

Center is perfect when you want to place something in the middle of the screen or a container.''',
            analogy: 'Think of Center like placing a painting in the middle of a wall - it automatically finds the center point and positions the content there, no matter the wall (screen) size.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text(
          'I am centered!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    ),
  ));
}''',
            keyPoints: [
              'Center positions its child in the middle of available space',
              'Centers both horizontally and vertically',
              'Takes a single child widget',
              'Commonly used in Scaffold body',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Using the Center Widget',
            introduction: 'Let\'s learn how to center content on screen using the Center widget.',
            summary: 'Great! You now know how to use Center to position widgets in the middle of the screen.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Start with Center',
                description: 'Wrap your widget with Center.',
                codeSnippet: 'Center(\n  \n)',
                highlights: ['Center is a layout widget', 'It takes a child parameter'],
                explanation: 'Center will position whatever you give it in the middle.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add a child',
                description: 'Give Center a child widget to center.',
                codeSnippet: 'Center(\n  child: Text(\'I am centered!\'),\n)',
                highlights: ['child is the widget to center', 'Text widget displays text', 'Center handles positioning automatically'],
                explanation: 'The Text will now appear in the center of the screen!',
              ),
            ],
          ),
        ),
      ],
      requiredStars: 0,
      isLocked: false,
    );
  }

  // WORLD 2: Layout Mastery
  static World _getWorld2() {
    return World(
      id: 'world_2',
      title: 'Layout Mastery',
      description: 'Master Flutter layouts with Row, Column, and more',
      icon: '📐',
      levels: [
        Level(
          id: 'w2-l1',
          worldId: 'world_2',
          levelNumber: 1,
          title: 'Column Basics',
          concept: 'Column Widget',
          learningObjective: 'Arrange widgets vertically using Column',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Create a Column with three Text widgets stacked vertically',
          expectedCode: '''Column(
  children: [
    Text("First"),
    Text("Second"),
    Text("Third"),
  ],
)''',
          validationRules: [
            'Column(',
            'children: [',
            'Text("',
          ],
          baseXP: 60,
          explanation: '''
Column arranges widgets vertically:

• children - List of widgets to stack
• mainAxisAlignment - Vertical alignment
• crossAxisAlignment - Horizontal alignment

Column is perfect for forms, lists, and vertical layouts!
''',
          commonMistakes: [
            'Forgetting the children property',
            'Not using a List for children',
          ],
          hints: [
            'Column needs a children property',
            'children is a List of widgets',
            '''Column(
  children: [
    Text('First'),
    Text('Second'),
  ],
)''',
          ],
          lessonContent: LessonContent(
            title: 'Column Basics',
            description: 'Arrange widgets vertically using Column',
            conceptExplanation: '''Column is a layout widget that arranges its children vertically from top to bottom. It's one of the most commonly used widgets in Flutter.

Key features:
• Arranges children in a vertical list
• Can contain multiple widgets
• Supports alignment with mainAxisAlignment and crossAxisAlignment
• Perfect for forms, lists, and stacked content

Think of Column like stacking books on top of each other - they arrange from top to bottom.''',
            analogy: 'Column is like stacking plates in a cupboard - each item goes on top of the previous one, creating a vertical arrangement.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        children: [
          Text('First'),
          Text('Second'),
          Text('Third'),
        ],
      ),
    ),
  ));
}''',
            keyPoints: [
              'Column arranges widgets vertically',
              'children property takes a list of widgets',
              'mainAxisAlignment controls vertical spacing',
              'crossAxisAlignment controls horizontal alignment',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Creating Your First Column',
            introduction: 'Let\'s learn how to stack widgets vertically using Column.',
            summary: 'Great! You now know how to arrange widgets vertically with Column.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Create Column',
                description: 'Start with a Column widget.',
                codeSnippet: 'Column(\n  \n)',
                highlights: ['Column is a layout widget', 'It stacks children vertically'],
                explanation: 'Column is the starting point for vertical layouts.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add children',
                description: 'Add multiple Text widgets to children.',
                codeSnippet: 'Column(\n  children: [\n    Text(\'First\'),\n    Text(\'Second\'),\n    Text(\'Third\'),\n  ],\n)',
                highlights: ['children is a list', 'Each widget stacks vertically'],
                explanation: 'Now you have three Text widgets stacked on top of each other!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w2-l2',
          worldId: 'world_2',
          levelNumber: 2,
          title: 'Row Basics',
          concept: 'Row Widget',
          learningObjective: 'Arrange widgets horizontally using Row',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Fix the Row to place three icons side by side',
          expectedCode: '''Row(
  children: [
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.settings),
  ],
)''',
          validationRules: [
            'Row(',
            'children: [',
            'Icon(Icons.',
          ],
          baseXP: 60,
          explanation: '''
Row arranges widgets horizontally:

• children - List of widgets in a row
• mainAxisAlignment - Horizontal alignment
• crossAxisAlignment - Vertical alignment

Perfect for navigation bars, button groups, and horizontal layouts!
''',
          hints: [
            'Row is like Column, but horizontal',
            'Use Icon(Icons.name)',
            '''Row(
  children: [
    Icon(Icons.star),
    Icon(Icons.favorite),
  ],
)''',
          ],
          lessonContent: LessonContent(
            title: 'Row Basics',
            description: 'Arrange widgets horizontally using Row',
            conceptExplanation: '''Row is a layout widget that arranges its children horizontally from left to right. It's the horizontal counterpart to Column.

Key features:
• Arranges children in a horizontal line
• Can contain multiple widgets
• Supports alignment with mainAxisAlignment and crossAxisAlignment
• Perfect for navigation bars, button groups, and horizontal layouts

Think of Row like arranging books on a shelf - they line up side by side.''',
            analogy: 'Row is like placing items on a shelf - each item sits next to the previous one, creating a horizontal arrangement.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.settings),
        ],
      ),
    ),
  ));
}''',
            keyPoints: [
              'Row arranges widgets horizontally',
              'children property takes a list of widgets',
              'mainAxisAlignment controls horizontal spacing',
              'crossAxisAlignment controls vertical alignment',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Creating Your First Row',
            introduction: 'Let\'s learn how to arrange widgets horizontally using Row.',
            summary: 'Excellent! You can now arrange widgets side by side with Row.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Create Row',
                description: 'Start with a Row widget.',
                codeSnippet: 'Row(\n  \n)',
                highlights: ['Row is a layout widget', 'It arranges children horizontally'],
                explanation: 'Row is the starting point for horizontal layouts.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add children',
                description: 'Add multiple Icon widgets to children.',
                codeSnippet: 'Row(\n  children: [\n    Icon(Icons.home),\n    Icon(Icons.search),\n    Icon(Icons.settings),\n  ],\n)',
                highlights: ['children is a list', 'Each widget appears side by side'],
                explanation: 'Now you have three icons arranged horizontally!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w2-l3',
          worldId: 'world_2',
          levelNumber: 3,
          title: 'MainAxisAlignment',
          concept: 'Alignment in Column/Row',
          learningObjective: 'Control spacing and alignment in Column and Row',
          challengeType: ChallengeType.multipleChoice,
          difficulty: DifficultyLevel.medium,
          challengeDescription: 'What MainAxisAlignment evenly spaces widgets with space at edges?',
          expectedCode: '''Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [...],
)''',
          validationRules: [
            'Must use MainAxisAlignment',
            'Must use spaceEvenly',
          ],
          baseXP: 60,
          explanation: '''
MainAxisAlignment options:

• start - Beginning of the axis
• end - End of the axis
• center - Middle of the axis
• spaceBetween - Space between widgets
• spaceAround - Space around widgets
• spaceEvenly - Equal space everywhere

For Column: vertical axis. For Row: horizontal axis.
''',
          hints: [
            'Look for the word "evenly"',
            'It distributes space equally',
            '''Column(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [...],
)''',
          ],
          lessonContent: LessonContent(
            title: 'MainAxisAlignment',
            description: 'Control spacing and alignment in Column and Row',
            conceptExplanation: '''MainAxisAlignment controls how children are positioned along the main axis of a Column or Row.

For Column: main axis is vertical (top to bottom)
For Row: main axis is horizontal (left to right)

Options:
• start - Beginning of the axis
• end - End of the axis
• center - Middle of the axis
• spaceBetween - Space between widgets, no space at edges
• spaceAround - Space around each widget
• spaceEvenly - Equal space everywhere including edges

This is crucial for creating professional, well-spaced layouts.''',
            analogy: 'MainAxisAlignment is like deciding how to arrange photos on a wall - do you cluster them together, space them evenly, or push them to the edges?',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Top'),
          Text('Middle'),
          Text('Bottom'),
        ],
      ),
    ),
  ));
}''',
            keyPoints: [
              'MainAxisAlignment controls positioning along the main axis',
              'For Column: main axis is vertical',
              'For Row: main axis is horizontal',
              'spaceEvenly creates equal space everywhere',
              'spaceBetween puts space only between widgets',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Understanding MainAxisAlignment',
            introduction: 'Let\'s learn how to control widget spacing with MainAxisAlignment.',
            summary: 'Perfect! You now understand how to control spacing in layouts.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Add MainAxisAlignment',
                description: 'Add mainAxisAlignment to Column.',
                codeSnippet: 'Column(\n  mainAxisAlignment: MainAxisAlignment.spaceEvenly,\n  children: [...],\n)',
                highlights: ['mainAxisAlignment controls spacing', 'spaceEvenly creates equal space'],
                explanation: 'Now widgets are evenly spaced with equal gaps!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w2-l4',
          worldId: 'world_2',
          levelNumber: 4,
          title: 'Expanded Widget',
          concept: 'Expanded & Flex',
          learningObjective: 'Use Expanded to fill available space',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.medium,
          challengeDescription: 'Wrap the middle Container in Expanded to fill available space',
          expectedCode: '''Row(
  children: [
    Container(width: 50, color: Colors.red),
    Expanded(
      child: Container(color: Colors.blue),
    ),
    Container(width: 50, color: Colors.green),
  ],
)''',
          validationRules: [
            'Expanded(',
            'child: Container',
          ],
          baseXP: 70,
          explanation: '''
Expanded makes a widget fill available space:

• Only works inside Row or Column
• Takes up remaining space
• flex property for proportional sizing

Common pattern: Fixed + Expanded + Fixed
''',
          hints: [
            'Wrap the widget with Expanded',
            'Expanded is only for Row/Column children',
            '''Row(
  children: [
    Expanded(
      child: Container(),
    ),
  ],
)''',
          ],
          lessonContent: LessonContent(
            title: 'Expanded Widget',
            description: 'Use Expanded to fill available space',
            conceptExplanation: '''Expanded is a powerful layout widget that makes a child of a Row, Column, or Flex expand to fill the available space.

Key features:
• Must be a direct child of Row, Column, or Flex
• Expands to fill remaining space
• Can use flex property for proportional sizing
• Perfect for responsive designs

Common pattern: Fixed widget + Expanded widget + Fixed widget

For example: Icon (50px) + Expanded Text + Button (100px) = Perfectly responsive layout!''',
            analogy: 'Expanded is like a rubber band - it stretches to fill whatever space is available, making your layout adapt to different screen sizes.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Row(
        children: [
          Container(width: 50, color: Colors.red),
          Expanded(
            child: Container(color: Colors.blue),
          ),
          Container(width: 50, color: Colors.green),
        ],
      ),
    ),
  ));
}''',
            keyPoints: [
              'Expanded fills available space in Row/Column',
              'Must be direct child of Row, Column, or Flex',
              'flex property controls proportional sizing',
              'Perfect for responsive layouts',
              'Common pattern: fixed + expanded + fixed',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Using the Expanded Widget',
            introduction: 'Let\'s learn how to make widgets fill available space with Expanded.',
            summary: 'Amazing! You can now create responsive layouts with Expanded.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Wrap with Expanded',
                description: 'Wrap a Container with Expanded.',
                codeSnippet: 'Expanded(\n  child: Container(color: Colors.blue),\n)',
                highlights: ['Expanded wraps the widget', 'Widget now fills available space'],
                explanation: 'The Container now expands to fill the remaining space!',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Use in Row',
                description: 'Place Expanded inside a Row with fixed widgets.',
                codeSnippet: 'Row(\n  children: [\n    Container(width: 50),\n    Expanded(child: Container()),\n    Container(width: 50),\n  ],\n)',
                highlights: ['Fixed widgets keep their size', 'Expanded fills the rest'],
                explanation: 'This creates a responsive layout that adapts to screen size!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w2-l5',
          worldId: 'world_2',
          levelNumber: 5,
          title: 'Padding Widget',
          concept: 'Padding',
          learningObjective: 'Add spacing around widgets with Padding',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Add 16 pixels of padding around a Text widget',
          expectedCode: '''Padding(
  padding: EdgeInsets.all(16.0),
  child: Text("Padded text"),
)''',
          validationRules: [
            'Padding(',
            'padding: EdgeInsets.all',
          ],
          baseXP: 60,
          explanation: '''
Padding adds space around a widget:

• EdgeInsets.all() - Same padding on all sides
• EdgeInsets.symmetric() - Vertical/horizontal
• EdgeInsets.only() - Specific sides
• EdgeInsets.fromLTRB() - Left, top, right, bottom

Padding makes your UI more readable and professional!
''',
          hints: [
            'Use Padding widget',
            'EdgeInsets.all(16.0) for uniform padding',
            '''Padding(
  padding: EdgeInsets.all(16.0),
  child: Text('Padded text'),
)''',
          ],
          lessonContent: LessonContent(
            title: 'Padding Widget',
            description: 'Add spacing around widgets with Padding',
            conceptExplanation: '''Padding adds space around a widget, creating breathing room and preventing widgets from touching edges or each other.

EdgeInsets options:
• EdgeInsets.all(value) - Same padding on all sides
• EdgeInsets.symmetric(horizontal: h, vertical: v) - Different horizontal and vertical
• EdgeInsets.only(left: l, top: t, right: r, bottom: b) - Specific sides
• EdgeInsets.fromLTRB(left, top, right, bottom) - All four sides explicitly

Common values: 8, 16, 24, 32 (multiples of 8)

Good padding makes your UI look professional and improves readability.''',
            analogy: 'Padding is like the margins around text on a page - it creates space that makes content easier to read and more pleasant to look at.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Padded text'),
      ),
    ),
  ));
}''',
            keyPoints: [
              'Padding adds space around widgets',
              'EdgeInsets.all() adds same padding on all sides',
              'EdgeInsets.symmetric() for different horizontal/vertical',
              'Common values are multiples of 8',
              'Makes UI more professional and readable',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Adding Padding to Widgets',
            introduction: 'Let\'s learn how to add space around widgets using Padding.',
            summary: 'Great! You now know how to create professional spacing with Padding.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Wrap with Padding',
                description: 'Wrap a Text widget with Padding.',
                codeSnippet: 'Padding(\n  child: Text(\'Padded text\'),\n)',
                highlights: ['Padding wraps other widgets', 'Creates space around the child'],
                explanation: 'The Padding widget will add space around your Text.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add EdgeInsets',
                description: 'Use EdgeInsets.all() to add uniform padding.',
                codeSnippet: 'Padding(\n  padding: EdgeInsets.all(16.0),\n  child: Text(\'Padded text\'),\n)',
                highlights: ['EdgeInsets.all() adds same padding everywhere', '16.0 is a common padding value'],
                explanation: 'Now your text has 16 pixels of space on all sides!',
              ),
            ],
          ),
        ),
      ],
      requiredStars: 2,
      isLocked: true,
    );
  }

  // WORLD 3: UI & Styling
  static World _getWorld3() {
    return World(
      id: 'world_3',
      title: 'UI & Styling',
      description: 'Create beautiful UIs with colors, decorations, and icons',
      icon: '🎨',
      levels: [
        Level(
          id: 'w3-l1',
          worldId: 'world_3',
          levelNumber: 1,
          title: 'Container Basics',
          concept: 'Container Widget',
          learningObjective: 'Use Container for styling and layout',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Create a Container with width 100, height 100, and blue color',
          expectedCode: '''Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)''',
          validationRules: [
            'Container(',
            'width: 100',
            'height: 100',
            'color: Colors.blue',
          ],
          baseXP: 60,
          explanation: '''
Container is the Swiss Army knife of Flutter widgets:

• width, height - Size
• color - Background color
• padding, margin - Spacing
• child - Widget inside
• decoration - Advanced styling

Most versatile widget in Flutter!
''',
          hints: [
            'Container can have width, height, and color',
            'Use Colors.blue for the color',
            '''Container(
  width: 200,
  height: 100,
  color: Colors.blue,
)''',
          ],
          lessonContent: LessonContent(
            title: 'Container Basics',
            description: 'Master the versatile Container widget for styling',
            conceptExplanation: '''Container is one of the most versatile and powerful widgets in Flutter. It combines painting, positioning, and sizing into one convenient package.

Key capabilities:
• Set width, height, and constraints
• Add color or complex decorations
• Apply padding and margin for spacing
• Align child widgets
• Transform and position content

Container is often called the "Swiss Army knife" of Flutter widgets because it handles so many layout and styling tasks. You'll use it constantly to create colored boxes, add spacing, size widgets, and apply visual effects.''',
            analogy: 'Container is like a cardboard box - you can paint it, put things inside with padding, place it with margins, and give it rounded corners.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Text('Box', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ),
  ));
}''',
            keyPoints: [
              'Container is the most versatile styling widget',
              'Can set fixed dimensions with width and height',
              'color property sets the background color',
              'Combine multiple properties for complex layouts',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Creating Styled Containers',
            introduction: 'Let\'s create a Container with custom dimensions and color.',
            summary: 'Excellent! You now know how to create styled containers.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Create Container',
                description: 'Start with a Container widget.',
                codeSnippet: 'Container(\n  \n)',
                highlights: ['Container is a box widget', 'Can have many styling properties'],
                explanation: 'Container is the starting point for styled widgets.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Set dimensions and color',
                description: 'Add width, height, and color properties.',
                codeSnippet: 'Container(\n  width: 100,\n  height: 100,\n  color: Colors.blue,\n)',
                highlights: ['width and height set the size', 'color sets the background'],
                explanation: 'Now you have a 100x100 blue box!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w3-l2',
          worldId: 'world_3',
          levelNumber: 2,
          title: 'BoxDecoration',
          concept: 'BoxDecoration',
          learningObjective: 'Use BoxDecoration for advanced styling',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.medium,
          challengeDescription: 'Add BoxDecoration with a gradient to the Container',
          expectedCode: '''Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
)''',
          validationRules: [
            'decoration: BoxDecoration(',
            'gradient: LinearGradient',
          ],
          baseXP: 75,
          explanation: '''
BoxDecoration provides advanced styling:

• color - Background color (can't use with gradient)
• gradient - Color gradients
• borderRadius - Rounded corners
• boxShadow - Shadows
• border - Border styling

Note: Use decoration OR color, not both!
''',
          commonMistakes: [
            'Using both color and decoration',
            'Forgetting to use BoxDecoration',
          ],
          hints: [
            'Use the decoration property',
            'LinearGradient creates a gradient',
            '''Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
)''',
          ],
          lessonContent: LessonContent(
            title: 'BoxDecoration',
            description: 'Add advanced styling with gradients and shadows',
            conceptExplanation: '''BoxDecoration is a powerful styling class that gives you advanced visual effects for Container widgets. While Container's color property is simple, BoxDecoration unlocks professional styling capabilities.

What BoxDecoration provides:
• Gradients (linear, radial, sweep)
• Borders with custom colors and widths
• Border radius (rounded corners)
• Box shadows for depth effects
• Background images

Important: You CANNOT use both color and decoration properties on the same Container. If you need a simple color, use color. If you need advanced effects, use decoration with BoxDecoration.''',
            analogy: 'BoxDecoration is like the paint, shadow, and finishing touches you apply to make a simple box look beautiful and professional.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  ));
}''',
            keyPoints: [
              'BoxDecoration provides advanced styling',
              'Cannot use both color and decoration on same Container',
              'Supports gradients, shadows, borders, and rounded corners',
              'Essential for professional-looking UI elements',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Using BoxDecoration',
            introduction: 'Let\'s learn how to use BoxDecoration for advanced styling.',
            summary: 'Great! You can now create beautifully styled containers.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Add decoration property',
                description: 'Use decoration instead of color for advanced styling.',
                codeSnippet: 'Container(\n  decoration: BoxDecoration(),\n)',
                highlights: ['decoration replaces color', 'BoxDecoration enables advanced effects'],
                explanation: 'BoxDecoration unlocks professional styling options.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add gradient',
                description: 'Use LinearGradient to create a color gradient.',
                codeSnippet: 'Container(\n  decoration: BoxDecoration(\n    gradient: LinearGradient(\n      colors: [Colors.blue, Colors.purple],\n    ),\n  ),\n)',
                highlights: ['LinearGradient creates smooth color transitions', 'colors array defines the gradient'],
                explanation: 'Now your container has a beautiful blue-to-purple gradient!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w3-l3',
          worldId: 'world_3',
          levelNumber: 3,
          title: 'BorderRadius',
          concept: 'Rounded Corners',
          learningObjective: 'Create rounded corners with BorderRadius',
          challengeType: ChallengeType.buildFromScratch,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Create a Container with rounded corners (radius: 20)',
          expectedCode: '''Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20),
  ),
)''',
          validationRules: [
            'borderRadius: BorderRadius.circular(20)',
          ],
          baseXP: 60,
          explanation: '''
BorderRadius creates rounded corners:

• BorderRadius.circular() - All corners same
• BorderRadius.only() - Specific corners
• Value in pixels (logical pixels)

Rounded corners make modern, polished UIs!
''',
          hints: [
            'Use BorderRadius.circular()',
            'Put it inside BoxDecoration',
            '''Container(
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(20),
  ),
)''',
          ],
          lessonContent: LessonContent(
            title: 'BorderRadius',
            description: 'Create rounded corners for modern UI',
            conceptExplanation: '''BorderRadius gives your widgets rounded corners instead of sharp edges. Rounded corners are a hallmark of modern UI design and make interfaces feel friendlier and more polished.

Why rounded corners matter:
• Make UI elements look modern and friendly
• Reduce visual harshness of sharp edges
• Follow Material Design guidelines
• Create buttons and cards that feel inviting

BorderRadius options:
• BorderRadius.circular(value) - All corners rounded equally
• BorderRadius.only() - Specific corners rounded
• Common values: 8, 12, 16, 20 pixels

Consistent border radius throughout your app creates visual harmony.''',
            analogy: 'BorderRadius is like sanding the sharp corners off a wooden box - it makes everything look and feel better.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ),
  ));
}''',
            keyPoints: [
              'BorderRadius creates rounded corners',
              'Must be used inside BoxDecoration',
              'BorderRadius.circular() rounds all corners equally',
              'Common values: 8, 12, 16, 20 pixels',
              'Essential for modern UI design',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Creating Rounded Corners',
            introduction: 'Let\'s learn how to add rounded corners to containers.',
            summary: 'Perfect! You now know how to create modern rounded corners.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Use BoxDecoration',
                description: 'BorderRadius must be inside BoxDecoration.',
                codeSnippet: 'Container(\n  decoration: BoxDecoration(\n    color: Colors.blue,\n  ),\n)',
                highlights: ['decoration property required', 'BoxDecoration enables borderRadius'],
                explanation: 'BoxDecoration is needed for rounded corners.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Add BorderRadius',
                description: 'Use BorderRadius.circular() to round all corners.',
                codeSnippet: 'Container(\n  decoration: BoxDecoration(\n    color: Colors.blue,\n    borderRadius: BorderRadius.circular(20),\n  ),\n)',
                highlights: ['borderRadius property rounds corners', 'circular(20) creates 20-pixel rounded corners'],
                explanation: 'Now your container has smooth, modern rounded corners!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w3-l4',
          worldId: 'world_3',
          levelNumber: 4,
          title: 'Text Styling',
          concept: 'TextStyle',
          learningObjective: 'Style text with TextStyle',
          challengeType: ChallengeType.fixBrokenUI,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Make the text bold with font size 24',
          expectedCode: '''Text(
  "Styled Text",
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)''',
          validationRules: [
            'style: TextStyle(',
            'fontSize: 24',
            'fontWeight: FontWeight.bold',
          ],
          baseXP: 50,
          explanation: '''
TextStyle controls text appearance:

• fontSize - Size in logical pixels
• fontWeight - Bold, normal, etc.
• color - Text color
• fontFamily - Custom fonts
• letterSpacing - Space between letters

Good typography improves readability!
''',
          hints: [
            'Use the style property on Text',
            'FontWeight.bold makes text bold',
            '''Text(
  'Styled Text',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  ),
)''',
          ],
          lessonContent: LessonContent(
            title: 'Text Styling',
            description: 'Customize text appearance with TextStyle',
            conceptExplanation: '''TextStyle is how you customize the appearance of text in Flutter. Every Text widget can have a style property that controls its look, from color and size to font weight and decoration.

TextStyle properties:
• fontSize - Size of the text (default is 14)
• fontWeight - Bold, normal, light
• color - Text color
• fontStyle - Italic or normal
• letterSpacing - Space between letters

Common font sizes:
• 12-14: Small text, captions
• 16-18: Body text
• 20-24: Subheadings
• 28-32: Main headings

Consistent text styling creates visual hierarchy and improves readability.''',
            analogy: 'TextStyle is like the formatting toolbar in a word processor - it controls how your text looks on screen.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text(
          'Styled Text',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    ),
  ));
}''',
            keyPoints: [
              'TextStyle customizes text appearance',
              'fontSize controls the size',
              'fontWeight makes text bold',
              'color property changes text color',
              'Use on Text widget\'s style property',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Styling Text',
            introduction: 'Let\'s learn how to style text with TextStyle.',
            summary: 'Excellent! You can now create beautifully styled text.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Add style property',
                description: 'Text widget accepts a style property.',
                codeSnippet: 'Text(\n  \'Styled Text\',\n  style: TextStyle(),\n)',
                highlights: ['style property takes TextStyle', 'TextStyle controls appearance'],
                explanation: 'TextStyle object defines how text looks.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Set fontSize and fontWeight',
                description: 'Add fontSize and fontWeight properties.',
                codeSnippet: 'Text(\n  \'Styled Text\',\n  style: TextStyle(\n    fontSize: 24,\n    fontWeight: FontWeight.bold,\n  ),\n)',
                highlights: ['fontSize sets the size', 'FontWeight.bold makes it bold'],
                explanation: 'Now your text is large and bold!',
              ),
            ],
          ),
        ),
        Level(
          id: 'w3-l5',
          worldId: 'world_3',
          levelNumber: 5,
          title: 'FloatingActionButton',
          concept: 'FloatingActionButton',
          learningObjective: 'Add a floating action button to Scaffold',
          challengeType: ChallengeType.multipleChoice,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Which Scaffold property adds a circular floating button?',
          expectedCode: '''Scaffold(
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)''',
          validationRules: [
            'Must use floatingActionButton property',
            'Must create FloatingActionButton',
          ],
          baseXP: 60,
          explanation: '''
FloatingActionButton (FAB):

• Circular button that floats above content
• onPressed - Function when tapped
• child - Usually an Icon
• backgroundColor - Custom color

Common for primary actions like "Add" or "Create"
''',
          hints: [
            'Property name: floatingActionButton',
            'It goes in the Scaffold',
            '''Scaffold(
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
)''',
          ],
          lessonContent: LessonContent(
            title: 'FloatingActionButton',
            description: 'Add a primary action button to your screen',
            conceptExplanation: '''FloatingActionButton (FAB) is a circular button that "floats" above your app\'s content. It\'s the primary action button in Material Design, typically used for the most important action on a screen.

Key features:
• Circular shape by default
• Floats above content with elevation/shadow
• Positioned in bottom-right by default
• Contains an icon (usually an action icon)
• onPressed callback for handling taps

Common use cases:
• "Add" or "Create" actions (Icons.add)
• "Edit" actions (Icons.edit)
• "Send" or "Submit" (Icons.send)

Best practice: Only use one FAB per screen for the PRIMARY action only.''',
            analogy: 'FloatingActionButton is like the big red "easy button" - it should be the most obvious action your users can take.',
            codeExample: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('FAB Demo'),
      ),
      body: Center(
        child: Text('Tap the button!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ),
  ));
}''',
            keyPoints: [
              'FloatingActionButton creates a circular floating button',
              'Added to Scaffold using floatingActionButton property',
              'Requires onPressed callback',
              'child property usually contains an Icon',
              'Use for the primary action on a screen',
            ],
          ),
          guidedExample: GuidedExample(
            title: 'Adding FloatingActionButton',
            introduction: 'Let\'s add a floating action button to Scaffold.',
            summary: 'Perfect! You now know how to add primary action buttons.',
            steps: [
              GuidedStep(
                stepNumber: 1,
                title: 'Add floatingActionButton',
                description: 'Scaffold has a floatingActionButton property.',
                codeSnippet: 'Scaffold(\n  appBar: AppBar(...),\n  body: Center(...),\n  floatingActionButton: ,\n)',
                highlights: ['floatingActionButton property in Scaffold', 'Dedicated slot for the FAB'],
                explanation: 'Scaffold provides a special property for the FAB.',
              ),
              GuidedStep(
                stepNumber: 2,
                title: 'Create FloatingActionButton',
                description: 'Add FloatingActionButton with onPressed and child.',
                codeSnippet: 'floatingActionButton: FloatingActionButton(\n  onPressed: () {},\n  child: Icon(Icons.add),\n)',
                highlights: ['onPressed handles taps', 'child shows the icon'],
                explanation: 'Now you have a floating action button with an add icon!',
              ),
            ],
          ),
        ),
      ],
      requiredStars: 2,
      isLocked: true,
    );
  }
}
