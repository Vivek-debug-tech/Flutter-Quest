import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World listsWorld = buildCurriculumWorld(
  id: 'world_6',
  title: 'Lists',
  description: 'Render collections with list-based widgets and interactions.',
  icon: 'T',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w6-l1',
      worldId: 'world_6',
      levelNumber: 1,
      title: 'ListView',
      concept: 'ListView widget',
      lessonText:
          'ListView lays out its children in a scrollable linear list. It is the basic widget for showing many items vertically in Flutter.',
      guidedText:
          'Use ListView(children: [...]) when you already know the widgets you want to display.',
      challengePrompt: 'Create a ListView with two Text children.',
      expectedCode:
          "ListView(\n  children: [\n    Text('Item 1'),\n    Text('Item 2'),\n  ],\n)",
      validationRules: ['ListView(', 'children:', 'Item 1', 'Item 2'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget shows a scrollable vertical list of children?',
          options: ['Column', 'ListView', 'Stack', 'PageView'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a ListView with two Text children.',
          validationRules: ['ListView(', 'children:', 'Item 1', 'Item 2'],
          codeSnippet:
              "ListView(\n  children: [\n    Text('Item 1'),\n    Text('Item 2'),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the list so ListView uses a children list.',
          brokenCode: "ListView(\n  child: Text('Item 1'),\n)",
          fixRules: ['ListView(', 'children:', 'Item 1', 'Item 2'],
          codeSnippet:
              "ListView(\n  children: [\n    Text('Item 1'),\n    Text('Item 2'),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'ListView displays items in a scrollable column.',
        'children: is used when all items are already known.',
        'It is ideal for simple small lists.',
      ],
      hints: [
        'Use the scrollable list widget.',
        'Put the two Text widgets inside children:.',
        "ListView(\n  children: [\n    Text('Item 1'),\n    Text('Item 2'),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w6-l2',
      worldId: 'world_6',
      levelNumber: 2,
      title: 'ListTile',
      concept: 'ListTile widget',
      lessonText:
          'ListTile is a ready-made row layout commonly used in lists, menus, and settings screens. It handles common patterns like title, subtitle, leading icon, and trailing icon.',
      guidedText:
          'Start with ListTile( and set the title: property to a Text widget.',
      challengePrompt: 'Create a ListTile with title "Profile".',
      expectedCode: "ListTile(\n  title: Text('Profile'),\n)",
      validationRules: ['ListTile(', 'title:', 'Profile'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget is designed for a standard list row?',
          options: ['Row', 'ListTile', 'Container', 'TileView'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a ListTile with title "Profile".',
          validationRules: ['ListTile(', 'title:', 'Profile'],
          codeSnippet: "ListTile(\n  title: Text('Profile'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What title text is displayed in this ListTile?',
          codeSnippet: "ListTile(\n  title: Text('Profile'),\n)",
          expectedOutput: 'Profile',
        ),
      ],
      keyPoints: [
        'ListTile is designed for list rows.',
        'title is the main text of the row.',
        'It can also include leading and trailing widgets.',
      ],
      hints: [
        'Use the widget made for standard list rows.',
        'Set title: to Text(\'Profile\').',
        "ListTile(\n  title: Text('Profile'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w6-l3',
      worldId: 'world_6',
      levelNumber: 3,
      title: 'ListView.builder',
      concept: 'Builder list',
      lessonText:
          'ListView.builder creates list items lazily as they scroll into view. This is much more efficient than building every item at once for large lists.',
      guidedText:
          'Use itemCount to tell Flutter how many rows there are and itemBuilder to build each row on demand.',
      challengePrompt: 'Create a ListView.builder with itemCount 10.',
      expectedCode:
          "ListView.builder(\n  itemCount: 10,\n  itemBuilder: (context, index) {\n    return Text('Item');\n  },\n)",
      validationRules: ['ListView.builder(', 'itemCount:', 'itemBuilder:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which ListView constructor builds items lazily?',
          options: ['ListView.items', 'ListView.lazy', 'ListView.builder', 'ListView.generate'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a ListView.builder with itemCount 10.',
          validationRules: ['ListView.builder(', 'itemCount:', 'itemBuilder:'],
          codeSnippet:
              "ListView.builder(\n  itemCount: 10,\n  itemBuilder: (context, index) {\n    return Text('Item');\n  },\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the builder property so the list builds items lazily.',
          brokenCode:
              "ListView.builder(\n  itemCount: 10,\n  builder: (context, index) {\n    return Text('Item');\n  },\n)",
          fixRules: ['ListView.builder(', 'itemCount:', 'itemBuilder:'],
          codeSnippet:
              "ListView.builder(\n  itemCount: 10,\n  itemBuilder: (context, index) {\n    return Text('Item');\n  },\n)",
        ),
      ],
      keyPoints: [
        'ListView.builder is efficient for long lists.',
        'itemCount defines how many rows exist.',
        'itemBuilder creates each visible row.',
      ],
      hints: [
        'Use the lazy-building version of ListView.',
        'Add itemCount and itemBuilder.',
        "ListView.builder(\n  itemCount: 10,\n  itemBuilder: (context, index) {\n    return Text('Item');\n  },\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w6-l4',
      worldId: 'world_6',
      levelNumber: 4,
      title: 'Dismissible',
      concept: 'Swipe-to-dismiss',
      lessonText:
          'Dismissible lets the user remove an item with a swipe gesture. It is often used in email, tasks, and notifications where items can be cleared quickly.',
      guidedText:
          'Give the item a stable key and define onDismissed so Flutter knows what to do when the user swipes it away.',
      challengePrompt: 'Create a Dismissible widget with a Text child.',
      expectedCode:
          "Dismissible(\n  key: ValueKey('item'),\n  onDismissed: (direction) {},\n  child: Text('Swipe me'),\n)",
      validationRules: ['Dismissible(', 'key:', 'onDismissed:', 'child:'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget supports swipe-to-dismiss behavior?',
          options: ['Draggable', 'Dismissible', 'ReorderableListView', 'GestureDetector'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a Dismissible widget with a Text child.',
          validationRules: ['Dismissible(', 'key:', 'onDismissed:', 'child:'],
          codeSnippet:
              "Dismissible(\n  key: ValueKey('item'),\n  onDismissed: (direction) {},\n  child: Text('Swipe me'),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What text is displayed inside this Dismissible?',
          codeSnippet:
              "Dismissible(\n  key: ValueKey('item'),\n  onDismissed: (direction) {},\n  child: Text('Swipe me'),\n)",
          expectedOutput: 'Swipe me',
        ),
      ],
      keyPoints: [
        'Dismissible supports swipe-to-remove behavior.',
        'A unique key is required.',
        'onDismissed handles the removal action.',
      ],
      hints: [
        'Use the widget designed for swipe removal.',
        'Add both key: and onDismissed:.',
        "Dismissible(\n  key: ValueKey('item'),\n  onDismissed: (direction) {},\n  child: Text('Swipe me'),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w6-l5',
      worldId: 'world_6',
      levelNumber: 5,
      title: 'ReorderableListView',
      concept: 'Reorderable list',
      lessonText:
          'ReorderableListView allows the user to drag items into a new order. It is useful for playlists, task ordering, and user-customizable sequences.',
      guidedText:
          'Every child needs a key, and the list needs an onReorder callback to update the underlying data order.',
      challengePrompt:
          'Create a ReorderableListView with one keyed Text item.',
      expectedCode:
          "ReorderableListView(\n  onReorder: (oldIndex, newIndex) {},\n  children: [\n    Text('Row', key: ValueKey('row')),\n  ],\n)",
      validationRules: [
        'ReorderableListView(',
        'onReorder:',
        'children:',
        'ValueKey',
      ],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which list widget lets users drag items into a new order?',
          options: ['ListView', 'Dismissible', 'ReorderableListView', 'GridView'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a ReorderableListView with one keyed Text item.',
          validationRules: [
            'ReorderableListView(',
            'onReorder:',
            'children:',
            'ValueKey',
          ],
          codeSnippet:
              "ReorderableListView(\n  onReorder: (oldIndex, newIndex) {},\n  children: [\n    Text('Row', key: ValueKey('row')),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the callback name so the list can be reordered.',
          brokenCode:
              "ReorderableListView(\n  onMove: (oldIndex, newIndex) {},\n  children: [\n    Text('Row', key: ValueKey('row')),\n  ],\n)",
          fixRules: [
            'ReorderableListView(',
            'onReorder:',
            'children:',
            'ValueKey',
          ],
          codeSnippet:
              "ReorderableListView(\n  onReorder: (oldIndex, newIndex) {},\n  children: [\n    Text('Row', key: ValueKey('row')),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'ReorderableListView supports drag-and-drop ordering.',
        'Children need stable keys.',
        'onReorder updates the underlying list order.',
      ],
      hints: [
        'Use the list widget that supports drag reordering.',
        'Include onReorder and keyed children.',
        "ReorderableListView(\n  onReorder: (oldIndex, newIndex) {},\n  children: [\n    Text('Row', key: ValueKey('row')),\n  ],\n)",
      ],
    ),
  ],
);
