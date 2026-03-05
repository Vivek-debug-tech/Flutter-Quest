import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';

/// Sample data for World 1 Level 1: Hello Flutter
/// Demonstrates the flexible, scalable data structure
class SampleLevelData {
  static LevelModel getWorld1Level1() {
    return LevelModel(
      // Basic Info
      id: 'w1_l1',
      worldId: 'world_1',
      levelNumber: 1,
      title: 'Hello Flutter',
      concept: 'main() and runApp()',
      
      // Lesson Content
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
      
      // Challenge Steps
      challengeSteps: [
        // Step 1: Multiple Choice - Understanding main()
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
            OptionModel(
              id: 'opt4',
              text: 'It\'s optional and can be skipped',
              isCorrect: false,
              explanation: 'Wrong! Every Flutter app must have a main() function.',
            ),
          ],
          xpReward: 20,
          hints: [
            'Think about what happens first when you launch an app',
            'What does "entry point" mean in programming?',
          ],
          explanation: 'The main() function is the entry point - the very first code that runs when your app starts. Without it, Flutter wouldn\'t know where to begin!',
        ),
        
        // Step 2: Fill in the Blank - runApp()
        ChallengeStep(
          id: 'w1_l1_c2',
          stepNumber: 2,
          type: ChallengeType.fillInBlank,
          question: 'Complete the code: void main() { _____(MyApp()); }',
          description: 'Fill in the function name that launches a Flutter app.',
          blankPlaceholder: '_____',
          correctAnswer: 'runApp',
          xpReward: 15,
          hints: [
            'This function "runs" your app',
            'It starts with "run"',
          ],
          explanation: 'runApp() is the Flutter function that takes your root widget and launches the app. It must be called from main().',
          validationRules: [
            'Answer must be exactly "runApp"',
            'Case sensitive',
          ],
        ),
        
        // Step 3: Multiple Choice - Widget Understanding
        ChallengeStep(
          id: 'w1_l1_c3',
          stepNumber: 3,
          type: ChallengeType.multipleChoice,
          question: 'What does runApp() take as a parameter?',
          description: 'Understanding what runApp() expects.',
          options: [
            OptionModel(
              id: 'opt1',
              text: 'A Widget',
              isCorrect: true,
              explanation: 'Exactly! runApp() takes a widget that becomes your app\'s root.',
            ),
            OptionModel(
              id: 'opt2',
              text: 'A String',
              isCorrect: false,
              explanation: 'No, it needs a widget, not text.',
            ),
            OptionModel(
              id: 'opt3',
              text: 'A Number',
              isCorrect: false,
              explanation: 'Incorrect. runApp() needs a widget to display.',
            ),
            OptionModel(
              id: 'opt4',
              text: 'Nothing - it has no parameters',
              isCorrect: false,
              explanation: 'Wrong! runApp() must receive a widget to launch.',
            ),
          ],
          xpReward: 20,
          hints: [
            'Flutter apps are built with UI components',
            'These UI components have a special name...',
          ],
          explanation: 'runApp() takes a Widget as its parameter. This widget becomes the root of your entire app\'s widget tree.',
        ),
        
        // Step 4: Fix the Bug
        ChallengeStep(
          id: 'w1_l1_c4',
          stepNumber: 4,
          type: ChallengeType.fixTheBug,
          question: 'Fix the broken code to make a working Flutter app',
          description: 'The code below has an error. Can you spot and fix it?',
          brokenCode: '''void main() {
  MyApp();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Hello'),
    );
  }
}''',
          fixedCode: '''void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Text('Hello'),
    );
  }
}''',
          bugHint: 'The app is created but never launched!',
          xpReward: 25,
          hints: [
            'Look at the main() function carefully',
            'MyApp() is created but what launches it?',
            'You need to call a function that starts the app',
          ],
          explanation: 'The bug was missing runApp()! Creating MyApp() alone doesn\'t launch it. You must call runApp(MyApp()) to actually start your Flutter app.',
          validationRules: [
            'Must include runApp()',
            'Must pass MyApp() to runApp()',
          ],
        ),
      ],
      
      // Metadata
      difficulty: DifficultyLevel.beginner,
      baseXP: 50,
      bonusXP: 30, // For perfect completion (no hints used)
      
      // Learning Aids
      hints: [
        'Every Flutter app follows the same pattern: main() calls runApp()',
        'Think of main() as the starting gun and runApp() as the race beginning',
        'Try running the code example in your IDE to see how it works',
      ],
      
      explanation: '''
Congratulations! You've learned the foundation of every Flutter app.

**Key Pattern:**
```
void main() => runApp(MyApp());
```

This simple pattern is how EVERY Flutter app starts - from simple hello world apps to complex applications with thousands of features.

**What Happens:**
1. Dart runtime calls main()
2. main() calls runApp()
3. runApp() inflates your widget tree
4. Flutter renders your UI on screen

**Next Steps:**
Now that you understand how apps start, you'll learn about different types of widgets and how to build more complex UIs!
''',
      
      commonMistakes: [
        'Forgetting to call runApp() in main()',
        'Trying to call runApp() outside of main()',
        'Not passing a widget to runApp()',
        'Creating a widget but not using runApp() to display it',
      ],
      
      prerequisites: null, // First level, no prerequisites
      
      relatedConcepts: [
        'StatelessWidget vs StatefulWidget',
        'Widget Tree',
        'MaterialApp',
        'Build Method',
      ],
      
      // Game Mechanics
      isLocked: false, // First level is unlocked
      requiredStars: null,
      timeEstimate: Duration(minutes: 10),
    );
  }
}
