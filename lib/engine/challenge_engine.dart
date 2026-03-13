/// Centralized Challenge Evaluation Engine
/// 
/// This engine coordinates all challenge validation, error detection,
/// and hint generation in a single location.
/// 
/// The evaluation flow:
/// 1. Structure Analysis (widget tree correctness)
/// 2. Error Detection (common Flutter mistakes)
/// 3. Challenge Validation (requirements met?)
/// 4. Smart Hints (if errors found)
/// 
/// UI screens simply call evaluate() and display the result.

import '../models/challenge_result.dart';
import '../models/lesson.dart';
import '../engine/code_structure_analyzer.dart';
import '../engine/code_quality_analyzer.dart';
import '../engine/error_detector.dart';
import '../engine/smart_hint_engine.dart';
import '../utils/challenge_validator.dart';

/// Centralized engine for challenge evaluation
/// 
/// Coordinates all validation, error detection, and hint generation
/// in a single evaluation pipeline.
/// 
/// Example usage:
/// ```dart
/// final result = ChallengeEngine.evaluateLesson(userCode, lesson);
/// if (result.success) {
///   // Award XP and show success
/// } else {
///   // Show error message
/// }
/// ```
class ChallengeEngine {
  /// Evaluates user code against lesson requirements (Rule-Based)
  /// 
  /// This is the main evaluation method that uses the lesson's requiredPatterns
  /// for flexible, rule-based validation.
  /// 
  /// Runs through a multi-stage validation pipeline:
  /// 1. **Structure Analysis** - Checks widget tree structure (with severity levels)
  /// 2. **Error Detection** - Detects common Flutter mistakes
  /// 3. **Rule-Based Validation** - Uses lesson.requiredPatterns
  /// 4. **Code Quality Analysis** - Provides improvement tips
  /// 
  /// Returns a [ChallengeResult] with success status and feedback
  static ChallengeResult evaluateLesson(String code, Lesson lesson) {
    // Empty code check
    if (code.trim().isEmpty) {
      return ChallengeResult.validationError(
        'Please write some code before submitting.',
      );
    }

    // TODO: Re-enable CodeStructureAnalyzer after improving its flexibility.
    // Temporarily disabled due to strict validation issues
    /*
    // Stage 1: Structure Analysis (with severity levels)
    // Check for widget tree structure issues
    AnalyzerResult? structureResult = CodeStructureAnalyzer.analyzeStructure(code);
    
    // Only block validation for CRITICAL errors
    if (structureResult?.shouldBlock == true) {
      return ChallengeResult.structureError(structureResult!.message);
    }
    
    // Store suggestions (warnings/info) to show later if validation passes
    List<String> structureSuggestions = [];
    if (structureResult?.isSuggestion == true) {
      structureSuggestions.add(structureResult!.message);
    }
    */
    List<String> structureSuggestions = [];

    // Stage 2: Error Detection
    // Detect common Flutter syntax mistakes
    ErrorResult? detectedError = FlutterErrorDetector.detectError(code);
    
    if (detectedError != null) {
      // Get smart hints for this error type
      String? smartHint = SmartHintEngine.getSmartHint(detectedError.type);
      String? quickFix = SmartHintEngine.getQuickFix(detectedError.type);
      String? learningTip = SmartHintEngine.getLearningTip(detectedError.type);
      
      return ChallengeResult.syntaxError(
        detectedError.message,
        smartHint: smartHint,
        quickFix: quickFix,
        learningTip: learningTip,
      );
    }

    // Stage 3: Rule-Based Validation
    // Use lesson's requiredPatterns for flexible validation
    bool isValid = ChallengeValidator.validate(code, lesson);
    
    if (!isValid) {
      return ChallengeResult.validationError(
        'Not quite right. Make sure your code includes all required elements.',
      );
    }

    // Stage 4: Code Quality Analysis
    // Analyze code for best practices and improvement tips (non-blocking)
    final qualityTips = CodeQualityAnalyzer.analyze(code);
    
    // Combine structure suggestions with quality tips
    final allTips = [...structureSuggestions, ...qualityTips];

    // All checks passed!
    return ChallengeResult.success(qualityTips: allTips);
  }

