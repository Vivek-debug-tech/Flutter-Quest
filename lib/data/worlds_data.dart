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
          challengeType: ChallengeType.multipleChoice,
          difficulty: DifficultyLevel.easy,
          challengeDescription: 'Every Flutter app starts with a main() function. Which function launches the app?',
          expectedCode: '''void main() {
  runApp(MyApp());
}''',
          validationRules: [
            'Must have main() function',
            'Must call runApp()',
          ],
          baseXP: 50,
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
            'runApp() is the function that starts your app',
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
            'Must use Scaffold',
            'Must include AppBar',
            'AppBar must have title',
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
          ],
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
            'Must extend StatelessWidget',
            'Must override build method',
            'Must return a widget',
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
          ],
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
            'Must have backgroundColor property',
            'Must use Colors.blue',
          ],
          baseXP: 50,
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
          ],
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
          baseXP: 50,
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
          ],
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
            'Must use Column',
            'Must have children property',
            'Must have multiple widgets',
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
          ],
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
            'Must use Row',
            'Must have children property',
            'Must use Icon widgets',
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
          ],
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
          baseXP: 50,
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
          ],
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
            'Must use Expanded',
            'Expanded must wrap the Container',
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
          ],
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
            'Must use Padding widget',
            'Must use EdgeInsets',
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
          ],
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
            'Must use Container',
            'Must have width and height',
            'Must have color',
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
          ],
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
            'Must use BoxDecoration',
            'Must have gradient',
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
          ],
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
            'Must use BorderRadius',
            'Must use circular with value 20',
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
          ],
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
            'Must use TextStyle',
            'Must have fontSize 24',
            'Must use FontWeight.bold',
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
          ],
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
          baseXP: 50,
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
          ],
        ),
      ],
      requiredStars: 2,
      isLocked: true,
    );
  }
}
