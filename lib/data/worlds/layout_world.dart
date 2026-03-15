import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World layoutWorld = buildCurriculumWorld(
  id: 'world_2',
  title: 'Layout',
  description: 'Practice spacing, positioning, and sizing widgets.',
  icon: 'L',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w2-l1',
      worldId: 'world_2',
      levelNumber: 1,
      title: 'Padding',
      concept: 'Padding widget',
      lessonText:
          'Padding adds empty space around its child. It helps you separate widgets visually and is one of the easiest ways to improve layout readability.',
      guidedText:
          'Wrap your widget with Padding, then set the padding: property using an EdgeInsets value such as EdgeInsets.all(16).',
      challengePrompt:
          'Add 16 logical pixels of padding around a Text widget.',
      expectedCode:
          "Padding(\n  padding: EdgeInsets.all(16),\n  child: Text('Padded'),\n)",
      validationRules: ['Padding(', 'EdgeInsets.all(16)', 'child:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget adds empty space around its child?',
          options: ['Padding', 'Center', 'Row', 'Stack'],
          correctIndex: 0,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Add 16 logical pixels of padding around a Text widget.',
          validationRules: ['Padding(', 'EdgeInsets.all(16)', 'child:'],
          codeSnippet:
              "Padding(\n  padding: EdgeInsets.all(16),\n  child: Text('Padded'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the padding property so the widget adds outer space.',
          brokenCode:
              "Padding(\n  pad: EdgeInsets.all(16),\n  child: Text('Padded'),\n)",
          fixRules: ['Padding(', 'padding:', 'EdgeInsets.all(16)', 'child:'],
          codeSnippet:
              "Padding(\n  padding: EdgeInsets.all(16),\n  child: Text('Padded'),\n)",
        ),
      ],
      keyPoints: [
        'Padding creates space around a child.',
        'EdgeInsets defines how much space to add.',
        'Padding improves visual separation in layouts.',
      ],
      hints: [
        'Use the widget that adds space around another widget.',
        'Set padding: to EdgeInsets.all(16).',
        "Padding(\n  padding: EdgeInsets.all(16),\n  child: Text('Padded'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w2-l2',
      worldId: 'world_2',
      levelNumber: 2,
      title: 'Expanded',
      concept: 'Expanded widget',
      lessonText:
          'Expanded tells a child inside a Row or Column to grow and take the remaining free space. It is useful when some children should stretch while others keep their natural size.',
      guidedText:
          'Place Expanded inside a Row or Column and wrap the child that should stretch to fill the leftover space.',
      challengePrompt:
          'Use Expanded inside a Row to make a Text widget fill the extra width.',
      expectedCode:
          "Row(\n  children: [\n    Expanded(\n      child: Text('Flexible'),\n    ),\n  ],\n)",
      validationRules: ['Row(', 'Expanded(', 'child:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget makes a child fill the remaining space in a Row?',
          options: ['Expanded', 'Padding', 'Align', 'SizedBox'],
          correctIndex: 0,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt:
              'Use Expanded inside a Row to make a Text widget fill the extra width.',
          validationRules: ['Row(', 'Expanded(', 'child:'],
          codeSnippet:
              "Row(\n  children: [\n    Expanded(\n      child: Text('Flexible'),\n    ),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'Which word is displayed inside the Expanded child?',
          codeSnippet:
              "Row(\n  children: [\n    Expanded(\n      child: Text('Flexible'),\n    ),\n  ],\n)",
          expectedOutput: 'Flexible',
        ),
      ],
      keyPoints: [
        'Expanded works inside Row and Column.',
        'It makes one child fill remaining space.',
        'Expanded still uses child: for the inner widget.',
      ],
      hints: [
        'Use the widget that stretches inside Row or Column.',
        'Wrap the Text widget with Expanded.',
        "Row(\n  children: [\n    Expanded(\n      child: Text('Flexible'),\n    ),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w2-l3',
      worldId: 'world_2',
      levelNumber: 3,
      title: 'Stack',
      concept: 'Stack widget',
      lessonText:
          'Stack places widgets on top of one another in the same layout area. It is useful for overlays, badges, floating labels, and layered UI designs.',
      guidedText:
          'Use Stack(children: [...]) when you want multiple widgets sharing the same space in layers from back to front.',
      challengePrompt:
          'Create a Stack with two Text widgets layered together.',
      expectedCode:
          "Stack(\n  children: [\n    Text('Back'),\n    Text('Front'),\n  ],\n)",
      validationRules: ['Stack(', 'children:', 'Back', 'Front'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget layers children on top of each other?',
          options: ['Row', 'Column', 'Stack', 'Align'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Stack with two Text widgets layered together.',
          validationRules: ['Stack(', 'children:', 'Back', 'Front'],
          codeSnippet:
              "Stack(\n  children: [\n    Text('Back'),\n    Text('Front'),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the Stack so it uses children in the correct order.',
          brokenCode: "Stack(\n  child: Text('Back'),\n)",
          fixRules: ['Stack(', 'children:', 'Back', 'Front'],
          codeSnippet:
              "Stack(\n  children: [\n    Text('Back'),\n    Text('Front'),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'Stack layers widgets on top of each other.',
        'children: controls the order from back to front.',
        'Stack is useful for overlays and floating UI.',
      ],
      hints: [
        'Use the layout widget for layered content.',
        'Place both Text widgets inside children:.',
        "Stack(\n  children: [\n    Text('Back'),\n    Text('Front'),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w2-l4',
      worldId: 'world_2',
      levelNumber: 4,
      title: 'Align',
      concept: 'Align widget',
      lessonText:
          'Align positions a child inside its parent using an Alignment value. This gives you more control than Center when you want content in a specific corner or edge.',
      guidedText:
          'Use Align(alignment: ...) and choose a value like Alignment.topRight or Alignment.bottomLeft to position the child.',
      challengePrompt:
          'Align a Text widget to the topRight of its parent.',
      expectedCode:
          "Align(\n  alignment: Alignment.topRight,\n  child: Text('Top Right'),\n)",
      validationRules: ['Align(', 'Alignment.topRight', 'child:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which alignment value places content in the upper-right corner?',
          options: [
            'Alignment.center',
            'Alignment.topRight',
            'Alignment.bottomLeft',
            'Alignment.topCenter',
          ],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Align a Text widget to the topRight of its parent.',
          validationRules: ['Align(', 'Alignment.topRight', 'child:'],
          codeSnippet:
              "Align(\n  alignment: Alignment.topRight,\n  child: Text('Top Right'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text is shown by this Align widget?',
          codeSnippet:
              "Align(\n  alignment: Alignment.topRight,\n  child: Text('Top Right'),\n)",
          expectedOutput: 'Top Right',
        ),
      ],
      keyPoints: [
        'Align positions one child inside available space.',
        'Alignment.topRight places the child in the upper-right corner.',
        'Align gives more control than Center.',
      ],
      hints: [
        'Use the widget that positions one child by alignment.',
        'Set alignment: to Alignment.topRight.',
        "Align(\n  alignment: Alignment.topRight,\n  child: Text('Top Right'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w2-l5',
      worldId: 'world_2',
      levelNumber: 5,
      title: 'SizedBox',
      concept: 'SizedBox widget',
      lessonText:
          'SizedBox gives a child a fixed width or height, or creates empty space between widgets. It is a simple but very common layout tool.',
      guidedText:
          'Use SizedBox when you want fixed spacing or size. You can set width, height, or both depending on the layout need.',
      challengePrompt:
          'Create a SizedBox with height 24.',
      expectedCode: "SizedBox(\n  height: 24,\n)",
      validationRules: ['SizedBox(', 'height:', '24'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget is commonly used to add fixed empty space?',
          options: ['Stack', 'Expanded', 'SizedBox', 'Align'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a SizedBox with height 24.',
          validationRules: ['SizedBox(', 'height:', '24'],
          codeSnippet: "SizedBox(\n  height: 24,\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the property name in this SizedBox.',
          brokenCode: "SizedBox(\n  size: 24,\n)",
          fixRules: ['SizedBox(', 'height:', '24'],
          codeSnippet: "SizedBox(\n  height: 24,\n)",
        ),
      ],
      keyPoints: [
        'SizedBox can create empty space.',
        'It can also force a fixed width or height.',
        'height: 24 creates vertical spacing or fixed height.',
      ],
      hints: [
        'Use the widget for fixed space or size.',
        'Set the height: property to 24.',
        "SizedBox(\n  height: 24,\n)",
      ],
    ),
  ],
);
