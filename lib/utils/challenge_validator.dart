/// Challenge validation utilities for checking user code answers
/// 
/// This module provides flexible validation for code challenges,
/// checking for required patterns rather than exact string matches.

import '../models/lesson.dart';

class ChallengeValidator {
  /// Normalizes code by removing all whitespace for flexible pattern matching
  /// 
  /// This allows validation to work regardless of:
  /// - Spacing differences
  /// - Indentation styles
  /// - Line breaks
  /// 
  /// Example:
  /// ```dart
  /// Row(children: [Text('Hi')])
  /// Row(
  ///   children: [
  ///     Text('Hi')
  ///   ]
  /// )
  /// ```
  /// Both normalize to: `Row(children:[Text('Hi')])`
  static String normalizeCode(String code) {
    return code.replaceAll(RegExp(r'\s+'), '');
  }

  /// Universal rule-based validation using lesson's requiredPatterns
  /// 
  /// This is the main validation method that should be used for all challenges.
  /// It normalizes the code and checks if all patterns defined in the lesson
  /// are present.
  /// 
  /// Example:
  /// ```dart
  /// final lesson = Lesson(
  ///   ...
  ///   requiredPatterns: ['Row(', 'children:'],
  /// );
  /// final isValid = ChallengeValidator.validate(userCode, lesson);
  /// ```
  /// 
  /// Returns true if all required patterns are found in the normalized code
  static bool validate(String code, Lesson lesson) {
    if (code.trim().isEmpty) {
      return false;
    }

    // If no patterns defined, fall back to basic validation
    if (lesson.requiredPatterns.isEmpty) {
      return true; // Allow lessons without specific validation rules
    }

    // Normalize code by removing all whitespace
    final normalized = normalizeCode(code);

    // Check each required pattern
    for (String pattern in lesson.requiredPatterns) {
      // Normalize the pattern as well
      final normalizedPattern = normalizeCode(pattern);
      
      if (!normalized.contains(normalizedPattern)) {
        return false;
      }
    }

    return true;
  }

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

  /// Validates Row widget with children property
  /// 
  /// Accepts any formatting style:
  /// - `Row(children: [...])`
  /// - `Row(children:[...])`
  /// - Multi-line variations
  static bool validateRowChallenge(String code) {
    // Check for Row( and children: pattern with flexible whitespace
    return RegExp(r'Row\s*\(').hasMatch(code) && 
           RegExp(r'children\s*:').hasMatch(code);
  }

  /// Validates Column widget with children property
  /// 
  /// Uses flexible pattern matching to accept various formatting
  static bool validateColumnChallenge(String code) {
    // Check for Column( and children: pattern with flexible whitespace
    return RegExp(r'Column\s*\(').hasMatch(code) && 
           RegExp(r'children\s*:').hasMatch(code);
  }

  /// Validates Container widget
  /// 
  /// Checks for Container constructor call with flexible whitespace
  static bool validateContainerChallenge(String code) {
    return RegExp(r'Container\s*\(').hasMatch(code);
  }

  /// Validates Expanded widget
  /// 
  /// Checks for Expanded widget with child property
  static bool validateExpandedChallenge(String code) {
    return RegExp(r'Expanded\s*\(').hasMatch(code) &&
           RegExp(r'child\s*:').hasMatch(code);
  }

  /// Validates Padding widget
  /// 
  /// Checks for Padding widget with EdgeInsets
  static bool validatePaddingChallenge(String code) {
    return RegExp(r'Padding\s*\(').hasMatch(code) &&
           RegExp(r'EdgeInsets').hasMatch(code);
  }

  /// Validates Text widget
  /// 
  /// Checks for Text widget constructor
  static bool validateTextChallenge(String code) {
    return RegExp(r'Text\s*\(').hasMatch(code);
  }

  /// Validates Icon widget
  /// 
  /// Checks for Icon widget with Icons.*
  static bool validateIconChallenge(String code) {
    return RegExp(r'Icon\s*\(').hasMatch(code) &&
           RegExp(r'Icons\.').hasMatch(code);
  }

  /// Validates BoxDecoration usage
  /// 
  /// Checks for BoxDecoration within Container
  static bool validateBoxDecorationChallenge(String code) {
    return RegExp(r'BoxDecoration\s*\(').hasMatch(code);
  }

  /// Validates BorderRadius usage
  /// 
  /// Checks for BorderRadius.circular or BorderRadius.all
  static bool validateBorderRadiusChallenge(String code) {
    return RegExp(r'BorderRadius\.(circular|all)').hasMatch(code);
  }

  /// Validates TextStyle usage
  /// 
  /// Checks for TextStyle in Text widget
  static bool validateTextStyleChallenge(String code) {
    return RegExp(r'TextStyle\s*\(').hasMatch(code);
  }

  /// Validates FloatingActionButton
  /// 
  /// Checks for FAB with onPressed handler
  static bool validateFloatingActionButtonChallenge(String code) {
    return RegExp(r'FloatingActionButton\s*\(').hasMatch(code) &&
           RegExp(r'onPressed\s*:').hasMatch(code);
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
  /// Checks if the code contains widget-related patterns using flexible RegExp matching
  /// 
  /// Example:
  /// ```dart
  /// validateWidgetChallenge(code,  /// widgetName: 'Row',
  ///   additionalPatterns: ['children']
  /// );
  /// ```
  /// 
  /// This accepts both:
  /// - `Row(children: [...])`
  /// - `Row(children:[...])`
  /// - Multi-line variations
  static bool validateWidgetChallenge(String userCode, {
    required String widgetName,
    List<String> additionalPatterns = const [],
  }) {
    final trimmedCode = userCode.trim();

    if (trimmedCode.isEmpty) {
      return false;
    }

    // Use RegExp to check for widget name with flexible whitespace
    // Matches: WidgetName( or WidgetName (
    if (!RegExp('$widgetName\\s*\\(').hasMatch(trimmedCode)) {
      return false;
    }

    // Check for additional patterns with flexible matching
    for (String pattern in additionalPatterns) {
      // For property patterns like "children", check with flexible whitespace
      // Matches: children: or children :
      if (!RegExp('$pattern\\s*:', caseSensitive: true).hasMatch(trimmedCode) &&
          !trimmedCode.contains(pattern)) {
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
