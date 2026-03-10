/// Challenge validation utilities for checking user code answers
/// 
/// This module provides flexible validation for code challenges,
/// checking for required patterns rather than exact string matches.

class ChallengeValidator {
  /// Validates if the user's code contains all required patterns
  /// 
  /// For Flutter challenges, this checks for essential elements like:
  /// - main() function
  /// - runApp() call
  /// - Widget constructors
  /// 
  /// Returns true if all required patterns are found
  static bool validateCode(String userCode, List<String> requiredPatterns) {
    if (userCode.trim().isEmpty) {
      return false;
    }

    // Check each required pattern
    for (String pattern in requiredPatterns) {
      if (!userCode.contains(pattern)) {
        return false;
      }
    }

    return true;
  }

  /// Validates a specific Flutter app challenge
  /// 
  /// Checks for the basic structure of a Flutter app:
  /// - main() function declaration
  /// - runApp() function call
  static bool validateFlutterAppChallenge(String userCode) {
    final trimmedCode = userCode.trim();
    
    if (trimmedCode.isEmpty) {
      print('❌ Validation failed: Code is empty');
      return false;
    }

    // Required patterns for a basic Flutter app
    // Remove all whitespace and newlines for checking
    final codeNoWhitespace = trimmedCode.replaceAll(RegExp(r'\s+'), '');
    
    final hasMain = codeNoWhitespace.contains('main(');
    final hasRunApp = codeNoWhitespace.contains('runApp(');

    print('🔍 Validator check:');
    print('  Has main(: $hasMain');
    print('  Has runApp(: $hasRunApp');
    print('  Result: ${hasMain && hasRunApp}');

    return hasMain && hasRunApp;
  }

  /// Validates the "Hello Flutter" challenge
  /// Uses pattern matching instead of exact string comparison
  static bool validateHelloFlutter(String code) {
    // Normalize code by removing all whitespace
    String normalized = code.replaceAll(RegExp(r'\s+'), '');

    // Check for required patterns
    bool hasMain = normalized.contains("main(");
    bool hasRunApp = normalized.contains("runApp(");

    // Debug output
    print("hasMain: $hasMain");
    print("hasRunApp: $hasRunApp");

    return hasMain && hasRunApp;
  }

  /// Validates a widget challenge
  /// 
  /// Checks if the code contains widget-related patterns
  static bool validateWidgetChallenge(String userCode, {
    required String widgetName,
    List<String> additionalPatterns = const [],
  }) {
    final trimmedCode = userCode.trim();

    if (trimmedCode.isEmpty) {
      return false;
    }

    // Check for widget name
    if (!trimmedCode.contains(widgetName)) {
      return false;
    }

    // Check for additional patterns
    for (String pattern in additionalPatterns) {
      if (!trimmedCode.contains(pattern)) {
        return false;
      }
    }

    return true;
  }

  /// Validates multiple choice answer
  /// 
  /// Simple exact match for multiple choice options
  static bool validateMultipleChoice(String? userAnswer, String correctAnswer) {
    return userAnswer != null && userAnswer.trim() == correctAnswer.trim();
  }

  /// Checks if code has proper syntax structure (basic check)
  /// 
  /// This is a simple validation that checks for balanced braces
  static bool hasBalancedBraces(String code) {
    int braceCount = 0;
    
    for (int i = 0; i < code.length; i++) {
      if (code[i] == '{') {
        braceCount++;
      } else if (code[i] == '}') {
        braceCount--;
      }
      
      // If count goes negative, we have a closing brace without opening
      if (braceCount < 0) {
        return false;
      }
    }

    // All braces should be balanced at the end
    return braceCount == 0;
  }

  /// Provides specific feedback based on what's missing in the code
  static String getValidationFeedback(String userCode, List<String> requiredPatterns) {
    List<String> missingPatterns = [];

    for (String pattern in requiredPatterns) {
      if (!userCode.contains(pattern)) {
        missingPatterns.add(pattern);
      }
    }

    if (missingPatterns.isEmpty) {
      return 'Great job! Your code looks correct.';
    } else if (missingPatterns.length == 1) {
      return 'Missing: ${missingPatterns[0]}';
    } else {
      return 'Missing: ${missingPatterns.join(", ")}';
    }
  }
}
