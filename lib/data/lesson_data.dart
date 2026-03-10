import '../models/lesson.dart';

/// Flutter Basics Lessons - Complete data-driven lesson content
/// This file contains all lesson data in a simple, maintainable format
final List<Lesson> flutterBasicsLessons = [
  // ============================================
  // LESSON 1: Hello Flutter
  // ============================================
  Lesson(
    id: 1,
    title: 'Hello Flutter',
    subtitle: 'Learn the basics of Flutter app structure',
    conceptExplanation: '''Flutter apps always start with a main() function - just like many programming languages. This is the entry point where your app begins execution.

Inside main(), we call runApp() which takes a Widget and makes it the root of your app. The widget you pass to runApp() becomes the foundation of your entire app's widget tree.

**Why is this important?**
• main() is required - without it, your app won't run
• runApp() initializes the Flutter framework
• The widget passed to runApp() becomes your app's root
• This pattern is used in every single Flutter app

Think of main() as turning on a television, and runApp() as selecting which channel (your app) to display.''',
    exampleCode: '''void main() {
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
    challengeQuestion: 'Write a Flutter app that starts with main() and calls runApp() to display MyApp()',
    starterCode: '''// Write your code here
// Remember: Every Flutter app needs a main() function

''',
    correctCode: '''void main() {
  runApp(MyApp());
}''',
    hints: [
      'Every Flutter app needs a main() function to start execution',
      'You should call runApp() inside main() to launch the widget tree',
      '''void main() {
  runApp(MyApp());
}''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'main() is the entry point of every Flutter app',
      'runApp() launches your app and displays the first widget',
      'The widget tree starts from the widget passed to runApp()',
      'MaterialApp provides Material Design styling',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create the main() function',
        explanation: 'Every Flutter app starts with main(). This is where Flutter knows to begin executing your code.',
        code: 'void main() {\n  \n}',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Call runApp()',
        explanation: 'Inside main(), we call runApp() to start the Flutter framework and display our app.',
        code: 'void main() {\n  runApp();\n}',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Pass a Widget',
        explanation: 'runApp() needs a widget to display. We pass MyApp() which becomes the root of our widget tree.',
        code: 'void main() {\n  runApp(MyApp());\n}',
      ),
    ],
  ),

  // ============================================
  // LESSON 2: Scaffold Basics
  // ============================================
  Lesson(
    id: 2,
    title: 'Scaffold Basics',
    subtitle: 'Learn the foundation of Flutter screen layouts',
    conceptExplanation: '''Scaffold is one of the most important widgets in Flutter. It provides a basic visual structure for your app, including an AppBar, body, floating action buttons, and more.

Think of Scaffold as the skeleton or framework of a house - it provides the structure that everything else is built upon.

**Why use Scaffold?**
• Provides consistent Material Design layout
• Includes built-in slots for AppBar, body, drawer, bottom navigation, etc.
• Handles responsive behavior automatically
• Makes your app look professional with minimal code

Almost every screen in a Flutter app uses Scaffold as its foundation.''',
    exampleCode: '''import 'package:flutter/material.dart';

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
    challengeQuestion: 'Create a Scaffold with an AppBar titled "Welcome" and a body containing centered text "Learning Flutter"',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      // Add AppBar here
      
      // Add body here
      
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text('Learning Flutter'),
      ),
    ),
  ));
}''',
    hints: [
      'Scaffold has two main properties: appBar and body',
      'AppBar needs a title property with a Text widget',
      '''Scaffold(
  appBar: AppBar(
    title: Text('Welcome'),
  ),
  body: Center(
    child: Text('Learning Flutter'),
  ),
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'Scaffold provides the basic Material Design structure',
      'AppBar goes at the top of the screen',
      'body contains the main content',
      'Scaffold is used in nearly every Flutter screen',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Start with Scaffold',
        explanation: 'Scaffold is a container widget that provides the basic structure for a screen.',
        code: 'home: Scaffold(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add an AppBar',
        explanation: 'The appBar property adds a title bar at the top of your screen.',
        code: 'home: Scaffold(\n  appBar: AppBar(\n    title: Text(\'Welcome\'),\n  ),\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add a Body',
        explanation: 'The body property contains the main content. We use Center to center our text.',
        code: 'Scaffold(\n  appBar: AppBar(\n    title: Text(\'Welcome\'),\n  ),\n  body: Center(\n    child: Text(\'Learning Flutter\'),\n  ),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 3: StatelessWidget
  // ============================================
  Lesson(
    id: 3,
    title: 'StatelessWidget',
    subtitle: 'Create reusable, immutable widgets',
    conceptExplanation: '''StatelessWidget is a widget that doesn't change over time. Once it's built, its properties remain constant. This makes it perfect for static UI elements like logos, labels, or layouts that don't need to update.

**Key Characteristics:**
• Immutable - properties cannot change after creation
• Lightweight - no state management overhead
• Reusable - can be used multiple times throughout your app
• Efficient - Flutter can optimize rendering since it never changes

**When to use StatelessWidget:**
• Static text, images, or icons
• Layouts that don't change
• Reusable UI components without interactive behavior

Think of it like a printed page in a book - once printed, the text doesn't change.''',
    exampleCode: '''import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: Text(
          'Welcome to Flutter!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}''',
    challengeQuestion: 'Create a StatelessWidget called MyWidget that returns a Container with a centered Text saying "Hello World"',
    starterCode: '''import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Return your widget here
    
  }
}''',
    correctCode: '''import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello World'),
      ),
    );
  }
}''',
    hints: [
      'A StatelessWidget must extend StatelessWidget and override the build method',
      'The build method returns a Widget - you can return Container with a child',
      '''class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello World'),
      ),
    );
  }
}''',
    ],
    difficulty: 'Medium',
    xp: 75,
    keyPoints: [
      'StatelessWidget is for widgets that don\'t change',
      'Must override the build() method',
      'build() returns the widget tree',
      'Perfect for static UI components',
      'More efficient than StatefulWidget for unchanging content',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create the class',
        explanation: 'Define a class that extends StatelessWidget. This tells Flutter that your widget won\'t change.',
        code: 'class MyWidget extends StatelessWidget {\n  \n}',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Override build method',
        explanation: 'The build method is required. It tells Flutter what to display.',
        code: 'class MyWidget extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    \n  }\n}',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Return a widget',
        explanation: 'build() must return a widget. We return a Container with centered text.',
        code: 'class MyWidget extends StatelessWidget {\n  @override\n  Widget build(BuildContext context) {\n    return Container(\n      child: Center(\n        child: Text(\'Hello World\'),\n      ),\n    );\n  }\n}',
      ),
    ],
  ),

  // ============================================
  // LESSON 4: AppBar Styling
  // ============================================
  Lesson(
    id: 4,
    title: 'AppBar Styling',
    subtitle: 'Customize your app\'s top bar appearance',
    conceptExplanation: '''AppBar is the top navigation bar in your app. It can contain a title, actions, icons, and can be customized with colors and styles.

**Common AppBar Properties:**
• title - The main heading text
• backgroundColor - Changes the AppBar color
• actions - Buttons or icons on the right side
• leading - Widget on the left (usually a back button)
• elevation - Shadow depth effect

A well-styled AppBar makes your app look professional and provides clear navigation.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Styled AppBar'),
        backgroundColor: Colors.purple,
        elevation: 4.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('Beautiful AppBar!'),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Create an AppBar with title "My App", purple background color, and center the title',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        // Add title here
        // Add backgroundColor here
        // Add centerTitle here
      ),
      body: Center(
        child: Text('Content'),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: Text('Content'),
      ),
    ),
  ));
}''',
    hints: [
      'AppBar has title, backgroundColor, and centerTitle properties',
      'Use Colors.purple for the background color',
      '''AppBar(
  title: Text('My App'),
  backgroundColor: Colors.purple,
  centerTitle: true,
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'AppBar provides the top navigation bar',
      'title property sets the heading text',
      'backgroundColor changes the AppBar color',
      'centerTitle centers the title text',
      'Common colors: Colors.purple, Colors.blue, Colors.green, etc.',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Add title',
        explanation: 'The title property displays the main heading of your screen.',
        code: 'AppBar(\n  title: Text(\'My App\'),\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Set background color',
        explanation: 'backgroundColor changes the color of the AppBar. Use Colors.purple for a purple theme.',
        code: 'AppBar(\n  title: Text(\'My App\'),\n  backgroundColor: Colors.purple,\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Center the title',
        explanation: 'centerTitle: true centers the title text instead of left-aligning it.',
        code: 'AppBar(\n  title: Text(\'My App\'),\n  backgroundColor: Colors.purple,\n  centerTitle: true,\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 5: Center Widget
  // ============================================
  Lesson(
    id: 5,
    title: 'Center Widget',
    subtitle: 'Learn to position widgets in the center',
    conceptExplanation: '''The Center widget is one of the simplest and most useful layout widgets in Flutter. It takes its child widget and positions it in the exact center of the available space.

**How Center Works:**
• Takes a single child widget
• Centers it horizontally and vertically
• Expands to fill available space
• Simple but powerful for basic layouts

**When to use Center:**
• Displaying text in the middle of the screen
• Showing loading spinners
• Creating centered buttons or images
• Quick prototyping and testing

Think of Center as a spotlight that highlights your widget right in the middle of the stage.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Center Widget'),
      ),
      body: Center(
        child: Text(
          'I am centered!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Use the Center widget to display "Flutter is Fun!" in the center of the screen',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: // Add Center widget here with Text as child
      
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Flutter is Fun!'),
      ),
    ),
  ));
}''',
    hints: [
      'Center widget takes a child property',
      'The child can be any widget, like Text',
      '''Center(
  child: Text('Flutter is Fun!'),
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'Center widget positions its child in the exact center',
      'Works both horizontally and vertically',
      'Takes only one child widget',
      'Very useful for simple layouts',
      'Expands to fill available space',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create Center widget',
        explanation: 'Center is a layout widget that centers its child.',
        code: 'body: Center(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add child',
        explanation: 'Center needs a child widget to display. We\'ll use Text.',
        code: 'body: Center(\n  child: Text(\'Flutter is Fun!\'),\n)',
      ),
    ],
  ),

  // ============================================
  // WORLD 2: LAYOUT MASTERY
  // ============================================

  // ============================================
  // LESSON 6: Row Widget
  // ============================================
  Lesson(
    id: 6,
    title: 'Row Widget',
    subtitle: 'Arrange widgets horizontally',
    conceptExplanation: '''The Row widget is a fundamental layout widget in Flutter that arranges its children horizontally (left to right). It's perfect for creating horizontal lists, tool bars, or placing items side-by-side.

**Key Characteristics of Row:**
• Arranges children horizontally
• Takes multiple children (not just one)
• Grows horizontally to fit children
• Can align children with mainAxisAlignment and crossAxisAlignment

**When to use Row:**
• Displaying icons or buttons side-by-side
• Creating horizontal navigation bars
• Showing items in a horizontal list
• Building multi-column layouts

Think of Row like arranging books on a shelf - they line up horizontally from left to right.

**mainAxisAlignment options:**
• start - align to the left (default)
• center - center horizontally
• end - align to the right
• spaceBetween - space items evenly with space between
• spaceAround - space items evenly with space around
• spaceEvenly - equal space between and around items''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Row Widget'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star, size: 50, color: Colors.amber),
            Icon(Icons.favorite, size: 50, color: Colors.red),
            Icon(Icons.thumb_up, size: 50, color: Colors.blue),
          ],
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Fix the layout so the icons appear horizontally instead of vertically',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Fix Layout'),
      ),
      body: Center(
        child: Column(
          children: [
            Icon(Icons.star),
            Icon(Icons.home),
          ],
        ),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Fix Layout'),
      ),
      body: Center(
        child: Row(
          children: [
            Icon(Icons.star),
            Icon(Icons.home),
          ],
        ),
      ),
    ),
  ));
}''',
    hints: [
      'To arrange widgets horizontally, use Row instead of Column',
      'Row takes a children property (plural) which accepts a list of widgets',
      '''Row(
  children: [
    Icon(Icons.star),
    Icon(Icons.home),
  ],
)''',
    ],
    difficulty: 'Easy',
    xp: 70,
    keyPoints: [
      'Row arranges children horizontally from left to right',
      'Takes multiple children using the children property',
      'Use mainAxisAlignment to control horizontal spacing',
      'Use crossAxisAlignment to control vertical alignment',
      'Row is the horizontal counterpart to Column',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create Row widget',
        explanation: 'Row is a layout widget that arranges its children horizontally.',
        code: 'Row(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add children list',
        explanation: 'Row takes a children property (plural) which is a list of widgets.',
        code: 'Row(\n  children: [\n    \n  ],\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add widgets to children',
        explanation: 'Place your widgets inside the children list. They will display horizontally.',
        code: 'Row(\n  children: [\n    Icon(Icons.star),\n    Icon(Icons.home),\n  ],\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 7: Column Widget
  // ============================================
  Lesson(
    id: 7,
    title: 'Column Widget',
    subtitle: 'Stack widgets vertically',
    conceptExplanation: '''The Column widget arranges its children vertically (top to bottom). It's one of the most commonly used layout widgets in Flutter, perfect for creating forms, lists, or stacking content.

**Key Characteristics of Column:**
• Arranges children vertically
• Takes multiple children (not just one)
• Grows vertically to fit children
• Can align children with mainAxisAlignment and crossAxisAlignment

**When to use Column:**
• Creating forms with multiple input fields
• Stacking text, images, and buttons vertically
• Building lists of items
• Organizing content from top to bottom

Think of Column like stacking books on top of each other - they arrange vertically from top to bottom.

**mainAxisAlignment options:**
• start - align to the top (default)
• center - center vertically
• end - align to the bottom
• spaceBetween - space items evenly with space between
• spaceAround - space items evenly with space around
• spaceEvenly - equal space between and around items

**crossAxisAlignment options:**
• start - align to the left
• center - center horizontally
• end - align to the right
• stretch - stretch to fill width''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Column Widget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('First Item', style: TextStyle(fontSize: 24)),
            Text('Second Item', style: TextStyle(fontSize: 24)),
            Text('Third Item', style: TextStyle(fontSize: 24)),
            ElevatedButton(
              onPressed: () {},
              child: Text('Click Me'),
            ),
          ],
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Create a Column that displays three Text widgets vertically: "Welcome", "to", "Flutter"',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Column Practice'),
      ),
      body: Center(
        child: // Add Column widget here with 3 Text children
        
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Column Practice'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome'),
            Text('to'),
            Text('Flutter'),
          ],
        ),
      ),
    ),
  ));
}''',
    hints: [
      'Column arranges widgets vertically using the children property',
      'children is a list that can contain multiple Text widgets',
      '''Column(
  children: [
    Text('Welcome'),
    Text('to'),
    Text('Flutter'),
  ],
)''',
    ],
    difficulty: 'Easy',
    xp: 70,
    keyPoints: [
      'Column arranges children vertically from top to bottom',
      'Takes multiple children using the children property',
      'Use mainAxisAlignment to control vertical spacing',
      'Use crossAxisAlignment to control horizontal alignment',
      'Column is the vertical counterpart to Row',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create Column widget',
        explanation: 'Column is a layout widget that stacks its children vertically.',
        code: 'Column(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add children list',
        explanation: 'Column takes a children property which is a list of widgets.',
        code: 'Column(\n  children: [\n    \n  ],\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add Text widgets',
        explanation: 'Place three Text widgets inside the children list. They will stack vertically.',
        code: 'Column(\n  children: [\n    Text(\'Welcome\'),\n    Text(\'to\'),\n    Text(\'Flutter\'),\n  ],\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 8: Expanded Widget
  // ============================================
  Lesson(
    id: 8,
    title: 'Expanded Widget',
    subtitle: 'Make widgets fill available space',
    conceptExplanation: '''The Expanded widget is a powerful layout tool that makes a child of a Row, Column, or Flex expand to fill the available space. It's essential for creating responsive layouts that adapt to different screen sizes.

**How Expanded Works:**
• Must be a direct child of Row, Column, or Flex
• Expands to fill remaining space
• Can use flex property to control proportional sizing
• Perfect for responsive designs

**The flex property:**
By default, flex is 1. If you have multiple Expanded widgets:
• flex: 1 - Takes 1 part of space
• flex: 2 - Takes 2 parts of space (twice as much)
• flex: 3 - Takes 3 parts of space (three times as much)

**When to use Expanded:**
• Making buttons fill available width
• Creating proportional layouts
• Building responsive grid-like structures
• Ensuring widgets adapt to different screen sizes

Think of Expanded like elastic bands - they stretch to fill whatever space is available.

**Common Pattern:**
Using Expanded in a Row or Column creates flexible, responsive layouts that look good on any screen size.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Expanded Widget'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: Center(child: Text('Flex 1', style: TextStyle(fontSize: 24))),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue,
              child: Center(child: Text('Flex 2', style: TextStyle(fontSize: 24))),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: Center(child: Text('Flex 1', style: TextStyle(fontSize: 24))),
            ),
          ),
        ],
      ),
    ),
  ));
}''',
    challengeQuestion: 'Wrap the Container in an Expanded widget so it fills all available vertical space in the Column',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Expanded Practice'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('Fill Me!', style: TextStyle(fontSize: 24)),
            ),
          ),
        ],
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Expanded Practice'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text('Fill Me!', style: TextStyle(fontSize: 24)),
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}''',
    hints: [
      'Expanded widget wraps around another widget and makes it fill available space',
      'Expanded must be a direct child of Row, Column, or Flex',
      '''Expanded(
  child: Container(
    color: Colors.blue,
    child: Center(
      child: Text('Fill Me!', style: TextStyle(fontSize: 24)),
    ),
  ),
)''',
    ],
    difficulty: 'Medium',
    xp: 80,
    keyPoints: [
      'Expanded makes its child fill available space',
      'Must be a direct child of Row, Column, or Flex',
      'Use flex property to control proportional sizing',
      'Perfect for responsive layouts',
      'Multiple Expanded widgets share space based on flex values',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Wrap with Expanded',
        explanation: 'Expanded is a wrapper widget that makes its child expand to fill space.',
        code: 'Expanded(\n  child: Container(...),\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Understand the behavior',
        explanation: 'The Container now fills all available vertical space in the Column.',
        code: 'Column(\n  children: [\n    Expanded(\n      child: Container(\n        color: Colors.blue,\n        child: Center(\n          child: Text(\'Fill Me!\'),\n        ),\n      ),\n    ),\n  ],\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Optional: Add flex',
        explanation: 'You can add flex property to control how much space it takes compared to other Expanded widgets.',
        code: 'Expanded(\n  flex: 2,\n  child: Container(...),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 9: Padding Widget
  // ============================================
  Lesson(
    id: 9,
    title: 'Padding Widget',
    subtitle: 'Add space around widgets',
    conceptExplanation: '''The Padding widget adds space around its child widget. It's essential for creating visual breathing room and preventing widgets from touching screen edges or each other.

**Why use Padding:**
• Creates visual breathing room
• Prevents widgets from touching edges
• Improves readability and aesthetics
• Makes your UI look professional

**EdgeInsets options:**
• EdgeInsets.all(value) - Same padding on all sides
• EdgeInsets.symmetric(horizontal: h, vertical: v) - Different horizontal and vertical
• EdgeInsets.only(left: l, top: t, right: r, bottom: b) - Specific sides
• EdgeInsets.fromLTRB(left, top, right, bottom) - All four sides explicitly

**Common values:**
• 8.0 - Small padding
• 16.0 - Medium padding (most common)
• 24.0 - Large padding
• 32.0 - Extra large padding

Think of Padding like the margins around text on a page - it creates space that makes content easier to read and more pleasant to look at.

**Pro Tip:**
Good padding is usually consistent throughout your app. Flutter's Material Design recommends multiples of 8 (8, 16, 24, 32, etc.).''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Padding Widget'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('With Padding', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('This text has nice spacing around it, making it easier to read and more visually appealing.'),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              color: Colors.blue,
              child: Text('Button with Custom Padding', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Add Padding of 20.0 on all sides around the Text widget',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Padding Practice'),
      ),
      body: // Add Padding widget here
        Text(
          'Add padding around me!',
          style: TextStyle(fontSize: 20),
        ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Padding Practice'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Add padding around me!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  ));
}''',
    hints: [
      'Padding widget wraps around another widget and adds space using the padding property',
      'Use EdgeInsets.all(20.0) to add 20 pixels of padding on all sides',
      '''Padding(
  padding: EdgeInsets.all(20.0),
  child: Text(
    'Add padding around me!',
    style: TextStyle(fontSize: 20),
  ),
)''',
    ],
    difficulty: 'Easy',
    xp: 70,
    keyPoints: [
      'Padding adds space around its child widget',
      'EdgeInsets.all(value) adds same padding on all sides',
      'EdgeInsets.symmetric allows different horizontal and vertical padding',
      'EdgeInsets.only allows padding on specific sides',
      'Common padding values: 8, 16, 24, 32 (multiples of 8)',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Wrap with Padding',
        explanation: 'Padding is a wrapper widget that adds space around its child.',
        code: 'Padding(\n  child: Text(...),\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add padding property',
        explanation: 'The padding property uses EdgeInsets to specify how much space to add.',
        code: 'Padding(\n  padding: EdgeInsets.all(20.0),\n  child: Text(...),\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Complete widget',
        explanation: 'Now your Text widget has 20 pixels of space on all sides.',
        code: 'Padding(\n  padding: EdgeInsets.all(20.0),\n  child: Text(\n    \'Add padding around me!\',\n    style: TextStyle(fontSize: 20),\n  ),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 10: Container Layout
  // ============================================
  Lesson(
    id: 10,
    title: 'Container Layout',
    subtitle: 'Master the versatile Container widget',
    conceptExplanation: '''Container is one of the most versatile and commonly used widgets in Flutter. It combines common painting, positioning, and sizing widgets into one convenient package.

**Container can:**
• Add padding, margins, and borders
• Set width, height, and constraints
• Apply colors and decorations
• Align child widgets
• Transform and position children

**Common Container Properties:**
• padding - Space inside the container
• margin - Space outside the container
• color - Background color
• width / height - Fixed dimensions
• decoration - Borders, gradients, shadows, rounded corners
• alignment - Position child (Alignment.center, etc.)
• child - The widget inside

**When to use Container:**
• Creating colored boxes
• Adding spacing with padding/margin
• Creating cards with decorations
• Sizing widgets precisely
• Combining multiple layout properties

Think of Container like a cardboard box - you can paint it, put things inside with padding, place it with margins, give it rounded corners, and much more.

**Pro Tip:**
Container is often called a "convenience widget" because it combines many other widgets (Padding, DecoratedBox, ConstrainedBox, etc.) into one.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container Widget'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Styled Container',
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Create a Container with width 150, height 150, blue color, and centered Text saying "Box"',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container Practice'),
      ),
      body: Center(
        child: // Create Container here
        
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container Practice'),
      ),
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: Center(
            child: Text('Box'),
          ),
        ),
      ),
    ),
  ));
}''',
    hints: [
      'Container is a versatile widget that can have width, height, color, and a child',
      'Set width: 150, height: 150, color: Colors.blue, and add a child with Text',
      '''Container(
  width: 150,
  height: 150,
  color: Colors.blue,
  child: Center(
    child: Text('Box'),
  ),
)''',
    ],
    difficulty: 'Easy',
    xp: 70,
    keyPoints: [
      'Container is a versatile widget combining many layout features',
      'Can set width, height, color, padding, margin, and more',
      'decoration property allows borders, gradients, and shadows',
      'alignment property positions the child inside',
      'One of the most commonly used widgets in Flutter',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create Container',
        explanation: 'Container is a box that can hold other widgets and has many styling options.',
        code: 'Container(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Set dimensions and color',
        explanation: 'Add width, height, and color properties to create a visible box.',
        code: 'Container(\n  width: 150,\n  height: 150,\n  color: Colors.blue,\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add child widget',
        explanation: 'Add a child with centered Text to display content inside the Container.',
        code: 'Container(\n  width: 150,\n  height: 150,\n  color: Colors.blue,\n  child: Center(\n    child: Text(\'Box\'),\n  ),\n)',
      ),
    ],
  ),

  // ============================================
  // WORLD 3: UI STYLING
  // ============================================

  // ============================================
  // LESSON 11: Container Basics
  // ============================================
  Lesson(
    id: 11,
    title: 'Container Basics',
    subtitle: 'Master the versatile Container widget for styling',
    conceptExplanation: '''Container is one of the most versatile and powerful widgets in Flutter. It combines common painting, positioning, and sizing functionality into one convenient package.

