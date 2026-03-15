import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World flutterBasicsWorld = buildCurriculumWorld(
  id: 'world_1',
  title: 'Flutter Basics',
  description: 'Learn the fundamental widgets and app structure of Flutter.',
  icon: 'B',
  requiredStars: 0,
  isLocked: false,
  levels: [
    buildCurriculumLevel(
      id: 'w1-l1',
      worldId: 'world_1',
      levelNumber: 1,
      title: 'Text Widget',
      concept: 'Text widget',
      lessonText:
          'The Text widget displays readable content on screen. In Flutter, even simple words and labels are widgets, and Text is often the first widget you learn because it shows visible output immediately.',
      guidedText:
          'Start with Text( and pass a quoted string as the first argument. Strings in Flutter code should be wrapped in matching single or double quotes.',
      challengePrompt:
          'Display the text "Hello Flutter" using the Text widget.',
      expectedCode: "Text('Hello Flutter')",
      validationRules: ['Text(', 'Hello Flutter'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget displays plain text on screen?',
          options: ['Container', 'Text', 'Row', 'Center'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Display the text "Hello Flutter" using the Text widget.',
          validationRules: ['Text(', 'Hello Flutter'],
          codeSnippet: "Text('Hello Flutter')",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the missing quotes in this Text widget.',
          brokenCode: 'Text(Hello Flutter)',
          fixRules: ['Text(', "'Hello Flutter'"],
          codeSnippet: "Text('Hello Flutter')",
        ),
      ],
      keyPoints: [
        'Text displays a string on screen.',
        'Strings must be wrapped in quotes.',
        'Text is one of the most common Flutter widgets.',
      ],
      hints: [
        'Use the widget that displays words on the screen.',
        'Start with Text( and place the words in quotes.',
        "Text('Hello Flutter')",
      ],
    ),
    buildCurriculumLevel(
      id: 'w1-l2',
      worldId: 'world_1',
      levelNumber: 2,
      title: 'Container Widget',
      concept: 'Container widget',
      lessonText:
          'Container is a flexible box widget used for layout and styling. It can hold one child and is commonly used to add spacing, size, background color, and decoration around that child.',
      guidedText:
          'Start with Container(, then use the child: property to place one widget inside it. Container uses child, not children.',
      challengePrompt:
          'Create a Container with a Text child that says "Inside Container".',
      expectedCode: "Container(\n  child: Text('Inside Container'),\n)",
      validationRules: ['Container(', 'child:', 'Inside Container'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which property does Container use for a single nested widget?',
          options: ['body', 'children', 'child', 'item'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt:
              'Create a Container with a Text child that says "Inside Container".',
          validationRules: ['Container(', 'child:', 'Inside Container'],
          codeSnippet: "Container(\n  child: Text('Inside Container'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the incorrect property inside this Container.',
          brokenCode: "Container(\n  children: Text('Inside Container'),\n)",
          fixRules: ['Container(', 'child:', 'Inside Container'],
          codeSnippet: "Container(\n  child: Text('Inside Container'),\n)",
        ),
      ],
      keyPoints: [
        'Container can wrap and style one child widget.',
        'Use child: for a single inner widget.',
        'Container is often used for layout and decoration.',
      ],
      hints: [
        'Use a box-style widget that supports a single child.',
        'Remember that Container uses child: not children:.',
        "Container(\n  child: Text('Inside Container'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w1-l3',
      worldId: 'world_1',
      levelNumber: 3,
      title: 'Scaffold Widget',
      concept: 'Scaffold layout',
      lessonText:
          'Scaffold provides the main structure of a Material Design screen. It gives your page standard sections like appBar, body, floatingActionButton, drawer, and more.',
      guidedText:
          'Use Scaffold when building a full screen. Put the main visible content inside the body property.',
      challengePrompt:
          'Create a Scaffold with a body that shows "Welcome" using Text.',
      expectedCode: "Scaffold(\n  body: Text('Welcome'),\n)",
      validationRules: ['Scaffold(', 'body:', 'Welcome'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which Scaffold property holds the main visible content?',
          options: ['title', 'body', 'child', 'screen'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Scaffold with a body that shows "Welcome" using Text.',
          validationRules: ['Scaffold(', 'body:', 'Welcome'],
          codeSnippet: "Scaffold(\n  body: Text('Welcome'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text would this body display?',
          codeSnippet: "Scaffold(\n  body: Text('Welcome'),\n)",
          expectedOutput: 'Welcome',
        ),
      ],
      keyPoints: [
        'Scaffold is the standard page structure widget.',
        'body is where main screen content goes.',
        'Most Flutter app screens use Scaffold.',
      ],
      hints: [
        'Use the widget that gives a page its main structure.',
        'Place the Text widget inside the body: property.',
        "Scaffold(\n  body: Text('Welcome'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w1-l4',
      worldId: 'world_1',
      levelNumber: 4,
      title: 'Row Layout',
      concept: 'Row widget',
      lessonText:
          'Row arranges multiple widgets horizontally. When you want items to appear side by side, Row is usually the right layout widget.',
      guidedText:
          'Use Row(children: [...]) and place each child widget inside the list. Row uses children because it supports multiple widgets.',
      challengePrompt:
          'Create a Row with two Text widgets: "One" and "Two".',
      expectedCode:
          "Row(\n  children: [\n    Text('One'),\n    Text('Two'),\n  ],\n)",
      validationRules: ['Row(', 'children:', 'One', 'Two'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget arranges children horizontally?',
          options: ['Column', 'Row', 'Stack', 'Center'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Row with two Text widgets: "One" and "Two".',
          validationRules: ['Row(', 'children:', 'One', 'Two'],
          codeSnippet:
              "Row(\n  children: [\n    Text('One'),\n    Text('Two'),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the Row so it uses a proper children list.',
          brokenCode: "Row(\n  children: Text('One'),\n)",
          fixRules: ['Row(', 'children:', '[', 'One', 'Two'],
          codeSnippet:
              "Row(\n  children: [\n    Text('One'),\n    Text('Two'),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'Row places children horizontally.',
        'Use children: with a list of widgets.',
        'Each child appears side by side.',
      ],
      hints: [
        'Use the horizontal layout widget.',
        'Row needs children: followed by a list.',
        "Row(\n  children: [\n    Text('One'),\n    Text('Two'),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w1-l5',
      worldId: 'world_1',
      levelNumber: 5,
      title: 'Column Layout',
      concept: 'Column widget',
      lessonText:
          'Column arranges multiple widgets vertically. It is one of the most common layout widgets when you want content stacked from top to bottom.',
      guidedText:
          'Use Column(children: [...]) and place each child in the list. Like Row, Column uses children: because it supports multiple widgets.',
      challengePrompt:
          'Create a Column with two Text widgets: "Top" and "Bottom".',
      expectedCode:
          "Column(\n  children: [\n    Text('Top'),\n    Text('Bottom'),\n  ],\n)",
      validationRules: ['Column(', 'children:', 'Top', 'Bottom'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget stacks children vertically?',
          options: ['Column', 'Row', 'Stack', 'Container'],
          correctIndex: 0,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Column with two Text widgets: "Top" and "Bottom".',
          validationRules: ['Column(', 'children:', 'Top', 'Bottom'],
          codeSnippet:
              "Column(\n  children: [\n    Text('Top'),\n    Text('Bottom'),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What is the first visible word in this Column?',
          codeSnippet:
              "Column(\n  children: [\n    Text('Top'),\n    Text('Bottom'),\n  ],\n)",
          expectedOutput: 'Top',
        ),
      ],
      keyPoints: [
        'Column stacks widgets vertically.',
        'Use children: with a list.',
        'Widgets appear from top to bottom.',
      ],
      hints: [
        'Use the vertical layout widget.',
        'Column also needs children: followed by a list.',
        "Column(\n  children: [\n    Text('Top'),\n    Text('Bottom'),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w1-l6',
      worldId: 'world_1',
      levelNumber: 6,
      title: 'Center Widget',
      concept: 'Center widget',
      lessonText:
          'Center positions one child in the middle of the available space. It is a simple layout widget that helps content feel balanced on the screen.',
      guidedText:
          'Use Center(child: ...) when you want a single widget placed in the middle. Center takes child:, not children:.',
      challengePrompt:
          'Center the text "Centered Text" on screen.',
      expectedCode: "Center(\n  child: Text('Centered Text'),\n)",
      validationRules: ['Center(', 'child:', 'Centered Text'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget puts one child in the middle of the available space?',
          options: ['Center', 'Align', 'Padding', 'Row'],
          correctIndex: 0,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Center the text "Centered Text" on screen.',
          validationRules: ['Center(', 'child:', 'Centered Text'],
          codeSnippet: "Center(\n  child: Text('Centered Text'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the Center widget to use the correct property.',
          brokenCode: "Center(\n  children: Text('Centered Text'),\n)",
          fixRules: ['Center(', 'child:', 'Centered Text'],
          codeSnippet: "Center(\n  child: Text('Centered Text'),\n)",
        ),
      ],
      keyPoints: [
        'Center places one child in the middle.',
        'Use child: for the inner widget.',
        'Center is useful for simple balanced layouts.',
      ],
      hints: [
        'Use the widget that positions one child in the middle.',
        'Center only supports a single child: property.',
        "Center(\n  child: Text('Centered Text'),\n)",
      ],
    ),
  ],
);
