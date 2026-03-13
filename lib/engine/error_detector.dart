/// Flutter Beginner Error Detection Engine
/// 
/// Detects common beginner mistakes in Flutter code and provides
/// helpful feedback to improve the learning experience.

/// Result of error detection containing error type and message
class ErrorResult {
  final String type;
  final String message;

  ErrorResult(this.type, this.message);
}

class FlutterErrorDetector {
  /// Analyzes user code and returns an ErrorResult if a common
  /// mistake is detected. Returns null if no known mistake is found.
  static ErrorResult? detectError(String code) {
    // Remove extra whitespace for better pattern matching
    final cleanCode = code.trim();
    
    // Check for Container using 'children' instead of 'child'
    if (_hasPattern(cleanCode, r'Container\s*\([^)]*children\s*:')) {
      return ErrorResult(
        'container_children',
        "❌ Container does not support 'children'.\n\n"
            "💡 Tip: Container can only have ONE child. Use 'child:' instead of 'children:'.\n\n"
            "Example:\n"
            "Container(\n"
            "  child: Text('Hello'),\n"
            ")",
      );
    }
    
    // Check for Row using 'child' instead of 'children'
    if (_hasPattern(cleanCode, r'Row\s*\([^)]*\bchild\s*:') && 
        !_hasPattern(cleanCode, r'Row\s*\([^)]*children\s*:')) {
      return ErrorResult(
        'row_child',
        "❌ Row uses 'children' not 'child'.\n\n"
            "💡 Tip: Row can display MULTIPLE widgets horizontally. Use 'children:' with a list.\n\n"
            "Example:\n"
            "Row(\n"
            "  children: [\n"
            "    Text('Hello'),\n"
            "    Text('World'),\n"
            "  ],\n"
            ")",
      );
    }
    
    // Check for Column using 'child' instead of 'children'
    if (_hasPattern(cleanCode, r'Column\s*\([^)]*\bchild\s*:') && 
        !_hasPattern(cleanCode, r'Column\s*\([^)]*children\s*:')) {
      return ErrorResult(
        'column_child',
        "❌ Column uses 'children' not 'child'.\n\n"
            "💡 Tip: Column can display MULTIPLE widgets vertically. Use 'children:' with a list.\n\n"
            "Example:\n"
            "Column(\n"
            "  children: [\n"
            "    Text('Hello'),\n"
            "    Text('World'),\n"
            "  ],\n"
            ")",
      );
    }
    
    // Check for missing MaterialApp (if code has runApp but no MaterialApp)
    if (_hasPattern(cleanCode, r'runApp\s*\(') && 
        !_hasPattern(cleanCode, r'MaterialApp')) {
      return ErrorResult(
        'missing_material_app',
        "❌ Missing MaterialApp widget.\n\n"
            "💡 Tip: Flutter apps should start with MaterialApp to provide Material Design.\n\n"
            "Example:\n"
            "runApp(\n"
            "  MaterialApp(\n"
            "    home: Scaffold(...),\n"
            "  ),\n"
            ")",
      );
    }
    
    // Check for missing Scaffold (if code has MaterialApp but no Scaffold)
    if (_hasPattern(cleanCode, r'MaterialApp') && 
        !_hasPattern(cleanCode, r'Scaffold') &&
        _hasPattern(cleanCode, r'home\s*:')) {
      return ErrorResult(
        'missing_scaffold',
        "❌ Missing Scaffold widget.\n\n"
            "💡 Tip: Most Flutter screens need a Scaffold to provide basic structure (AppBar, body, etc.).\n\n"
            "Example:\n"
            "MaterialApp(\n"
            "  home: Scaffold(\n"
            "    body: Center(...),\n"
            "  ),\n"
            ")",
      );
    }
    
    // Check for Text widget without quotes
    if (_hasPattern(cleanCode, r'Text\s*\(\s*[A-Za-z][A-Za-z0-9]*\s*\)') &&
        !_hasPattern(cleanCode, r'Text\s*\(\s*["\"]') && 
        !_hasPattern(cleanCode, r"Text\s*\(\s*[']")) {
      return ErrorResult(
        'text_without_quotes',
        "❌ Text widget requires a String.\n\n"
            "💡 Tip: Wrap your text in quotes to make it a String.\n\n"
            "Example:\n"
            "Text('Hello World')  // ✅ Correct\n"
            "Text(Hello World)    // ❌ Wrong",
      );
    }
    
    // Check for missing comma after closing parenthesis in list
    if (_hasPattern(cleanCode, r'\)\s*\n\s*[A-Z]') && 
        !_hasPattern(cleanCode, r'\),\s*\n')) {
      return ErrorResult(
        'missing_comma',
        "❌ Missing comma in widget list.\n\n"
            "💡 Tip: In Dart, list items must be separated by commas. Add a comma after each widget.\n\n"
            "Example:\n"
            "children: [\n"
            "  Text('First'),   // ← comma here\n"
            "  Text('Second'),  // ← comma here\n"
            "]",
      );
    }
    
    // Check for missing closing bracket/parenthesis
    final openParens = '('.allMatches(cleanCode).length;
    final closeParens = ')'.allMatches(cleanCode).length;
    if (openParens > closeParens) {
      return ErrorResult(
        'missing_close_paren',
        "❌ Missing closing parenthesis ')'.\n\n"
            "💡 Tip: Every opening '(' needs a closing ')'. Check your code carefully.\n\n"
            "Found $openParens opening '(' but only $closeParens closing ')'.",
      );
    } else if (closeParens > openParens) {
      return ErrorResult(
        'extra_close_paren',
        "❌ Too many closing parentheses ')'.\n\n"
            "💡 Tip: You have more ')' than '('. Remove the extra ones.",
      );
    }
    
    // Check for missing opening bracket/parenthesis
    final openBrackets = '['.allMatches(cleanCode).length;
    final closeBrackets = ']'.allMatches(cleanCode).length;
    if (openBrackets > closeBrackets) {
      return ErrorResult(
        'missing_close_bracket',
        "❌ Missing closing bracket ']'.\n\n"
            "💡 Tip: Every opening '[' needs a closing ']'. This usually happens in lists.\n\n"
            "Found $openBrackets opening '[' but only $closeBrackets closing ']'.",
      );
    } else if (closeBrackets > openBrackets) {
      return ErrorResult(
        'extra_close_bracket',
        "❌ Too many closing brackets ']'.\n\n"
            "💡 Tip: You have more ']' than '['. Remove the extra ones.",
      );
    }
    
    // Check for Center widget with 'children' instead of 'child'
    if (_hasPattern(cleanCode, r'Center\s*\([^)]*children\s*:')) {
      return ErrorResult(
        'center_children',
        "❌ Center does not support 'children'.\n\n"
            "💡 Tip: Center can only have ONE child. Use 'child:' instead of 'children:'.\n\n"
            "Example:\n"
            "Center(\n"
            "  child: Text('Centered'),\n"
            ")",
      );
    }
    
    // Check for Padding widget with 'children' instead of 'child'
    if (_hasPattern(cleanCode, r'Padding\s*\([^)]*children\s*:')) {
      return ErrorResult(
        'padding_children',
        "❌ Padding does not support 'children'.\n\n"
            "💡 Tip: Padding can only have ONE child. Use 'child:' instead of 'children:'.\n\n"
            "Example:\n"
            "Padding(\n"
            "  padding: EdgeInsets.all(16),\n"
            "  child: Text('Padded'),\n"
            ")",
      );
    }
    
    // No specific error detected
    return null;
  }
  
  /// Helper method to check if code matches a regex pattern
  static bool _hasPattern(String code, String pattern) {
    try {
      return RegExp(pattern, caseSensitive: true, multiLine: true).hasMatch(code);
    } catch (e) {
      // If regex fails, return false
      return false;
    }
  }
}