**What Container Can Do:**
• Set width, height, and constraints
• Add color or complex decorations (gradients, borders, shadows)
• Apply padding (space inside) and margin (space outside)
• Align child widgets
• Transform and position content

**Why Container is Essential:**
Container is often called Flutter's "Swiss Army knife" because it can handle so many layout and styling tasks. You'll use it constantly to create colored boxes, add spacing, size widgets, and apply visual effects.

**Common Use Cases:**
• Creating colored backgrounds
• Adding spacing around widgets
• Sizing widgets to specific dimensions
• Combining multiple styling properties in one widget

Think of Container as a cardboard box - you can paint it, put things inside with padding, place it with margins, and give it rounded corners.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Container Demo'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Styled Box',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Create a Container with width 100, height 100, and blue color',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: ___,
          height: ___,
          color: ___,
        ),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 100,
          height: 100,
          color: Colors.blue,
        ),
      ),
    ),
  ));
}''',
    hints: [
      'Container is a widget that can have width, height, and color properties',
      'Set width: 100, height: 100, and use Colors.blue for the color',
      '''Container(
  width: 100,
  height: 100,
  color: Colors.blue,
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'Container is the most versatile styling widget in Flutter',
      'Can set fixed dimensions with width and height properties',
      'color property sets the background color',
      'Combine multiple properties for complex layouts',
      'Most commonly used widget for basic styling',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Create Container widget',
        explanation: 'Container is a box widget that can have many styling properties.',
        code: 'Container(\n  \n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Set dimensions',
        explanation: 'Add width and height to give the Container a specific size.',
        code: 'Container(\n  width: 100,\n  height: 100,\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add color',
        explanation: 'Use the color property to set the background. Colors.blue is a predefined color.',
        code: 'Container(\n  width: 100,\n  height: 100,\n  color: Colors.blue,\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 12: BoxDecoration
  // ============================================
  Lesson(
    id: 12,
    title: 'BoxDecoration',
    subtitle: 'Add advanced styling with gradients and shadows',
    conceptExplanation: '''BoxDecoration is a powerful styling class that gives you advanced visual effects for Container widgets. While Container's color property is simple, BoxDecoration unlocks professional styling capabilities.

**What BoxDecoration Provides:**
• Gradients (linear, radial, sweep)
• Borders with custom colors and widths
• Border radius (rounded corners)
• Box shadows for depth effects
• Background images
• Custom shapes

**Important Rule:**
You CANNOT use both color and decoration properties on the same Container. If you need a simple color, use color. If you need advanced effects, use decoration with BoxDecoration.

**Why Use BoxDecoration:**
BoxDecoration transforms basic boxes into professional UI elements. Shadows add depth, gradients create visual interest, and rounded corners make interfaces feel modern and polished.

**Professional Tip:**
BoxDecoration is the secret to making your Flutter apps look professional. Material Design heavily uses shadows and rounded corners, both provided by BoxDecoration.

Think of BoxDecoration as the paint, shadow, and finishing touches you apply to make a simple box look beautiful.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('BoxDecoration Demo'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Beautiful Box',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Replace the color property with a BoxDecoration that has a blue color',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,  // Replace this with decoration
        ),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
      ),
    ),
  ));
}''',
    hints: [
      'BoxDecoration is used with the decoration property of Container, not the color property',
      'Create a BoxDecoration with a color property inside',
      '''decoration: BoxDecoration(
  color: Colors.blue,
)''',
    ],
    difficulty: 'Medium',
    xp: 75,
    keyPoints: [
      'BoxDecoration provides advanced styling for Containers',
      'Cannot use both color and decoration on the same Container',
      'Supports gradients, shadows, borders, and rounded corners',
      'BoxDecoration goes inside the decoration property',
      'Essential for professional-looking UI elements',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Remove color property',
        explanation: 'Container cannot have both color and decoration. Remove the color property.',
        code: 'Container(\n  width: 150,\n  height: 150,\n  // color removed\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add decoration property',
        explanation: 'Add the decoration property to Container.',
        code: 'Container(\n  width: 150,\n  height: 150,\n  decoration: BoxDecoration(),\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Set color in BoxDecoration',
        explanation: 'Add the color inside BoxDecoration instead of directly on Container.',
        code: 'Container(\n  width: 150,\n  height: 150,\n  decoration: BoxDecoration(\n    color: Colors.blue,\n  ),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 13: BorderRadius
  // ============================================
  Lesson(
    id: 13,
    title: 'BorderRadius',
    subtitle: 'Create rounded corners for modern UI',
    conceptExplanation: '''BorderRadius gives your widgets rounded corners instead of sharp edges. Rounded corners are a hallmark of modern UI design and make interfaces feel friendlier and more polished.

**Why Rounded Corners Matter:**
• Make UI elements look modern and friendly
• Reduce visual harshness of sharp edges
• Follow Material Design and iOS design guidelines
• Create buttons, cards, and containers that feel inviting

**BorderRadius Options:**
• BorderRadius.circular(value) - All corners rounded equally
• BorderRadius.only() - Specific corners rounded
• BorderRadius.horizontal() - Left/right sides rounded
• BorderRadius.vertical() - Top/bottom sides rounded

**Common Values:**
• 4-8 pixels - Subtle rounding
• 12-16 pixels - Standard rounding (most common)
• 20+ pixels - Prominent rounding
• 50+ pixels - Pill-shaped buttons

**Design Tip:**
Consistent border radius throughout your app creates visual harmony. Pick 2-3 values (e.g., 8, 16, 24) and use them everywhere.

Think of BorderRadius like sanding the sharp corners off a wooden box - it makes everything look and feel better.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('BorderRadius Demo'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'Rounded Box',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Add BorderRadius.circular(12) to make the blue container have rounded corners',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: ______
          ),
        ),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    ),
  ));
}''',
    hints: [
      'BorderRadius must be used inside BoxDecoration, not directly on Container',
      'BorderRadius.circular(value) creates evenly rounded corners',
      '''decoration: BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.circular(12),
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'BorderRadius creates rounded corners on containers',
      'Must be used inside BoxDecoration',
      'BorderRadius.circular() rounds all corners equally',
      'Common values: 8, 12, 16, 20 pixels',
      'Essential for modern, professional UI design',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Understand BorderRadius placement',
        explanation: 'BorderRadius goes inside BoxDecoration, not on Container directly.',
        code: 'decoration: BoxDecoration(\n  color: Colors.blue,\n  // borderRadius goes here\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Add borderRadius property',
        explanation: 'Add the borderRadius property to BoxDecoration.',
        code: 'decoration: BoxDecoration(\n  color: Colors.blue,\n  borderRadius: ,\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Use BorderRadius.circular()',
        explanation: 'BorderRadius.circular(12) creates 12-pixel rounded corners on all sides.',
        code: 'decoration: BoxDecoration(\n  color: Colors.blue,\n  borderRadius: BorderRadius.circular(12),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 14: Text Styling
  // ============================================
  Lesson(
    id: 14,
    title: 'Text Styling',
    subtitle: 'Customize text appearance with TextStyle',
    conceptExplanation: '''TextStyle is how you customize the appearance of text in Flutter. Every Text widget can have a style property that controls its look, from color and size to font weight and decoration.

**TextStyle Properties:**
• fontSize - Size of the text (default is 14)
• fontWeight - Bold, normal, light (FontWeight.bold, etc.)
• color - Text color
• fontStyle - Italic or normal
• letterSpacing - Space between letters
• height - Line height multiplier
• decoration - Underline, overline, line-through

**Common Font Sizes:**
• 12-14: Small text, captions
• 16-18: Body text (most content)
• 20-24: Subheadings
• 28-32: Main headings
• 36+: Large display text

**Font Weights:**
• FontWeight.normal (w400) - Regular text
• FontWeight.bold (w700) - Bold text
• FontWeight.w500 - Medium weight
• FontWeight.w300 - Light weight

**Design Best Practice:**
Consistent text styling creates visual hierarchy. Use 2-3 font sizes and 2 font weights throughout your app for a professional look.

Think of TextStyle as the formatting toolbar in a word processor - it controls how your text looks on screen.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Text Styling Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Large Bold Text',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Italic Red Text',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    ),
  ));
}''',
    challengeQuestion: 'Add a TextStyle to make the text size 24, bold, and blue',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: Text(
          'Styled Text',
          style: // Add TextStyle here
        ),
      ),
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

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
    hints: [
      'Text widget has a style property that takes a TextStyle object',
      'TextStyle can have fontSize, fontWeight, and color properties',
      '''style: TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.blue,
)''',
    ],
    difficulty: 'Easy',
    xp: 50,
    keyPoints: [
      'TextStyle customizes text appearance',
      'fontSize controls the size (common: 16-24 for body text)',
      'fontWeight makes text bold (FontWeight.bold)',
      'color property changes text color',
      'Every Text widget can have a style property',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Add style property',
        explanation: 'Text widget accepts a style property that takes a TextStyle.',
        code: 'Text(\n  \'Styled Text\',\n  style: TextStyle(),\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Set fontSize',
        explanation: 'Add fontSize: 24 to make the text larger.',
        code: 'Text(\n  \'Styled Text\',\n  style: TextStyle(\n    fontSize: 24,\n  ),\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add fontWeight and color',
        explanation: 'Add FontWeight.bold and Colors.blue to complete the styling.',
        code: 'Text(\n  \'Styled Text\',\n  style: TextStyle(\n    fontSize: 24,\n    fontWeight: FontWeight.bold,\n    color: Colors.blue,\n  ),\n)',
      ),
    ],
  ),

  // ============================================
  // LESSON 15: FloatingActionButton
  // ============================================
  Lesson(
    id: 15,
    title: 'FloatingActionButton',
    subtitle: 'Add a primary action button to your screen',
    conceptExplanation: '''FloatingActionButton (FAB) is a circular button that "floats" above your app's content. It's the primary action button in Material Design, typically used for the most important action on a screen.

