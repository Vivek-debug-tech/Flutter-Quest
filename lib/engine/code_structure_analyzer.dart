/// Code Structure Analyzer for Flutter widget trees
/// 
/// This analyzer inspects Flutter code structure and detects common
/// widget tree mistakes that beginners often make.
/// 
/// Returns helpful error messages for structural issues or null if the code
/// structure looks correct.

/// Severity levels for structure analysis results
enum AnalyzerSeverity {
  /// Informational - helpful tip that doesn't indicate a problem
  info,
  
  /// Warning - potential issue but not critical
  warning,
  
  /// Error - critical mistake that prevents code from working
  error,
}

/// Result from structure analysis
class AnalyzerResult {
  final AnalyzerSeverity severity;
  final String message;
  
  const AnalyzerResult(this.severity, this.message);
  
  /// Whether this result should block validation
  bool get shouldBlock => severity == AnalyzerSeverity.error;
  
  /// Whether this is just a helpful suggestion
  bool get isSuggestion => severity == AnalyzerSeverity.info || severity == AnalyzerSeverity.warning;
}

class CodeStructureAnalyzer {
  /// Analyzes Flutter code structure and detects common mistakes
  /// 
  /// Returns an AnalyzerResult with severity level if an issue is found,
  /// or null if the code structure appears correct.
  /// 
  /// Severity levels:
  /// - ERROR: Critical mistake that prevents code from working (blocks validation)
  /// - WARNING: Potential issue that might cause problems (doesn't block)
  /// - INFO: Helpful suggestion for improvement (doesn't block)
  /// 
  /// Example usage:
  /// ```dart
  /// AnalyzerResult? result = CodeStructureAnalyzer.analyzeStructure(userCode);
  /// if (result?.shouldBlock == true) {
  ///   // Show error and stop validation
  /// } else if (result?.isSuggestion == true) {
  ///   // Show suggestion but continue validation
  /// }
  /// ```
  static AnalyzerResult? analyzeStructure(String code) {
    if (code.trim().isEmpty) {
      return null;
    }

    // Rule 1: Container children mistake (CRITICAL ERROR)
    // Container only supports 'child:', not 'children:'
    // This will cause a compile error, so it's blocking
    if (_hasPattern(code, r'Container\s*\([^)]*children\s*:')) {
      return AnalyzerResult(
        AnalyzerSeverity.error,
        "Container only supports 'child:' not 'children:'. This will cause a compile error.",
      );
    }

    // Rule 2: Row without children (WARNING)
    // Row requires a 'children:' property, but might be a partial answer
    if (_hasPattern(code, r'Row\s*\(')) {
      if (!_hasPattern(code, r'children\s*:')) {
        return AnalyzerResult(
          AnalyzerSeverity.warning,
          "Row typically requires a 'children:' property with a list of widgets.",
        );
      }
    }

    // Rule 3: Column without children (WARNING)
    // Column requires a 'children:' list, but might be a partial answer
    if (_hasPattern(code, r'Column\s*\(')) {
      if (!_hasPattern(code, r'children\s*:')) {
        return AnalyzerResult(
          AnalyzerSeverity.warning,
          "Column typically requires a 'children:' list.",
        );
      }
    }

    // Rule 4: MaterialApp without Scaffold (INFO)
    // This is just a suggestion for better structure
    if (_hasPattern(code, r'MaterialApp\s*\(')) {
      if (!_hasPattern(code, r'Scaffold\s*\(')) {
        return AnalyzerResult(
          AnalyzerSeverity.info,
          "Tip: Most Flutter UI layouts include a Scaffold for better structure.",
        );
      }
    }

    // Rule 5: UI components without MaterialApp (INFO)
    // This is a suggestion, not a requirement
    // Some lessons intentionally teach components without full app structure
    if (!_hasPattern(code, r'MaterialApp\s*\(')) {
      // Check if code is building complex UI components
      bool hasComplexUI = _hasPattern(code, r'Scaffold\s*\(') &&
                          (_hasPattern(code, r'AppBar\s*\(') ||
                           _hasPattern(code, r'FloatingActionButton\s*\('));
      
      // Only suggest MaterialApp for complex UI with Scaffold + other Material widgets
      if (hasComplexUI) {
        return AnalyzerResult(
          AnalyzerSeverity.info,
          "Tip: Consider wrapping your UI with MaterialApp for Material Design theming.",
        );
      }
    }

    // No issues found
    return null;
  }

  /// Helper method to check if a pattern exists in the code
  /// 
  /// Uses RegExp for flexible pattern matching
  static bool _hasPattern(String code, String pattern) {
    try {
      return RegExp(pattern, caseSensitive: true, multiLine: true).hasMatch(code);
    } catch (e) {
      // If pattern is invalid, return false
      return false;
    }
  }

  /// Checks if code contains a specific widget
  /// 
  /// Example: `hasWidget(code, 'Container')`
  static bool hasWidget(String code, String widgetName) {
    return _hasPattern(code, '$widgetName\\s*\\(');
  }

  /// Checks if a widget has a specific property
  /// 
  /// Example: `hasProperty(code, 'children')`
  static bool hasProperty(String code, String propertyName) {
    return _hasPattern(code, '$propertyName\\s*:');
  }

  /// Gets a detailed structure report (for debugging)
  /// 
  /// Returns a list of detected widgets and properties
  static Map<String, dynamic> getStructureReport(String code) {
    return {
      'hasContainer': hasWidget(code, 'Container'),
      'hasRow': hasWidget(code, 'Row'),
      'hasColumn': hasWidget(code, 'Column'),
      'hasScaffold': hasWidget(code, 'Scaffold'),
      'hasMaterialApp': hasWidget(code, 'MaterialApp'),
      'hasChildren': hasProperty(code, 'children'),
      'hasChild': hasProperty(code, 'child'),
      'hasRunApp': _hasPattern(code, r'runApp\s*\('),
      'hasMain': _hasPattern(code, r'main\s*\('),
    };
  }
}