  /// Evaluates user code against challenge requirements (Legacy)
  /// 
  /// @deprecated Use evaluateLesson() instead for rule-based validation
  /// 
  /// Runs through a multi-stage validation pipeline:
  /// 1. **Structure Analysis** - Checks widget tree structure (with severity levels)
  /// 2. **Error Detection** - Detects common Flutter mistakes
  /// 3. **Challenge Validation** - Verifies solution correctness
  /// 4. **Code Quality Analysis** - Provides improvement tips
  /// 
  /// Returns a [ChallengeResult] with success status and feedback
  static ChallengeResult evaluate(String code) {
    // Empty code check
    if (code.trim().isEmpty) {
      return ChallengeResult.validationError(
        'Please write some code before submitting.',
      );
    }

    // TODO: Re-enable CodeStructureAnalyzer after improving its flexibility.
    // Temporarily disabled due to strict validation issues
    /*
    // Stage 1: Structure Analysis (with severity levels)
    // Check for widget tree structure issues
    AnalyzerResult? structureResult = CodeStructureAnalyzer.analyzeStructure(code);
    
    // Only block validation for CRITICAL errors
    if (structureResult?.shouldBlock == true) {
      return ChallengeResult.structureError(structureResult!.message);
    }
    
    // Store suggestions (warnings/info) to show later if validation passes
    List<String> structureSuggestions = [];
    if (structureResult?.isSuggestion == true) {
      structureSuggestions.add(structureResult!.message);
    }
    */
    List<String> structureSuggestions = [];

    // Stage 2: Error Detection
    // Detect common Flutter syntax mistakes
    ErrorResult? detectedError = FlutterErrorDetector.detectError(code);
    
    if (detectedError != null) {
      // Get smart hints for this error type
      String? smartHint = SmartHintEngine.getSmartHint(detectedError.type);
      String? quickFix = SmartHintEngine.getQuickFix(detectedError.type);
      String? learningTip = SmartHintEngine.getLearningTip(detectedError.type);
      
      return ChallengeResult.syntaxError(
        detectedError.message,
        smartHint: smartHint,
        quickFix: quickFix,
        learningTip: learningTip,
      );
    }

    // Stage 3: Challenge Validation (Legacy - hardcoded for Hello Flutter)
    // Check if code meets challenge requirements
    bool isValid = ChallengeValidator.validateHelloFlutter(code);
    
    if (!isValid) {
      return ChallengeResult.validationError(
        'Not quite right. Make sure your code includes all required elements.',
      );
    }

    // Stage 4: Code Quality Analysis
    // Analyze code for best practices and improvement tips (non-blocking)
    final qualityTips = CodeQualityAnalyzer.analyze(code);
    
    // Combine structure suggestions with quality tips
    final allTips = [...structureSuggestions, ...qualityTips];

    // All checks passed!
    return ChallengeResult.success(qualityTips: allTips);
  }

  /// Evaluates code with custom validator
  /// 
  /// Allows specifying a custom validation function instead of
  /// using the default validateHelloFlutter validator.
  /// 
  /// Example:
  /// ```dart
  /// final result = ChallengeEngine.evaluateWithValidator(
  ///   userCode,
  ///   validator: (code) => ChallengeValidator.validateRowChallenge(code),
  /// );
  /// ```
  static ChallengeResult evaluateWithValidator(
    String code, {
    required bool Function(String) validator,
  }) {

    // Empty code check
    if (code.trim().isEmpty) {
      return ChallengeResult.validationError(
        'Please write some code before submitting.',
      );
    }

    // TODO: Re-enable CodeStructureAnalyzer after improving its flexibility.
    // Temporarily disabled due to strict validation issues
    /*
    // Stage 1: Structure Analysis (with severity levels)
    AnalyzerResult? structureResult = CodeStructureAnalyzer.analyzeStructure(code);
    if (structureResult?.shouldBlock == true) {
      return ChallengeResult.structureError(structureResult!.message);
    }
    */

    // Stage 2: Error Detection
    ErrorResult? detectedError = FlutterErrorDetector.detectError(code);
    
    if (detectedError != null) {
      String? smartHint = SmartHintEngine.getSmartHint(detectedError.type);
      String? quickFix = SmartHintEngine.getQuickFix(detectedError.type);
      String? learningTip = SmartHintEngine.getLearningTip(detectedError.type);
      
      return ChallengeResult.syntaxError(
        detectedError.message,
        smartHint: smartHint,
        quickFix: quickFix,
        learningTip: learningTip,
      );
    }

    // Stage 3: Custom Validation
    bool isValid = validator(code);
    
    if (!isValid) {
      return ChallengeResult.validationError(
        'Not quite right. Make sure your code includes all required elements.',
      );
    }

    return ChallengeResult.success();
  }

  /// Evaluates widget challenge with specific requirements
  /// 
  /// Validates that code contains a specific widget and properties
  /// 
  /// Example:
  /// ```dart
  /// final result = ChallengeEngine.evaluateWidgetChallenge(
  ///   userCode,
  ///   widgetName: 'Row',
  ///   requiredPatterns: ['children'],
  /// );
  /// ```
  static ChallengeResult evaluateWidgetChallenge(
    String code, {
    required String widgetName,
    List<String> requiredPatterns = const [],
  }) {
    return evaluateWithValidator(
      code,
      validator: (code) => ChallengeValidator.validateWidgetChallenge(
        code,
        widgetName: widgetName,
        additionalPatterns: requiredPatterns,
      ),
    );
  }

  /// Analyzes code structure only (read-only check)
  /// 
  /// Returns structure information without affecting the challenge state.
  /// Useful for providing real-time feedback as user types.
  static Map<String, dynamic> analyzeCodeStructure(String code) {
    return CodeStructureAnalyzer.getStructureReport(code);
  }

  /// Detects errors only (read-only check)
  /// 
  /// Returns error information without affecting challenge state.
  /// Useful for providing real-time error highlighting.
  static ErrorResult? detectErrors(String code) {
    return FlutterErrorDetector.detectError(code);
  }

  /// Gets hints for a specific error type
  /// 
  /// Returns all available hints (smart hint, quick fix, learning tip)
  /// for the given error type.
  static Map<String, String?> getHintsForError(String errorType) {
    return {
      'smartHint': SmartHintEngine.getSmartHint(errorType),
      'quickFix': SmartHintEngine.getQuickFix(errorType),
      'learningTip': SmartHintEngine.getLearningTip(errorType),
    };
  }
}
