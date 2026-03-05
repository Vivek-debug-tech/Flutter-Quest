import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../utils/challenge_builder.dart';

/// Demo: Dynamic Challenge Builder Usage Examples
/// 
/// This file demonstrates all the ways to use the challenge builder system
/// to dynamically create challenge UIs based on ChallengeType.

void main() {
  runApp(const ChallengeBuilderDemo());
}

class ChallengeBuilderDemo extends StatelessWidget {
  const ChallengeBuilderDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge Builder Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const BuilderDemoHome(),
    );
  }
}

class BuilderDemoHome extends StatelessWidget {
  const BuilderDemoHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenge Builder Examples'),
        backgroundColor: Colors.indigo.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildInfoCard(),
          const SizedBox(height: 24),
          
          _buildExampleCard(
            context: context,
            title: 'Method 1: Direct Function',
            description: 'Using buildChallenge() function directly',
            onTap: () => _showExample1(context),
          ),
          
          const SizedBox(height: 16),
          
          _buildExampleCard(
            context: context,
            title: 'Method 2: Builder Class',
            description: 'Using ChallengeUIBuilder for complex scenarios',
            onTap: () => _showExample2(context),
          ),
          
          const SizedBox(height: 16),
          
          _buildExampleCard(
            context: context,
            title: 'Method 3: Extension Method',
            description: 'Using step.buildWidget() extension',
            onTap: () => _showExample3(context),
          ),
          
          const SizedBox(height: 16),
          
          _buildExampleCard(
            context: context,
            title: 'Method 4: Factory Patterns',
            description: 'Using ChallengeWidgetFactory presets',
            onTap: () => _showExample4(context),
          ),
          
          const SizedBox(height: 16),
          
          _buildExampleCard(
            context: context,
            title: 'All Challenge Types',
            description: 'See all 4 challenge types in action',
            onTap: () => _showAllTypes(context),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade600, Colors.purple.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              const Text(
                'Dynamic Challenge Builder',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The challenge builder automatically renders the correct UI '
            'based on ChallengeType. It supports 4 types:\n\n'
            '• Multiple Choice\n'
            '• Fill in the Blank\n'
            '• Fix the Bug\n'
            '• Build Widget',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.code,
                  color: Colors.indigo.shade700,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }

  // Example 1: Direct function usage
  void _showExample1(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DirectFunctionExample(),
      ),
    );
  }

  // Example 2: Builder class usage
  void _showExample2(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BuilderClassExample(),
      ),
    );
  }

  // Example 3: Extension method usage
  void _showExample3(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ExtensionMethodExample(),
      ),
    );
  }

  // Example 4: Factory pattern usage
  void _showExample4(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FactoryPatternExample(),
      ),
    );
  }

  // Show all challenge types
  void _showAllTypes(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AllChallengeTypesExample(),
      ),
    );
  }
}

// ==============================================================================
// EXAMPLE 1: Direct Function Usage
// ==============================================================================

class DirectFunctionExample extends StatefulWidget {
  const DirectFunctionExample({Key? key}) : super(key: key);

  @override
  State<DirectFunctionExample> createState() => _DirectFunctionExampleState();
}

class _DirectFunctionExampleState extends State<DirectFunctionExample> {
  String? userAnswer;

