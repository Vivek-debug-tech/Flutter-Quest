import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World stateWorld = buildCurriculumWorld(
  id: 'world_7',
  title: 'State Management',
  description: 'Learn local widget state and simple dynamic UI patterns.',
  icon: 'D',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w7-l1',
      worldId: 'world_7',
      levelNumber: 1,
      title: 'StatefulWidget',
      concept: 'StatefulWidget structure',
      lessonText:
          'StatefulWidget is used when a widget needs mutable state that can change over time, such as counters, toggles, forms, and live data.',
      guidedText:
          'Create a widget class that extends StatefulWidget, then connect it to a matching State class through createState().',
      challengePrompt: 'Create a CounterPage that extends StatefulWidget.',
      expectedCode:
          "class CounterPage extends StatefulWidget {\n  @override\n  State<CounterPage> createState() => _CounterPageState();\n}",
      validationRules: [
        'extends StatefulWidget',
        'createState()',
        'State<CounterPage>',
      ],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget type is used for UI that changes over time?',
          options: ['StatelessWidget', 'InheritedWidget', 'StatefulWidget', 'Container'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a CounterPage that extends StatefulWidget.',
          validationRules: [
            'extends StatefulWidget',
            'createState()',
            'State<CounterPage>',
          ],
          codeSnippet:
              "class CounterPage extends StatefulWidget {\n  @override\n  State<CounterPage> createState() => _CounterPageState();\n}",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the base class so CounterPage can hold mutable state.',
          brokenCode:
              "class CounterPage extends StatelessWidget {\n  @override\n  State<CounterPage> createState() => _CounterPageState();\n}",
          fixRules: [
            'extends StatefulWidget',
            'createState()',
            'State<CounterPage>',
          ],
          codeSnippet:
              "class CounterPage extends StatefulWidget {\n  @override\n  State<CounterPage> createState() => _CounterPageState();\n}",
        ),
      ],
      keyPoints: [
        'StatefulWidget is for changing UI.',
        'It works together with a State class.',
        'createState() connects the widget to its state object.',
      ],
      hints: [
        'Use the widget type for changing state.',
        'Add createState() and a State<CounterPage> class reference.',
        "class CounterPage extends StatefulWidget {\n  @override\n  State<CounterPage> createState() => _CounterPageState();\n}",
      ],
    ),
    buildCurriculumLevel(
      id: 'w7-l2',
      worldId: 'world_7',
      levelNumber: 2,
      title: 'setState Counter',
      concept: 'setState',
      lessonText:
          'setState tells Flutter that the internal state has changed and that the widget should rebuild with the new values.',
      guidedText:
          'Wrap the state update inside setState so Flutter knows it must redraw the screen.',
      challengePrompt: 'Increment a counter using setState.',
      expectedCode: "setState(() {\n  count++;\n})",
      validationRules: ['setState(', 'count++'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which method tells Flutter to rebuild after local state changes?',
          options: ['refresh()', 'notify()', 'setState()', 'updateUI()'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Increment a counter using setState.',
          validationRules: ['setState(', 'count++'],
          codeSnippet: "setState(() {\n  count++;\n})",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'Which variable is incremented in this snippet?',
          codeSnippet: "setState(() {\n  count++;\n})",
          expectedOutput: 'count',
        ),
      ],
      keyPoints: [
        'setState triggers a rebuild.',
        'State changes should happen inside the callback.',
        'Counters are one of the simplest setState examples.',
      ],
      hints: [
        'Use the rebuild method for StatefulWidget updates.',
        'Increment the variable inside setState(() { ... }).',
        "setState(() {\n  count++;\n})",
      ],
    ),
    buildCurriculumLevel(
      id: 'w7-l3',
      worldId: 'world_7',
      levelNumber: 3,
      title: 'Toggle State Example',
      concept: 'Boolean state',
      lessonText:
          'Boolean state is commonly used to toggle visibility, selection, theme changes, and other on/off UI behavior.',
      guidedText:
          'To toggle a bool, assign it to its opposite value using the ! operator inside setState.',
      challengePrompt: 'Toggle an isOn boolean inside setState.',
      expectedCode: "setState(() {\n  isOn = !isOn;\n})",
      validationRules: ['setState(', 'isOn = !isOn'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which operator flips a bool to the opposite value?',
          options: ['+', '!', '&&', '=='],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Toggle an isOn boolean inside setState.',
          validationRules: ['setState(', 'isOn = !isOn'],
          codeSnippet: "setState(() {\n  isOn = !isOn;\n})",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the toggle so the bool flips correctly.',
          brokenCode: "setState(() {\n  isOn = isOn;\n})",
          fixRules: ['setState(', 'isOn = !isOn'],
          codeSnippet: "setState(() {\n  isOn = !isOn;\n})",
        ),
      ],
      keyPoints: [
        'Boolean state is useful for on/off UI.',
        '! reverses a bool value.',
        'Use setState when the toggle affects the UI.',
      ],
      hints: [
        'Flip the bool to its opposite value.',
        'Do the toggle inside setState.',
        "setState(() {\n  isOn = !isOn;\n})",
      ],
    ),
    buildCurriculumLevel(
      id: 'w7-l4',
      worldId: 'world_7',
      levelNumber: 4,
      title: 'Form Validation',
      concept: 'Form validation',
      lessonText:
          'Form validation checks whether user input is acceptable before the app continues. It helps prevent bad input and guides the user to fix mistakes early.',
      guidedText:
          'A validator returns an error string when input is invalid and returns null when the value is acceptable.',
      challengePrompt: 'Create a TextFormField with a validator.',
      expectedCode:
          "TextFormField(\n  validator: (value) {\n    if (value == null || value.isEmpty) {\n      return 'Required';\n    }\n    return null;\n  },\n)",
      validationRules: ['TextFormField(', 'validator:', 'Required'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'What should a validator return when input is valid?',
          options: ['true', 'false', 'null', 'Required'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a TextFormField with a validator.',
          validationRules: ['TextFormField(', 'validator:', 'Required'],
          codeSnippet:
              "TextFormField(\n  validator: (value) {\n    if (value == null || value.isEmpty) {\n      return 'Required';\n    }\n    return null;\n  },\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the return value so invalid input shows an error.',
          brokenCode:
              "TextFormField(\n  validator: (value) {\n    if (value == null || value.isEmpty) {\n      return null;\n    }\n    return null;\n  },\n)",
          fixRules: ['TextFormField(', 'validator:', 'Required'],
          codeSnippet:
              "TextFormField(\n  validator: (value) {\n    if (value == null || value.isEmpty) {\n      return 'Required';\n    }\n    return null;\n  },\n)",
        ),
      ],
      keyPoints: [
        'validator checks the current input value.',
        'Return a string for errors.',
        'Return null when the value is valid.',
      ],
      hints: [
        'Use TextFormField instead of plain TextField.',
        'Add a validator that returns \'Required\' when empty.',
        "TextFormField(\n  validator: (value) {\n    if (value == null || value.isEmpty) {\n      return 'Required';\n    }\n    return null;\n  },\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w7-l5',
      worldId: 'world_7',
      levelNumber: 5,
      title: 'Simple Todo State',
      concept: 'List state updates',
      lessonText:
          'Many real apps manage state by updating local lists, such as todo items, messages, playlists, and shopping cart entries.',
      guidedText:
          'When list data changes, wrap the update in setState so the UI refreshes with the new item.',
      challengePrompt: 'Add a todo item to a list inside setState.',
      expectedCode: "setState(() {\n  todos.add('New task');\n})",
      validationRules: ['setState(', 'todos.add('],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which call adds a new item to the todos list?',
          options: [
            "todos.push('New task')",
            "todos.add('New task')",
            "todos.insertItem('New task')",
            "todos.appendText('New task')",
          ],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Add a todo item to a list inside setState.',
          validationRules: ['setState(', 'todos.add('],
          codeSnippet: "setState(() {\n  todos.add('New task');\n})",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text is added to the todos list?',
          codeSnippet: "setState(() {\n  todos.add('New task');\n})",
          expectedOutput: 'New task',
        ),
      ],
      keyPoints: [
        'Lists are common pieces of app state.',
        'Adding to the list changes the UI data.',
        'setState refreshes the visible list.',
      ],
      hints: [
        'Update the list inside setState.',
        'Use todos.add(...) to insert the new task.',
        "setState(() {\n  todos.add('New task');\n})",
      ],
    ),
  ],
);
