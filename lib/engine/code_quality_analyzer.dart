// Code Quality Analyzer for Flutter best practices.
// Inspects Flutter code and provides suggestions to improve quality and performance.
// Returns a list of improvement tips or an empty list if code quality is good.

class CodeQualityAnalyzer {
  /// Analyzes Flutter code quality and returns best practice suggestions
  /// 
  /// This method runs AFTER validation succeeds, providing constructive
  /// feedback to help learners improve their code quality.
  /// 
  /// Returns a list of helpful tips (empty if code is already following best practices)
  /// 
  /// Example usage:
  /// ```dart
  /// final tips = CodeQualityAnalyzer.analyze(userCode);
  /// if (tips.isNotEmpty) {
  ///   // Display tips to user
  /// }
  /// ```
  static List<String> analyze(String code) {
    final tips = <String>[];

    // Rule 1: Unnecessary Container wrapping
    if (_hasUnnecessaryContainer(code)) {
      tips.add("You don't need a Container here. Widgets like Row, Column, and Center can be used directly.");
    }

    // Rule 2: Missing const constructors
    if (_hasMissingConst(code)) {
      tips.add("Consider adding 'const' before immutable widgets (like Text, Icon) for better performance.");
    }

    // Rule 3: Deeply nested widget trees
    if (_hasDeeplyNestedWidgets(code)) {
      tips.add("Try simplifying the widget structure. Consider extracting nested widgets into separate methods or classes.");
    }

    // Rule 4: Hardcoded values
    if (_hasHardcodedValues(code)) {
      tips.add("Consider extracting magic numbers (like 20, 100) into named constants for better maintainability.");
    }

    // Rule 5: Inline styling
    if (_hasInlineStyling(code)) {
      tips.add("Consider creating a theme or extracting common styles to avoid duplication.");
    }

    // Rule 6: Missing widget keys
    if (_hasDynamicListWithoutKeys(code)) {
      tips.add("When building lists of widgets dynamically, consider using Keys for better performance.");
    }

    return tips;
  }

  /// Detects unnecessary Container wrapping simple widgets
  /// 
  /// Example: Container(child: Row(...)) can be simplified to Row(...)
  static bool _hasUnnecessaryContainer(String code) {
    // Check for Container wrapping Row, Column, or other layout widgets without styling
    final unnecessaryPatterns = [
      RegExp(r'Container\s*\(\s*child\s*:\s*Row\s*\('),
      RegExp(r'Container\s*\(\s*child\s*:\s*Column\s*\('),
      RegExp(r'Container\s*\(\s*child\s*:\s*Center\s*\('),
    ];

    for (final pattern in unnecessaryPatterns) {
      if (pattern.hasMatch(code)) {
        // Check if Container has no other properties (color, decoration, etc.)
        // Simplified check: if Container appears with ONLY child property
        final containerMatch = code.indexOf('Container(');
        if (containerMatch != -1) {
          final snippet = code.substring(containerMatch, 
            containerMatch + 100 < code.length ? containerMatch + 100 : code.length);
          
          // If no color, decoration, width, height, padding, margin
          if (!snippet.contains('color:') && 
              !snippet.contains('decoration:') &&
              !snippet.contains('width:') &&
              !snippet.contains('height:') &&
              !snippet.contains('padding:') &&
              !snippet.contains('margin:')) {
            return true;
          }
        }
      }
    }
    
    return false;
  }

  /// Detects Text or Icon widgets without const keyword
  /// 
  /// Example: Text('Hello') should be const Text('Hello')
  static bool _hasMissingConst(String code) {
    // Check for Text or Icon without const
    final patterns = [
      RegExp(r'(?<!const\s)Text\s*\('),
      RegExp(r'(?<!const\s)Icon\s*\('),
    ];

    for (final pattern in patterns) {
      if (pattern.hasMatch(code)) {
        // Make sure it's not already preceded by const
        final matches = pattern.allMatches(code);
        for (final match in matches) {
          final start = match.start;
          if (start > 6) {
            final before = code.substring(start - 6, start);
            if (!before.contains('const')) {
              return true;
            }
          } else {
            return true;
          }
        }
      }
    }
    
    return false;
  }

  /// Detects deeply nested widget trees (more than 5 levels)
  /// 
  /// Example: Widget(child: Widget(child: Widget(child: Widget(child: Widget(...)))))
  static bool _hasDeeplyNestedWidgets(String code) {
    // Count nested levels by counting 'child:' occurrences in close proximity
    int maxNestedLevel = 0;
    int currentLevel = 0;
    
    for (int i = 0; i < code.length - 6; i++) {
      if (code.substring(i, i + 6) == 'child:') {
        currentLevel++;
        if (currentLevel > maxNestedLevel) {
          maxNestedLevel = currentLevel;
        }
      }
      // Reset when we encounter closing braces
      if (code[i] == ')' || code[i] == '}') {
        if (currentLevel > 0) currentLevel--;
      }
    }
    
    return maxNestedLevel > 5;
  }

  /// Detects hardcoded numeric values (magic numbers)
  /// 
  /// Example: width: 200, height: 100 instead of using constants
  static bool _hasHardcodedValues(String code) {
    // Check for numeric literals in common properties
    final patterns = [
      RegExp(r'width\s*:\s*\d{2,}'),
      RegExp(r'height\s*:\s*\d{2,}'),
      RegExp(r'fontSize\s*:\s*\d{2,}'),
      RegExp(r'padding\s*:\s*\d{2,}'),
    ];

    // Count occurrences - if more than 2, suggest constants
    int count = 0;
    for (final pattern in patterns) {
      count += pattern.allMatches(code).length;
    }
    
    return count > 2;
  }

  /// Detects inline styling that could be extracted to a theme
  /// 
  /// Example: Multiple TextStyle definitions with similar properties
  static bool _hasInlineStyling(String code) {
    // Count TextStyle occurrences
    final textStyleCount = RegExp(r'TextStyle\s*\(').allMatches(code).length;
    
    // If multiple similar TextStyles, suggest theme
    return textStyleCount > 2;
  }

  /// Detects dynamic lists without Keys
  /// 
  /// Example: children: list.map((item) => Widget()) without Key
  static bool _hasDynamicListWithoutKeys(String code) {
    // Check for .map() in children without key:
    if (code.contains('.map(') && code.contains('children:')) {
      // Check if Key is used
      if (!code.contains('key:') && !code.contains('Key(')) {
        return true;
      }
    }
    
    return false;
  }

  /// Gets a summary of code quality
  /// 
  /// Returns a score from 0-100 based on best practices
  static int getQualityScore(String code) {
    final tips = analyze(code);
    
    // Start with perfect score
    int score = 100;
    
    // Deduct points for each issue
    score -= tips.length * 10;
    
    // Ensure score doesn't go below 0
    if (score < 0) score = 0;
    
    return score;
  }

  /// Checks if code follows best practices
  /// 
  /// Returns true if no quality issues found
  static bool isHighQuality(String code) {
    return analyze(code).isEmpty;
  }

  /// Gets detailed quality report
  /// 
  /// Returns a map with score and issues
  static Map<String, dynamic> getQualityReport(String code) {
    final tips = analyze(code);
    final score = getQualityScore(code);
    
    return {
      'score': score,
      'tips': tips,
      'highQuality': tips.isEmpty,
      'issueCount': tips.length,
    };
  }
}
