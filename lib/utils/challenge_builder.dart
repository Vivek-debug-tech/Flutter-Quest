import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../widgets/challenges/mcq_challenge_widget.dart';
import '../widgets/challenges/fill_blank_challenge_widget.dart';
import '../widgets/challenges/fix_code_challenge_widget.dart';

/// Dynamic Challenge Builder - Returns appropriate UI widget based on challenge type
/// 
/// This builder function provides a clean, extensible way to render different
/// challenge types without coupling the challenge logic to specific UI implementations.
/// 
/// Usage:
/// ```dart
/// Widget challengeUI = buildChallenge(
///   step: currentChallengeStep,
///   onAnswerChanged: (answer) {
///     setState(() => userAnswer = answer);
///   },
///   selectedAnswer: userAnswer,
/// );
/// ```

/// Builds the appropriate challenge widget based on ChallengeType
/// 
/// Parameters:
/// - [step]: The challenge step containing type and data
/// - [onAnswerChanged]: Callback when user modifies their answer
/// - [selectedAnswer]: Current user's answer (for maintaining state)
/// 
/// Returns the appropriate widget for the challenge type
Widget buildChallenge({
  required ChallengeStep step,
  required ValueChanged<String> onAnswerChanged,
  String? selectedAnswer,
}) {
  // Validate that the step has required data for its type
  _validateChallengeStep(step);

  switch (step.type) {
    case ChallengeType.multipleChoice:
      return MCQChallengeWidget(
        step: step,
        onAnswerSelected: onAnswerChanged,
        selectedAnswer: selectedAnswer,
      );

    case ChallengeType.fillInBlank:
      return FillBlankChallengeWidget(
        step: step,
        onAnswerChanged: onAnswerChanged,
      );

    case ChallengeType.arrangeCode:
      // TODO: Implement ArrangeCodeChallengeWidget
      return Center(
        child: Text('ArrangeCode widget not yet implemented'),
      );

    case ChallengeType.fixTheBug:
    case ChallengeType.buildWidget:
      return FixCodeChallengeWidget(
        step: step,
        onCodeChanged: onAnswerChanged,
      );

    case ChallengeType.interactiveCode:
      return FixCodeChallengeWidget(
        step: step,
        onCodeChanged: onAnswerChanged,
      );
  }
}

/// Validates that a ChallengeStep has the required data for its type
/// Throws ArgumentError if required fields are missing
void _validateChallengeStep(ChallengeStep step) {
  switch (step.type) {
    case ChallengeType.multipleChoice:
      if (step.options == null || step.options!.isEmpty) {
        throw ArgumentError(
          'MCQ challenge (${step.id}) must have options',
        );
      }
      break;

    case ChallengeType.fillInBlank:
      if (step.correctAnswer == null || step.correctAnswer!.isEmpty) {
        throw ArgumentError(
          'Fill-in-blank challenge (${step.id}) must have correctAnswer',
        );
      }
      break;

    case ChallengeType.arrangeCode:
      if (step.codePieces == null || step.codePieces!.isEmpty) {
        throw ArgumentError(
          'ArrangeCode challenge (${step.id}) must have codePieces',
        );
      }
      if (step.correctOrder == null || step.correctOrder!.isEmpty) {
        throw ArgumentError(
          'ArrangeCode challenge (${step.id}) must have correctOrder',
        );
      }
      break;

    case ChallengeType.fixTheBug:
      if (step.brokenCode == null || step.fixedCode == null) {
        throw ArgumentError(
          'Fix-the-bug challenge (${step.id}) must have brokenCode and fixedCode',
        );
      }
      break;

    case ChallengeType.buildWidget:
      if (step.widgetRequirement == null) {
        throw ArgumentError(
          'Build-widget challenge (${step.id}) must have widgetRequirement',
        );
      }
      break;

    case ChallengeType.interactiveCode:
      // Interactive code challenges use same validation as fixTheBug
      if (step.correctAnswer == null || step.correctAnswer!.isEmpty) {
        throw ArgumentError(
          'Interactive code challenge (${step.id}) must have correctAnswer',
        );
      }
      break;
  }
}

