// Centralized Challenge Validation Engine

import '../engine/code_structure_analyzer.dart';
import '../engine/error_detector.dart';
import '../engine/smart_hint_engine.dart';
import '../models/challenge_models.dart';
import '../utils/challenge_validator.dart';

class ChallengeEngine {
  /// Single validation entry point for all modern challenge types.
  static bool validateChallenge(Challenge challenge, dynamic userAnswer) {
    print('Challenge Type: ${challenge.type}');

    switch (challenge.type) {
      case ChallengeType.code:
        return ChallengeValidator.validateCode(
          userAnswer is String ? userAnswer : '',
          challenge.validationRules ?? const [],
        );
      case ChallengeType.multipleChoice:
        return userAnswer is int &&
            challenge.correctIndex != null &&
            ChallengeValidator.validateMultipleChoice(
              userAnswer,
              challenge.correctIndex!,
            );
      case ChallengeType.fixCode:
        return ChallengeValidator.validateFixCode(
          userAnswer is String ? userAnswer : '',
          challenge.fixRules ?? const [],
        );
      case ChallengeType.predictOutput:
        return ChallengeValidator.validatePredictOutput(
          userAnswer is String ? userAnswer : '',
          challenge.expectedOutput ?? '',
        );
    }
  }

  /// Analyzes code structure only (read-only check).
  static Map<String, dynamic> analyzeCodeStructure(String code) {
    return CodeStructureAnalyzer.getStructureReport(code);
  }

  /// Detects errors only (read-only check).
  static ErrorResult? detectErrors(String code) {
    return FlutterErrorDetector.detectError(code);
  }

  /// Gets hints for a specific error type.
  static Map<String, String?> getHintsForError(String errorType) {
    return {
      'smartHint': SmartHintEngine.getSmartHint(errorType),
      'quickFix': SmartHintEngine.getQuickFix(errorType),
      'learningTip': SmartHintEngine.getLearningTip(errorType),
    };
  }
}
