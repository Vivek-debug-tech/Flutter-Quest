/// CHALLENGE BUILDER SYSTEM - Quick Reference Guide
/// 
/// This system provides a clean, extensible way to dynamically render
/// different challenge types based on ChallengeType enum.
///
/// =============================================================================
/// ARCHITECTURE OVERVIEW
/// =============================================================================
///
/// 1. ChallengeType Enum (models/challenge_models.dart)
///    - multipleChoice
///    - fillInBlank
///    - fixTheBug
///    - buildWidget
///
/// 2. ChallengeStep Model (models/challenge_models.dart)
///    - Supports different data structures per type
///    - MCQ: has options field
///    - Fill Blank: has correctAnswer field
///    - Fix Bug: has brokenCode/fixedCode fields
///    - Build Widget: has widgetRequirement field
///
/// 3. Individual Widget Components (widgets/challenges/)
///    - MCQChallengeWidget
///    - FillBlankChallengeWidget
///    - FixCodeChallengeWidget (handles both fixTheBug and buildWidget)
///
/// 4. Dynamic Builder (utils/challenge_builder.dart)
///    - buildChallenge() function
///    - ChallengeUIBuilder class
///    - Extension methods on ChallengeStep
///    - Factory patterns
///
/// =============================================================================
/// USAGE PATTERNS
/// =============================================================================

import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../utils/challenge_builder.dart';
import '../engine/challenge_engine.dart';

/// PATTERN 1: Direct Function Call (Simplest)
/// Use this for straightforward scenarios
class Pattern1Example extends StatefulWidget {
  @override
  State<Pattern1Example> createState() => _Pattern1ExampleState();
}

class _Pattern1ExampleState extends State<Pattern1Example> {
  String? userAnswer;
  
  final ChallengeStep step = const ChallengeStep(
    id: 'step_1',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'What is Flutter?',
    options: [
      OptionModel(id: '1', text: 'UI Framework', isCorrect: true),
      OptionModel(id: '2', text: 'Database', isCorrect: false),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return buildChallenge(
      step: step,
      onAnswerChanged: (answer) => setState(() => userAnswer = answer),
      selectedAnswer: userAnswer,
    );
  }
}

/// PATTERN 2: Builder Class (For Complex Scenarios)
/// Use this when you need to build the widget conditionally
class Pattern2Example extends StatefulWidget {
  @override
  State<Pattern2Example> createState() => _Pattern2ExampleState();
}

class _Pattern2ExampleState extends State<Pattern2Example> {
  String? userAnswer;
  
  final ChallengeStep step = const ChallengeStep(
    id: 'step_2',
    stepNumber: 1,
    type: ChallengeType.fillInBlank,
    question: 'Complete: Flutter uses _____ programming language',
    correctAnswer: 'Dart',
  );

  @override
  Widget build(BuildContext context) {
    return ChallengeUIBuilder(step: step)
        .withAnswerCallback((answer) => setState(() => userAnswer = answer))
        .withSelectedAnswer(userAnswer)
        .build();
  }
}

/// PATTERN 3: Extension Method (Most Concise)
/// Use this for clean, readable code
class Pattern3Example extends StatefulWidget {
  @override
  State<Pattern3Example> createState() => _Pattern3ExampleState();
}

class _Pattern3ExampleState extends State<Pattern3Example> {
  String? userAnswer;
  
  final ChallengeStep step = const ChallengeStep(
    id: 'step_3',
    stepNumber: 1,
    type: ChallengeType.fixTheBug,
    question: 'Fix the code',
    brokenCode: 'void main() { print("Hello" }',
    fixedCode: 'void main() { print("Hello"); }',
  );

  @override
  Widget build(BuildContext context) {
    return step.buildWidget(
      onAnswerChanged: (answer) => setState(() => userAnswer = answer),
      selectedAnswer: userAnswer,
    );
  }
}

/// PATTERN 4: Factory Pattern (For Preset Configurations)
/// Use this for common scenarios like review mode
class Pattern4Example extends StatelessWidget {
  final ChallengeStep step = const ChallengeStep(
    id: 'step_4',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'Review question',
    options: [
      OptionModel(id: '1', text: 'Option A', isCorrect: true),
    ],
  );

  @override
  Widget build(BuildContext context) {
    // Create read-only widget for review
    return ChallengeWidgetFactory.createReadOnly(step, '1');
    
    // OR create interactive widget
    // return ChallengeWidgetFactory.createInteractive(
    //   step: step,
    //   onAnswerChanged: (answer) => print(answer),
    //   initialAnswer: null,
    // );
  }
}

/// =============================================================================
/// INTEGRATION WITH CHALLENGE ENGINE
/// =============================================================================

class IntegrationExample extends StatefulWidget {
  @override
  State<IntegrationExample> createState() => _IntegrationExampleState();
}

class _IntegrationExampleState extends State<IntegrationExample> {
  // Assume you have a ChallengeEngine instance
  late ChallengeEngine engine;
  String? currentAnswer;

