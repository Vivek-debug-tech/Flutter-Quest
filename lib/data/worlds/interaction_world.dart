import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World interactionWorld = buildCurriculumWorld(
  id: 'world_4',
  title: 'Interaction',
  description: 'Handle taps, toggles, and user input widgets.',
  icon: 'I',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w4-l1',
      worldId: 'world_4',
      levelNumber: 1,
      title: 'ElevatedButton',
      concept: 'ElevatedButton widget',
      lessonText:
          'ElevatedButton is a Material button used for important actions. It reacts to taps through the onPressed callback and usually appears raised above the background.',
      guidedText:
          'Create an ElevatedButton, add an onPressed callback, and place the visible label inside the child widget.',
      challengePrompt: 'Create an ElevatedButton labeled "Tap Me".',
      expectedCode:
          "ElevatedButton(\n  onPressed: () {},\n  child: Text('Tap Me'),\n)",
      validationRules: ['ElevatedButton(', 'onPressed:', 'Tap Me'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which callback handles taps on an ElevatedButton?',
          options: ['onTap', 'onPressed', 'onClick', 'onSelect'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create an ElevatedButton labeled "Tap Me".',
          validationRules: ['ElevatedButton(', 'onPressed:', 'Tap Me'],
          codeSnippet:
              "ElevatedButton(\n  onPressed: () {},\n  child: Text('Tap Me'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the callback name so the button becomes tappable.',
          brokenCode:
              "ElevatedButton(\n  onTap: () {},\n  child: Text('Tap Me'),\n)",
          fixRules: ['ElevatedButton(', 'onPressed:', 'Tap Me'],
          codeSnippet:
              "ElevatedButton(\n  onPressed: () {},\n  child: Text('Tap Me'),\n)",
        ),
      ],
      keyPoints: [
        'ElevatedButton is used for clear primary actions.',
        'onPressed handles the tap event.',
        'The visible label is usually a Text child.',
      ],
      hints: [
        'Use the raised Material button widget.',
        'Add onPressed: () {} and a Text child.',
        "ElevatedButton(\n  onPressed: () {},\n  child: Text('Tap Me'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w4-l2',
      worldId: 'world_4',
      levelNumber: 2,
      title: 'GestureDetector',
      concept: 'GestureDetector widget',
      lessonText:
          'GestureDetector listens for user gestures such as taps, drags, and long presses. It is useful when a widget should react to touch but is not already a button.',
      guidedText:
          'Wrap the target widget with GestureDetector and define an onTap callback to respond when the user taps it.',
      challengePrompt: 'Create a GestureDetector that wraps a Text widget.',
      expectedCode:
          "GestureDetector(\n  onTap: () {},\n  child: Text('Tap Area'),\n)",
      validationRules: ['GestureDetector(', 'onTap:', 'child:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget listens for raw gestures like taps and drags?',
          options: ['InkWell', 'GestureDetector', 'Listener', 'MouseRegion'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a GestureDetector that wraps a Text widget.',
          validationRules: ['GestureDetector(', 'onTap:', 'child:'],
          codeSnippet:
              "GestureDetector(\n  onTap: () {},\n  child: Text('Tap Area'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text is shown inside this GestureDetector?',
          codeSnippet:
              "GestureDetector(\n  onTap: () {},\n  child: Text('Tap Area'),\n)",
          expectedOutput: 'Tap Area',
        ),
      ],
      keyPoints: [
        'GestureDetector adds interaction to any child widget.',
        'onTap is one of the most common gesture callbacks.',
        'Use it when you need touch handling beyond standard buttons.',
      ],
      hints: [
        'Use the widget that listens for gestures.',
        'Wrap the Text widget and add onTap:.',
        "GestureDetector(\n  onTap: () {},\n  child: Text('Tap Area'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w4-l3',
      worldId: 'world_4',
      levelNumber: 3,
      title: 'Switch',
      concept: 'Switch widget',
      lessonText:
          'Switch is a binary control for turning something on or off. It needs both the current value and an onChanged callback to react to user changes.',
      guidedText:
          'Provide value: for the current state and onChanged: for the function that receives the new value.',
      challengePrompt: 'Create a Switch with value false.',
      expectedCode:
          "Switch(\n  value: false,\n  onChanged: (value) {},\n)",
      validationRules: ['Switch(', 'value:', 'onChanged:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget represents an on/off toggle?',
          options: ['Slider', 'Checkbox', 'Switch', 'Radio'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Switch with value false.',
          validationRules: ['Switch(', 'value:', 'onChanged:'],
          codeSnippet:
              "Switch(\n  value: false,\n  onChanged: (value) {},\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the callback so the Switch can react to changes.',
          brokenCode:
              "Switch(\n  value: false,\n  onChange: (value) {},\n)",
          fixRules: ['Switch(', 'value:', 'onChanged:'],
          codeSnippet:
              "Switch(\n  value: false,\n  onChanged: (value) {},\n)",
        ),
      ],
      keyPoints: [
        'Switch represents on/off state.',
        'value sets the current position.',
        'onChanged reacts when the user toggles it.',
      ],
      hints: [
        'Use the widget for true/false toggles.',
        'A Switch needs both value: and onChanged:.',
        "Switch(\n  value: false,\n  onChanged: (value) {},\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w4-l4',
      worldId: 'world_4',
      levelNumber: 4,
      title: 'Slider',
      concept: 'Slider widget',
      lessonText:
          'Slider lets the user choose a numeric value from a continuous range. It is useful for volume, brightness, size, and other adjustable values.',
      guidedText:
          'A Slider usually needs value, min, max, and onChanged so Flutter knows both the current value and the valid range.',
      challengePrompt: 'Create a Slider from 0 to 100 with value 50.',
      expectedCode:
          "Slider(\n  value: 50,\n  min: 0,\n  max: 100,\n  onChanged: (value) {},\n)",
      validationRules: ['Slider(', 'value:', 'min:', 'max:', 'onChanged:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget lets users choose a number from a range?',
          options: ['Switch', 'Slider', 'Checkbox', 'Button'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Slider from 0 to 100 with value 50.',
          validationRules: ['Slider(', 'value:', 'min:', 'max:', 'onChanged:'],
          codeSnippet:
              "Slider(\n  value: 50,\n  min: 0,\n  max: 100,\n  onChanged: (value) {},\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What is the max value configured for this Slider?',
          codeSnippet:
              "Slider(\n  value: 50,\n  min: 0,\n  max: 100,\n  onChanged: (value) {},\n)",
          expectedOutput: '100',
        ),
      ],
      keyPoints: [
        'Slider chooses a number from a range.',
        'min and max define the range.',
        'onChanged updates the value when the user drags.',
      ],
      hints: [
        'Use the widget for picking a number by dragging.',
        'Set value, min, max, and onChanged.',
        "Slider(\n  value: 50,\n  min: 0,\n  max: 100,\n  onChanged: (value) {},\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w4-l5',
      worldId: 'world_4',
      levelNumber: 5,
      title: 'Checkbox',
      concept: 'Checkbox widget',
      lessonText:
          'Checkbox is a compact true/false selection control. It is useful when the user needs to confirm a choice or toggle a small option.',
      guidedText:
          'Checkbox becomes interactive when you provide the current value and an onChanged callback.',
      challengePrompt: 'Create a Checkbox with value true.',
      expectedCode:
          "Checkbox(\n  value: true,\n  onChanged: (value) {},\n)",
      validationRules: ['Checkbox(', 'value:', 'onChanged:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget shows a checked or unchecked box?',
          options: ['Switch', 'Checkbox', 'Radio', 'Slider'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Checkbox with value true.',
          validationRules: ['Checkbox(', 'value:', 'onChanged:'],
          codeSnippet:
              "Checkbox(\n  value: true,\n  onChanged: (value) {},\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the property name in this Checkbox.',
          brokenCode:
              "Checkbox(\n  checked: true,\n  onChanged: (value) {},\n)",
          fixRules: ['Checkbox(', 'value:', 'onChanged:'],
          codeSnippet:
              "Checkbox(\n  value: true,\n  onChanged: (value) {},\n)",
        ),
      ],
      keyPoints: [
        'Checkbox is a simple boolean control.',
        'value sets whether it is checked.',
        'onChanged responds to user interaction.',
      ],
      hints: [
        'Use the widget for checked or unchecked state.',
        'Provide value: and onChanged:.',
        "Checkbox(\n  value: true,\n  onChanged: (value) {},\n)",
      ],
    ),
  ],
);
