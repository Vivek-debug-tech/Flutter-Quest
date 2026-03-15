import '../../models/challenge_models.dart' as challenge_model;
import '../../models/world_model.dart';
import 'world_builders.dart';

final World navigationWorld = buildCurriculumWorld(
  id: 'world_5',
  title: 'Navigation',
  description: 'Move between screens and add app navigation UI.',
  icon: 'N',
  requiredStars: 2,
  isLocked: true,
  levels: [
    buildCurriculumLevel(
      id: 'w5-l1',
      worldId: 'world_5',
      levelNumber: 1,
      title: 'Navigator.push',
      concept: 'Imperative navigation',
      lessonText:
          'Navigator.push adds a new route to the navigation stack and opens another screen. It is the standard way to move forward to a new page in Flutter.',
      guidedText:
          'Use Navigator.push with MaterialPageRoute when you want to open a widget screen directly.',
      challengePrompt: 'Write a Navigator.push call that opens NextScreen.',
      expectedCode:
          "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => NextScreen(),\n  ),\n)",
      validationRules: ['Navigator.push(', 'MaterialPageRoute(', 'NextScreen'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which method opens a new route on the navigation stack?',
          options: ['Navigator.pop', 'Navigator.push', 'Navigator.open', 'Navigator.go'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Write a Navigator.push call that opens NextScreen.',
          validationRules: ['Navigator.push(', 'MaterialPageRoute(', 'NextScreen'],
          codeSnippet:
              "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => NextScreen(),\n  ),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the route builder so Navigator.push opens NextScreen.',
          brokenCode:
              "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => Nextscreen(),\n  ),\n)",
          fixRules: ['Navigator.push(', 'MaterialPageRoute(', 'NextScreen'],
          codeSnippet:
              "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => NextScreen(),\n  ),\n)",
        ),
      ],
      keyPoints: [
        'Navigator.push opens a new screen.',
        'MaterialPageRoute builds the next page.',
        'The new route is added on top of the stack.',
      ],
      hints: [
        'Use Navigator.push to go to a new page.',
        'Wrap the destination in MaterialPageRoute.',
        "Navigator.push(\n  context,\n  MaterialPageRoute(\n    builder: (context) => NextScreen(),\n  ),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w5-l2',
      worldId: 'world_5',
      levelNumber: 2,
      title: 'Named Routes',
      concept: 'Named route navigation',
      lessonText:
          'Named routes let you navigate using route names such as "/details" instead of directly building the next widget inline.',
      guidedText:
          'Use Navigator.pushNamed when your app already knows the route string for the screen you want to open.',
      challengePrompt: 'Push the route named "/details".',
      expectedCode: "Navigator.pushNamed(context, '/details')",
      validationRules: ['Navigator.pushNamed(', '/details'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which method navigates using a registered route string?',
          options: ['Navigator.push', 'Navigator.routeTo', 'Navigator.pushNamed', 'Navigator.openNamed'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Push the route named "/details".',
          validationRules: ['Navigator.pushNamed(', '/details'],
          codeSnippet: "Navigator.pushNamed(context, '/details')",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'Which route name is pushed in this snippet?',
          codeSnippet: "Navigator.pushNamed(context, '/details')",
          expectedOutput: '/details',
        ),
      ],
      keyPoints: [
        'pushNamed navigates using a string route.',
        'Named routes can simplify larger apps.',
        'The route must already be registered in the app.',
      ],
      hints: [
        'Use the named-route version of Navigator push.',
        'Pass context and the string "/details".',
        "Navigator.pushNamed(context, '/details')",
      ],
    ),
    buildCurriculumLevel(
      id: 'w5-l3',
      worldId: 'world_5',
      levelNumber: 3,
      title: 'AppBar Actions',
      concept: 'AppBar actions',
      lessonText:
          'AppBar actions are small buttons placed on the right side of the top app bar. They are often used for search, settings, share, and filtering actions.',
      guidedText:
          'Use the actions: property and place one or more IconButton widgets in the list.',
      challengePrompt: 'Create an AppBar with one search action button.',
      expectedCode:
          "AppBar(\n  actions: [\n    IconButton(\n      onPressed: () {},\n      icon: Icon(Icons.search),\n    ),\n  ],\n)",
      validationRules: ['AppBar(', 'actions:', 'IconButton(', 'Icons.search'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which property holds AppBar action buttons?',
          options: ['buttons', 'actions', 'trailing', 'menu'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create an AppBar with one search action button.',
          validationRules: ['AppBar(', 'actions:', 'IconButton(', 'Icons.search'],
          codeSnippet:
              "AppBar(\n  actions: [\n    IconButton(\n      onPressed: () {},\n      icon: Icon(Icons.search),\n    ),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the AppBar property so the search button appears as an action.',
          brokenCode:
              "AppBar(\n  action: [\n    IconButton(\n      onPressed: () {},\n      icon: Icon(Icons.search),\n    ),\n  ],\n)",
          fixRules: ['AppBar(', 'actions:', 'IconButton(', 'Icons.search'],
          codeSnippet:
              "AppBar(\n  actions: [\n    IconButton(\n      onPressed: () {},\n      icon: Icon(Icons.search),\n    ),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'AppBar actions are usually IconButtons.',
        'actions: takes a list of widgets.',
        'These buttons appear on the right side of the AppBar.',
      ],
      hints: [
        'Use AppBar with an actions: list.',
        'Add one IconButton using Icons.search.',
        "AppBar(\n  actions: [\n    IconButton(\n      onPressed: () {},\n      icon: Icon(Icons.search),\n    ),\n  ],\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w5-l4',
      worldId: 'world_5',
      levelNumber: 4,
      title: 'Drawer',
      concept: 'Drawer widget',
      lessonText:
          'Drawer provides a side navigation panel that slides in from the edge of the screen. It is commonly used for app-wide navigation and account menus.',
      guidedText:
          'Attach the Drawer to Scaffold.drawer and place the visible drawer content inside the Drawer widget.',
      challengePrompt: 'Add a Drawer with a Text widget labeled "Menu".',
      expectedCode:
          "Scaffold(\n  drawer: Drawer(\n    child: Text('Menu'),\n  ),\n)",
      validationRules: ['Scaffold(', 'drawer:', 'Drawer(', 'Menu'],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which Scaffold property attaches a Drawer?',
          options: ['menu', 'sidePanel', 'drawer', 'navigation'],
          correctIndex: 2,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Add a Drawer with a Text widget labeled "Menu".',
          validationRules: ['Scaffold(', 'drawer:', 'Drawer(', 'Menu'],
          codeSnippet:
              "Scaffold(\n  drawer: Drawer(\n    child: Text('Menu'),\n  ),\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.predictOutput,
          prompt: 'What word appears inside this Drawer?',
          codeSnippet:
              "Scaffold(\n  drawer: Drawer(\n    child: Text('Menu'),\n  ),\n)",
          expectedOutput: 'Menu',
        ),
      ],
      keyPoints: [
        'Drawer is attached through Scaffold.drawer.',
        'It slides in from the side of the app.',
        'Drawer content is placed inside its child widget tree.',
      ],
      hints: [
        'Use Scaffold with the drawer: property.',
        'Put a Drawer widget inside drawer:.',
        "Scaffold(\n  drawer: Drawer(\n    child: Text('Menu'),\n  ),\n)",
      ],
    ),
    buildCurriculumLevel(
      id: 'w5-l5',
      worldId: 'world_5',
      levelNumber: 5,
      title: 'BottomNavigationBar',
      concept: 'BottomNavigationBar widget',
      lessonText:
          'BottomNavigationBar displays multiple top-level destinations at the bottom of the screen. It is commonly used in apps with a few main sections such as Home, Search, and Settings.',
      guidedText:
          'Create a BottomNavigationBar and define each tab using BottomNavigationBarItem.',
      challengePrompt:
          'Create a BottomNavigationBar with Home and Settings items.',
      expectedCode:
          "BottomNavigationBar(\n  items: [\n    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),\n    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),\n  ],\n)",
      validationRules: [
        'BottomNavigationBar(',
        'BottomNavigationBarItem(',
        'Icons.home',
        'Icons.settings',
      ],
      challenges: [
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.multipleChoice,
          prompt: 'Which widget is used for top-level navigation tabs at the bottom?',
          options: ['TabBar', 'BottomNavigationBar', 'NavigationRail', 'Drawer'],
          correctIndex: 1,
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.code,
          prompt: 'Create a BottomNavigationBar with Home and Settings items.',
          validationRules: [
            'BottomNavigationBar(',
            'BottomNavigationBarItem(',
            'Icons.home',
            'Icons.settings',
          ],
          codeSnippet:
              "BottomNavigationBar(\n  items: [\n    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),\n    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),\n  ],\n)",
        ),
        challenge_model.Challenge(
          type: challenge_model.ChallengeType.fixCode,
          prompt: 'Fix the widget name so the bottom navigation uses items correctly.',
          brokenCode:
              "BottomNavigation(\n  items: [\n    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),\n    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),\n  ],\n)",
          fixRules: [
            'BottomNavigationBar(',
            'BottomNavigationBarItem(',
            'Icons.home',
            'Icons.settings',
          ],
          codeSnippet:
              "BottomNavigationBar(\n  items: [\n    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),\n    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),\n  ],\n)",
        ),
      ],
      keyPoints: [
        'BottomNavigationBar is for top-level app sections.',
        'Each tab is defined by a BottomNavigationBarItem.',
        'Icons and labels help users recognize sections quickly.',
      ],
      hints: [
        'Use BottomNavigationBar with an items: list.',
        'Add two BottomNavigationBarItem entries for Home and Settings.',
        "BottomNavigationBar(\n  items: [\n    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),\n    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),\n  ],\n)",
      ],
    ),
  ],
);