  @override
  Widget build(BuildContext context) {
    // Get current step from engine
    final currentStep = engine.currentStep;

    return Column(
      children: [
        // Progress indicator
        Text('Step ${engine.currentStepNumber} of ${engine.totalSteps}'),
        
        // Dynamic challenge widget
        Expanded(
          child: buildChallenge(
            step: currentStep,
            onAnswerChanged: (answer) {
              setState(() => currentAnswer = answer);
            },
            selectedAnswer: currentAnswer,
          ),
        ),
        
        // Submit button
        ElevatedButton(
          onPressed: () => _submitAnswer(),
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void _submitAnswer() {
    if (currentAnswer != null) {
      final result = engine.validateAnswer(currentAnswer!);
      // Handle result...
      print('Answer validated: ${result.isCorrect}');
    }
  }
}

/// =============================================================================
/// VALIDATION AND ERROR HANDLING
/// =============================================================================

class ValidationExample extends StatelessWidget {
  final ChallengeStep step = const ChallengeStep(
    id: 'step_5',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'Question',
    options: [], // INVALID - empty options
  );

  @override
  Widget build(BuildContext context) {
    // Check if step is valid before building
    if (!step.isValid) {
      return Center(
        child: Text('Invalid challenge configuration'),
      );
    }

    // Safe to build
    return step.buildWidget(
      onAnswerChanged: (answer) => print(answer),
    );
  }
}

/// =============================================================================
/// EXTENDING THE SYSTEM
/// =============================================================================
///
/// To add a new challenge type:
///
/// 1. Add new value to ChallengeType enum
///    enum ChallengeType {
///      ...existing types...,
///      yourNewType,
///    }
///
/// 2. Add required fields to ChallengeStep model
///    final YourDataType? yourFieldName;
///
/// 3. Create new widget component
///    class YourChallengeWidget extends StatelessWidget {
///      final ChallengeStep step;
///      final ValueChanged<String> onAnswerChanged;
///      // ...
///    }
///
/// 4. Update buildChallenge() function in challenge_builder.dart
///    case ChallengeType.yourNewType:
///      return YourChallengeWidget(
///        step: step,
///        onAnswerChanged: onAnswerChanged,
///        // ...
///      );
///
/// 5. Add validation in _validateChallengeStep()
///    case ChallengeType.yourNewType:
///      if (step.yourFieldName == null) {
///        throw ArgumentError('yourFieldName is required');
///      }
///      break;
///
/// =============================================================================
/// BEST PRACTICES
/// =============================================================================
///
/// 1. Always validate ChallengeStep before using
///    if (step.isValid) { /* build widget */ }
///
/// 2. Use factory patterns for common scenarios
///    ChallengeWidgetFactory.createReadOnly(step, answer)
///
/// 3. Keep state management at parent level
///    Let parent manage userAnswer, don't store in builder
///
/// 4. Prefer extension methods for cleaner code
///    step.buildWidget(...) vs buildChallenge(step: step, ...)
///
/// 5. Use selectedAnswer parameter to show current state
///    buildChallenge(step: step, selectedAnswer: currentAnswer)
///
/// 6. Handle null answers gracefully
///    selectedAnswer: userAnswer ?? ''
///
/// 7. Use proper callback patterns
///    onAnswerChanged: (answer) => setState(() => userAnswer = answer)
///
/// =============================================================================
/// TESTING
/// =============================================================================
///
/// Test that each challenge type renders correctly:
///
void testChallengeBuilder() {
  // Test MCQ
  final mcqStep = ChallengeStep(
    id: 'test_mcq',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'Test?',
    options: [
      const OptionModel(id: '1', text: 'A', isCorrect: true),
    ],
  );
  assert(mcqStep.isValid);
  assert(mcqStep.widgetName == 'MCQChallengeWidget');

  // Test Fill Blank
  final fillStep = ChallengeStep(
    id: 'test_fill',
    stepNumber: 1,
    type: ChallengeType.fillInBlank,
    question: 'Complete: ___',
    correctAnswer: 'answer',
  );
  assert(fillStep.isValid);
  assert(fillStep.widgetName == 'FillBlankChallengeWidget');

  // Test Fix Bug
  final fixStep = ChallengeStep(
    id: 'test_fix',
    stepNumber: 1,
    type: ChallengeType.fixTheBug,
    question: 'Fix:',
    brokenCode: 'broken',
    fixedCode: 'fixed',
  );
  assert(fixStep.isValid);
  assert(fixStep.widgetName == 'FixCodeChallengeWidget');

  // Test Build Widget
  final buildStep = ChallengeStep(
    id: 'test_build',
    stepNumber: 1,
    type: ChallengeType.buildWidget,
    question: 'Build:',
    widgetRequirement: 'Create a Container',
  );
  assert(buildStep.isValid);
  assert(buildStep.widgetName == 'FixCodeChallengeWidget');
}

/// =============================================================================
/// TROUBLESHOOTING
/// =============================================================================
///
/// Problem: "ArgumentError: MCQ challenge must have options"
/// Solution: Ensure step.options is not null and not empty for MCQ type
///
/// Problem: "StateError: Answer callback must be set before building"
/// Solution: Call .withAnswerCallback() on ChallengeUIBuilder before .build()
///
/// Problem: Widget not updating when answer changes
/// Solution: Ensure setState() is called in onAnswerChanged callback
///
/// Problem: Challenge showing even though data is invalid
/// Solution: Check step.isValid before building widget
///
/// =============================================================================
/// PERFORMANCE CONSIDERATIONS
/// =============================================================================
///
/// 1. The buildChallenge() function is lightweight - O(1) switch statement
/// 2. Individual widgets manage their own state efficiently
/// 3. No unnecessary rebuilds - only when parent calls setState()
/// 4. Validation is cached in extension property step.isValid
/// 5. Factory patterns return const widgets when possible
///
/// =============================================================================

// This is a documentation file - it won't be executed
// Import challenge_builder.dart to use the actual implementation