**What is FloatingActionButton:**
The FAB is that circular button you see in many apps (like the "+" in Gmail to compose new email, or the "edit" pencil in notes apps). It's always accessible and highlights the main action users should take.

**Key Features:**
• Circular shape by default
• Floats above content with elevation/shadow
• Positioned in bottom-right by default
• Contains an icon (usually an action icon)
• onPressed callback for handling taps

**Common Use Cases:**
• "Add" or "Create" actions (Icons.add)
• "Edit" actions (Icons.edit)
• "Send" or "Submit" (Icons.send)
• "Camera" or "Photo" (Icons.camera)

**Best Practices:**
• Only use one FAB per screen
• Use for the PRIMARY action only
• Choose clear, recognizable icons
• Make sure the action is obvious

**Scaffold Integration:**
Scaffold has a dedicated floatingActionButton property, making it easy to add. The Scaffold handles positioning and ensures it doesn't overlap critical content.

Think of FloatingActionButton as the big red "easy button" - it should be the most obvious action your users can take.''',
    exampleCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('FAB Demo'),
      ),
      body: Center(
        child: Text('Tap the button below!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FAB pressed!');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    ),
  ));
}''',
    challengeQuestion: 'Add a FloatingActionButton with an add icon (+) to the Scaffold',
    starterCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Add a FAB!'),
      ),
      // Add floatingActionButton here
    ),
  ));
}''',
    correctCode: '''import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Center(
        child: Text('Add a FAB!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    ),
  ));
}''',
    hints: [
      'Scaffold has a floatingActionButton property for the FAB',
      'FloatingActionButton needs onPressed callback and child (usually an Icon)',
      '''floatingActionButton: FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)''',
    ],
    difficulty: 'Easy',
    xp: 60,
    keyPoints: [
      'FloatingActionButton creates a circular floating button',
      'Added to Scaffold using floatingActionButton property',
      'Requires onPressed callback to handle taps',
      'child property usually contains an Icon',
      'Use for the primary action on a screen',
    ],
    guidedSteps: [
      GuidedStepData(
        stepNumber: 1,
        title: 'Add floatingActionButton to Scaffold',
        explanation: 'Scaffold has a dedicated property for the floating action button.',
        code: 'Scaffold(\n  appBar: AppBar(...),\n  body: Center(...),\n  floatingActionButton: ,\n)',
      ),
      GuidedStepData(
        stepNumber: 2,
        title: 'Create FloatingActionButton',
        explanation: 'Create the FloatingActionButton widget with required properties.',
        code: 'floatingActionButton: FloatingActionButton(\n  onPressed: () {},\n)',
      ),
      GuidedStepData(
        stepNumber: 3,
        title: 'Add Icon child',
        explanation: 'Add an Icon as the child. Icons.add is perfect for create/add actions.',
        code: 'floatingActionButton: FloatingActionButton(\n  onPressed: () {},\n  child: Icon(Icons.add),\n)',
      ),
    ],
  ),
];
