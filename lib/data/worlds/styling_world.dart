import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World stylingWorld = buildCurriculumWorld(
  id: 'world_3',
  title: 'Styling',
  description: 'Style text, boxes, icons, and decorations in Flutter.',
  icon: 'S',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w3-l1',
      worldId: 'world_3',
      levelNumber: 1,
      title: 'Colors',
      concept: 'Color property',
      lessonText:
          'Flutter uses the Colors class to apply predefined colors to widgets. Color is one of the fastest ways to make your UI feel lively and easy to understand.',
      guidedText:
          'Pick a widget that supports color and set it to a predefined value such as Colors.blue.',
      challengePrompt: 'Create a Container with a blue background.',
      expectedCode: "Container(\n  color: Colors.blue,\n)",
      validationRules: ['Container(', 'color:', 'Colors.blue'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which class provides predefined Flutter colors?',
          options: ['Styles', 'Theme', 'Colors', 'Paint'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Container with a blue background.',
          validationRules: ['Container(', 'color:', 'Colors.blue'],
          codeSnippet: "Container(\n  color: Colors.blue,\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the color value so the Container is blue.',
          brokenCode: "Container(\n  color: blue,\n)",
          fixRules: ['Container(', 'color:', 'Colors.blue'],
          codeSnippet: "Container(\n  color: Colors.blue,\n)",
        ),
      ],
      keyPoints: [
        'Colors.blue is a predefined Flutter color.',
        'Many widgets expose a color property.',
        'Color helps communicate emphasis and mood.',
      ],
      hints: [
        'Use the widget that can show a colored box.',
        'Set color: to Colors.blue.',
        "Container(\n  color: Colors.blue,\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w3-l2',
      worldId: 'world_3',
      levelNumber: 2,
      title: 'TextStyle',
      concept: 'TextStyle class',
      lessonText:
          'TextStyle customizes how text looks, including size, color, font weight, spacing, and more. It is the main styling tool for text in Flutter.',
      guidedText:
          'Use the style: property on Text and pass a TextStyle object with the visual changes you want.',
      challengePrompt: 'Make a Text widget bold with font size 20.',
      expectedCode:
          "Text(\n  'Styled',\n  style: TextStyle(\n    fontSize: 20,\n    fontWeight: FontWeight.bold,\n  ),\n)",
      validationRules: ['Text(', 'TextStyle(', 'fontSize:', 'FontWeight.bold'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which class styles the appearance of text in Flutter?',
          options: ['BoxDecoration', 'TextTheme', 'TextStyle', 'FontWeight'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Make a Text widget bold with font size 20.',
          validationRules: ['Text(', 'TextStyle(', 'fontSize:', 'FontWeight.bold'],
          codeSnippet:
              "Text(\n  'Styled',\n  style: TextStyle(\n    fontSize: 20,\n    fontWeight: FontWeight.bold,\n  ),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What word is displayed by this Text widget?',
          codeSnippet:
              "Text(\n  'Styled',\n  style: TextStyle(\n    fontSize: 20,\n    fontWeight: FontWeight.bold,\n  ),\n)",
          expectedOutput: 'Styled',
        ),
      ],
      keyPoints: [
        'TextStyle controls text appearance.',
        'fontSize changes text size.',
        'FontWeight.bold makes text bold.',
      ],
      hints: [
        'Use style: on the Text widget.',
        'Create a TextStyle with fontSize and fontWeight.',
        "Text(\n  'Styled',\n  style: TextStyle(\n    fontSize: 20,\n    fontWeight: FontWeight.bold,\n  ),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w3-l3',
      worldId: 'world_3',
      levelNumber: 3,
      title: 'BoxDecoration',
      concept: 'BoxDecoration',
      lessonText:
          'BoxDecoration is used with Container.decoration to create richer visuals such as background colors, borders, gradients, shadows, and rounded corners.',
      guidedText:
          'When a Container needs advanced visual styling, put that styling inside a BoxDecoration object assigned to decoration:.',
      challengePrompt:
          'Add a BoxDecoration with a green color to a Container.',
      expectedCode:
          "Container(\n  decoration: BoxDecoration(\n    color: Colors.green,\n  ),\n)",
      validationRules: [
        'Container(',
        'decoration:',
        'BoxDecoration(',
        'Colors.green',
      ],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which object is used for advanced Container styling?',
          options: ['TextStyle', 'BoxDecoration', 'BorderSide', 'ThemeData'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Add a BoxDecoration with a green color to a Container.',
          validationRules: [
            'Container(',
            'decoration:',
            'BoxDecoration(',
            'Colors.green',
          ],
          codeSnippet:
              "Container(\n  decoration: BoxDecoration(\n    color: Colors.green,\n  ),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the property so the decoration is applied correctly.',
          brokenCode:
              "Container(\n  decorate: BoxDecoration(\n    color: Colors.green,\n  ),\n)",
          fixRules: [
            'Container(',
            'decoration:',
            'BoxDecoration(',
            'Colors.green',
          ],
          codeSnippet:
              "Container(\n  decoration: BoxDecoration(\n    color: Colors.green,\n  ),\n)",
        ),
      ],
      keyPoints: [
        'BoxDecoration enables advanced visual styling.',
        'It is assigned through Container.decoration.',
        'Use decoration instead of plain color when styles get richer.',
      ],
      hints: [
        'Use decoration: instead of only color: on Container.',
        'Wrap the color inside BoxDecoration(',
        "Container(\n  decoration: BoxDecoration(\n    color: Colors.green,\n  ),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w3-l4',
      worldId: 'world_3',
      levelNumber: 4,
      title: 'BorderRadius',
      concept: 'Rounded corners',
      lessonText:
          'BorderRadius rounds the corners of decorated boxes and is commonly used to make cards, buttons, and containers look softer and more modern.',
      guidedText:
          'Place BorderRadius.circular(...) inside BoxDecoration to round the corners of a decorated Container.',
      challengePrompt: 'Create a Container with border radius 12.',
      expectedCode:
          "Container(\n  decoration: BoxDecoration(\n    borderRadius: BorderRadius.circular(12),\n  ),\n)",
      validationRules: [
        'Container(',
        'BoxDecoration(',
        'BorderRadius.circular(12)',
      ],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which method creates evenly rounded corners of radius 12?',
          options: [
            'BorderRadius.all(12)',
            'BorderRadius.circular(12)',
            'Radius.circular(12)',
            'BoxRadius.circular(12)',
          ],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Container with border radius 12.',
          validationRules: [
            'Container(',
            'BoxDecoration(',
            'BorderRadius.circular(12)',
          ],
          codeSnippet:
              "Container(\n  decoration: BoxDecoration(\n    borderRadius: BorderRadius.circular(12),\n  ),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What radius value is used to round the corners?',
          codeSnippet:
              "Container(\n  decoration: BoxDecoration(\n    borderRadius: BorderRadius.circular(12),\n  ),\n)",
          expectedOutput: '12',
        ),
      ],
      keyPoints: [
        'BorderRadius rounds corners.',
        'BorderRadius.circular(12) creates evenly rounded edges.',
        'It is usually used inside BoxDecoration.',
      ],
      hints: [
        'Use BoxDecoration together with BorderRadius.',
        'Apply BorderRadius.circular(12) inside decoration.',
        "Container(\n  decoration: BoxDecoration(\n    borderRadius: BorderRadius.circular(12),\n  ),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w3-l5',
      worldId: 'world_3',
      levelNumber: 5,
      title: 'Icon Widget',
      concept: 'Icon widget',
      lessonText:
          'The Icon widget displays a graphical symbol from Flutter\'s built-in Icons collection. Icons help users quickly recognize actions and meaning without reading full text.',
      guidedText:
          'Pick a symbol from Icons.* and pass it into the Icon widget constructor.',
      challengePrompt: 'Display a favorite icon using Icons.favorite.',
      expectedCode: 'Icon(Icons.favorite)',
      validationRules: ['Icon(', 'Icons.favorite'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget displays a symbol from the Icons library?',
          options: ['Image', 'Text', 'Icon', 'Badge'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Display a favorite icon using Icons.favorite.',
          validationRules: ['Icon(', 'Icons.favorite'],
          codeSnippet: 'Icon(Icons.favorite)',
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the icon name so the favorite icon is displayed.',
          brokenCode: 'Icon(Icons.favourite)',
          fixRules: ['Icon(', 'Icons.favorite'],
          codeSnippet: 'Icon(Icons.favorite)',
        ),
      ],
      keyPoints: [
        'Icon displays a visual symbol.',
        'Flutter provides built-in icons through Icons.*.',
        'Icons make interfaces easier to scan quickly.',
      ],
      hints: [
        'Use the widget that shows a symbol from the Icons library.',
        'Pass Icons.favorite into Icon(...).',
        'Icon(Icons.favorite)',
      ],
    ),
  ],
);
