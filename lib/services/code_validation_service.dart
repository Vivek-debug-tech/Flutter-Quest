/// Service for validating code challenges without actual compilation
/// Simulates code execution by checking patterns and expected outputs
class CodeValidationService {
  /// Validates user code against expected answer
  /// 
  /// [userCode] - The code entered by the user
  /// [correctAnswer] - The expected correct answer or keyword
  /// [validationRules] - Optional list of rules/patterns to check
  /// 
  /// Returns a [ValidationResult] with success status and feedback
  static ValidationResult validateCode({
    required String userCode,
    String? correctAnswer,
    List<String>? validationRules,
    bool caseSensitive = false,
  }) {
    // Remove extra whitespace and normalize
    final normalizedCode = _normalizeCode(userCode);
    
    // If no validation rules, check against correct answer
    if (validationRules == null || validationRules.isEmpty) {
      if (correctAnswer == null || correctAnswer.isEmpty) {
        return ValidationResult(
          isCorrect: normalizedCode.isNotEmpty,
          feedback: normalizedCode.isEmpty 
              ? 'Please enter some code first!'
              : 'Code submitted successfully!',
        );
      }
      
      // Check if code contains the correct answer
      final codeToCheck = caseSensitive ? normalizedCode : normalizedCode.toLowerCase();
      final answerToCheck = caseSensitive ? correctAnswer : correctAnswer.toLowerCase();
      
      if (codeToCheck.contains(answerToCheck)) {
        return ValidationResult(
          isCorrect: true,
          feedback: 'Correct! Your code contains the expected solution.',
        );
      } else {
        return ValidationResult(
          isCorrect: false,
          feedback: 'Not quite right. Check your answer and try again.',
        );
      }
    }
    
    // Check against validation rules
    final failedRules = <String>[];
    
    for (final rule in validationRules) {
      final ruleToCheck = caseSensitive ? rule : rule.toLowerCase();
      final codeToCheck = caseSensitive ? normalizedCode : normalizedCode.toLowerCase();
      
      if (!codeToCheck.contains(ruleToCheck)) {
        failedRules.add(rule);
      }
    }
    
    if (failedRules.isEmpty) {
      return ValidationResult(
        isCorrect: true,
        feedback: 'Excellent! Your code meets all requirements.',
      );
    } else {
      return ValidationResult(
        isCorrect: false,
        feedback: 'Missing required elements: ${failedRules.join(", ")}',
        missingElements: failedRules,
      );
    }
  }
  
  /// Validates code with custom validation function
  static ValidationResult validateWithCustomCheck({
    required String userCode,
    required bool Function(String code) validator,
    String successMessage = 'Correct!',
    String errorMessage = 'Not quite right.',
  }) {
    final normalizedCode = _normalizeCode(userCode);
    final isCorrect = validator(normalizedCode);
    
    return ValidationResult(
      isCorrect: isCorrect,
      feedback: isCorrect ? successMessage : errorMessage,
    );
  }
  
  /// Checks if code matches a specific pattern (using contains check)
  static bool containsPattern(String code, String pattern, {bool caseSensitive = false}) {
    final codeToCheck = caseSensitive ? code : code.toLowerCase();
    final patternToCheck = caseSensitive ? pattern : pattern.toLowerCase();
    return codeToCheck.contains(patternToCheck);
  }
  
  /// Checks if code contains all required keywords
  static bool containsAllKeywords(String code, List<String> keywords, {bool caseSensitive = false}) {
    final normalizedCode = _normalizeCode(code);
    final codeToCheck = caseSensitive ? normalizedCode : normalizedCode.toLowerCase();
    
    for (final keyword in keywords) {
      final keywordToCheck = caseSensitive ? keyword : keyword.toLowerCase();
      if (!codeToCheck.contains(keywordToCheck)) {
        return false;
      }
    }
    
    return true;
  }
  
  /// Normalizes code by removing excessive whitespace
  static String _normalizeCode(String code) {
    return code
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .join('\n')
        .trim();
  }
  
  /// Extracts blanks from template code (e.g., "______")
  static List<String> extractBlanks(String templateCode) {
    final blanks = <String>[];
    final blankPattern = RegExp(r'_{2,}');
    final matches = blankPattern.allMatches(templateCode);
    
    for (final match in matches) {
      blanks.add(match.group(0)!);
    }
    
    return blanks;
  }
  
  /// Replaces blanks in template with user answers
  static String fillBlanks(String templateCode, List<String> answers) {
    String result = templateCode;
    final blanks = extractBlanks(templateCode);
    
    for (int i = 0; i < blanks.length && i < answers.length; i++) {
      result = result.replaceFirst(blanks[i], answers[i]);
    }
    
    return result;
  }
}

/// Result of code validation
class ValidationResult {
  final bool isCorrect;
  final String feedback;
  final List<String>? missingElements;
  
  const ValidationResult({
    required this.isCorrect,
    required this.feedback,
    this.missingElements,
  });
  
  @override
  String toString() {
    return 'ValidationResult(isCorrect: $isCorrect, feedback: $feedback)';
  }
}

/// Example usage and test cases
class CodeValidationExamples {
  /// Example 1: Simple keyword validation
  static void example1() {
    final result = CodeValidationService.validateCode(
      userCode: '''
        void main() {
          runApp(MyApp());
        }
      ''',
      correctAnswer: 'runApp',
    );
    
    print('Example 1: ${result.isCorrect}'); // true
  }
  
  /// Example 2: Multiple validation rules
  static void example2() {
    final result = CodeValidationService.validateCode(
      userCode: '''
        class MyApp extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return MaterialApp();
          }
        }
      ''',
      validationRules: ['StatelessWidget', 'MaterialApp', 'build'],
    );
    
    print('Example 2: ${result.isCorrect}'); // true
  }
  
  /// Example 3: Custom validation
  static void example3() {
    final result = CodeValidationService.validateWithCustomCheck(
      userCode: 'Container(child: Text("Hello"))',
      validator: (code) => code.contains('Container') && code.contains('Text'),
      successMessage: 'Great! You used both Container and Text widgets.',
      errorMessage: 'Make sure to use both Container and Text widgets.',
    );
    
    print('Example 3: ${result.isCorrect}'); // true
  }
  
  /// Example 4: Fill in the blanks
  static void example4() {
    final template = '''
      void main() {
        ______(MyApp());
      }
    ''';
    
    final userAnswers = ['runApp'];
    final filledCode = CodeValidationService.fillBlanks(template, userAnswers);
    
    final result = CodeValidationService.validateCode(
      userCode: filledCode,
      correctAnswer: 'runApp',
    );
    
    print('Example 4: ${result.isCorrect}'); // true
    print('Filled code:\n$filledCode');
  }
}