/// Builder class for more advanced use cases with customization
/// 
/// Usage:
/// ```dart
/// final builder = ChallengeUIBuilder(step: challengeStep);
/// Widget widget = builder
///   .withAnswerCallback(onAnswerChanged)
///   .withSelectedAnswer(currentAnswer)
///   .build();
/// ```
class ChallengeUIBuilder {
  final ChallengeStep step;
  ValueChanged<String>? _onAnswerChanged;
  String? _selectedAnswer;

  ChallengeUIBuilder({required this.step});

  /// Set the answer changed callback
  ChallengeUIBuilder withAnswerCallback(ValueChanged<String> callback) {
    _onAnswerChanged = callback;
    return this;
  }

  /// Set the currently selected answer
  ChallengeUIBuilder withSelectedAnswer(String? answer) {
    _selectedAnswer = answer;
    return this;
  }

  /// Build and return the widget
  Widget build() {
    if (_onAnswerChanged == null) {
      throw StateError(
        'Answer callback must be set before building. '
        'Call withAnswerCallback() first.',
      );
    }

    return buildChallenge(
      step: step,
      onAnswerChanged: _onAnswerChanged!,
      selectedAnswer: _selectedAnswer,
    );
  }
}

/// Extension method on ChallengeStep for convenient widget building
extension ChallengeStepBuilder on ChallengeStep {
  /// Builds the UI widget for this challenge step
  /// 
  /// Usage:
  /// ```dart
  /// Widget challengeWidget = challengeStep.buildWidget(
  ///   onAnswerChanged: (answer) => print(answer),
  ///   selectedAnswer: currentAnswer,
  /// );
  /// ```
  Widget buildWidget({
    required ValueChanged<String> onAnswerChanged,
    String? selectedAnswer,
  }) {
    return buildChallenge(
      step: this,
      onAnswerChanged: onAnswerChanged,
      selectedAnswer: selectedAnswer,
    );
  }

  /// Returns the type-specific widget name for this challenge
  String get widgetName {
    switch (type) {
      case ChallengeType.multipleChoice:
        return 'MCQChallengeWidget';
      case ChallengeType.fillInBlank:
        return 'FillBlankChallengeWidget';
      case ChallengeType.arrangeCode:
        return 'ArrangeCodeChallengeWidget';
      case ChallengeType.fixTheBug:
      case ChallengeType.buildWidget:
        return 'FixCodeChallengeWidget';
      case ChallengeType.interactiveCode:
        return 'InteractiveCodeChallengeWidget';
    }
  }

  /// Checks if this challenge step has all required fields for its type
  bool get isValid {
    try {
      _validateChallengeStep(this);
      return true;
    } catch (_) {
      return false;
    }
  }
}

/// Factory class for creating challenge widgets with preset configurations
class ChallengeWidgetFactory {
  /// Creates a read-only challenge widget (for review mode)
  static Widget createReadOnly(ChallengeStep step, String? answer) {
    return buildChallenge(
      step: step,
      onAnswerChanged: (_) {}, // No-op callback
      selectedAnswer: answer,
    );
  }

  /// Creates an interactive challenge widget
  static Widget createInteractive({
    required ChallengeStep step,
    required ValueChanged<String> onAnswerChanged,
    String? initialAnswer,
  }) {
    return buildChallenge(
      step: step,
      onAnswerChanged: onAnswerChanged,
      selectedAnswer: initialAnswer,
    );
  }

  /// Creates a challenge widget with custom configuration
  static Widget createCustom({
    required ChallengeStep step,
    required ValueChanged<String> onAnswerChanged,
    String? currentAnswer,
  }) {
    return buildChallenge(
      step: step,
      onAnswerChanged: onAnswerChanged,
      selectedAnswer: currentAnswer,
    );
  }
}