  final ChallengeStep mcqStep = ChallengeStep(
    id: 'demo_mcq_1',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'What is the entry point of a Flutter app?',
    options: [
      const OptionModel(id: '1', text: 'main()', isCorrect: true),
      const OptionModel(id: '2', text: 'start()', isCorrect: false),
      const OptionModel(id: '3', text: 'run()', isCorrect: false),
      const OptionModel(id: '4', text: 'init()', isCorrect: false),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method 1: Direct Function'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Code:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Widget widget = buildChallenge(\n'
                '  step: mcqStep,\n'
                '  onAnswerChanged: (answer) {\n'
                '    setState(() => userAnswer = answer);\n'
                '  },\n'
                '  selectedAnswer: userAnswer,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: buildChallenge(
                step: mcqStep,
                onAnswerChanged: (answer) {
                  setState(() => userAnswer = answer);
                },
                selectedAnswer: userAnswer,
              ),
            ),
            if (userAnswer != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Selected: $userAnswer',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.indigo.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// EXAMPLE 2: Builder Class Usage
// ==============================================================================

class BuilderClassExample extends StatefulWidget {
  const BuilderClassExample({Key? key}) : super(key: key);

  @override
  State<BuilderClassExample> createState() => _BuilderClassExampleState();
}

class _BuilderClassExampleState extends State<BuilderClassExample> {
  String? userAnswer;

  final ChallengeStep fillBlankStep = const ChallengeStep(
    id: 'demo_fill_1',
    stepNumber: 1,
    type: ChallengeType.fillInBlank,
    question: 'Complete: _____ is used to make widgets rebuild.',
    correctAnswer: 'setState',
    blankPlaceholder: '____',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method 2: Builder Class'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Code:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Widget widget = ChallengeUIBuilder(step: fillBlankStep)\n'
                '  .withAnswerCallback((answer) => setState(...))\n'
                '  .withSelectedAnswer(userAnswer)\n'
                '  .build();',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ChallengeUIBuilder(step: fillBlankStep)
                  .withAnswerCallback((answer) {
                    setState(() => userAnswer = answer);
                  })
                  .withSelectedAnswer(userAnswer)
                  .build(),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// EXAMPLE 3: Extension Method Usage
// ==============================================================================

class ExtensionMethodExample extends StatefulWidget {
  const ExtensionMethodExample({Key? key}) : super(key: key);

  @override
  State<ExtensionMethodExample> createState() => _ExtensionMethodExampleState();
}

class _ExtensionMethodExampleState extends State<ExtensionMethodExample> {
  String? userAnswer;

  final ChallengeStep fixBugStep = const ChallengeStep(
    id: 'demo_fix_1',
    stepNumber: 1,
    type: ChallengeType.fixTheBug,
    question: 'Fix the missing semicolon:',
    brokenCode: 'void main() {\n  print("Hello")\n}',
    fixedCode: 'void main() {\n  print("Hello");\n}',
    bugHint: 'Missing semicolon after print statement',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Method 3: Extension Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Code:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Widget widget = fixBugStep.buildWidget(\n'
                '  onAnswerChanged: (answer) => setState(...),\n'
                '  selectedAnswer: userAnswer,\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: fixBugStep.buildWidget(
                onAnswerChanged: (answer) {
                  setState(() => userAnswer = answer);
                },
                selectedAnswer: userAnswer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// EXAMPLE 4: Factory Pattern Usage
// ==============================================================================

class FactoryPatternExample extends StatelessWidget {
  const FactoryPatternExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reviewStep = const ChallengeStep(
      id: 'demo_review_1',
      stepNumber: 1,
      type: ChallengeType.multipleChoice,
      question: 'What does runApp() do?',
      options: [
        OptionModel(
          id: '1',
          text: 'Initializes the app',
          isCorrect: true,
        ),
        OptionModel(
          id: '2',
          text: 'Closes the app',
          isCorrect: false,
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Method 4: Factory Patterns'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Code for Read-Only Mode:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Widget widget = ChallengeWidgetFactory.createReadOnly(\n'
                '  reviewStep,\n'
                '  "1", // Previously answered\n'
                ');',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Result (Read-Only):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ChallengeWidgetFactory.createReadOnly(
                reviewStep,
                '1', // Pre-selected answer
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// EXAMPLE: All Challenge Types
// ==============================================================================

class AllChallengeTypesExample extends StatelessWidget {
  const AllChallengeTypesExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Challenge Types'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'The builder automatically handles all 4 types:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildTypeCard('Multiple Choice', ChallengeType.multipleChoice),
          const SizedBox(height: 12),
          _buildTypeCard('Fill in the Blank', ChallengeType.fillInBlank),
          const SizedBox(height: 12),
          _buildTypeCard('Fix the Bug', ChallengeType.fixTheBug),
          const SizedBox(height: 12),
          _buildTypeCard('Build Widget', ChallengeType.buildWidget),
        ],
      ),
    );
  }

  Widget _buildTypeCard(String title, ChallengeType type) {
    IconData icon;
    Color color;

    switch (type) {
      case ChallengeType.multipleChoice:
        icon = Icons.check_circle_outline;
        color = Colors.blue;
        break;
      case ChallengeType.fillInBlank:
        icon = Icons.edit_outlined;
        color = Colors.green;
        break;
      case ChallengeType.arrangeCode:
        icon = Icons.reorder;
        color = Colors.purple;
        break;
      case ChallengeType.fixTheBug:
        icon = Icons.bug_report;
        color = Colors.orange;
        break;
      case ChallengeType.buildWidget:
        icon = Icons.widgets;
        color = Colors.purple;
        break;
      case ChallengeType.interactiveCode:
        icon = Icons.code;
        color = Colors.teal;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Type: ${type.name}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check, color: color, size: 24),
        ],
      ),
    );
  }
}
