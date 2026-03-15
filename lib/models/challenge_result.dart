// Result model for challenge evaluation
// Represents the outcome of evaluating user code against challenge requirements.
// Includes success status, error messages, and additional metadata.

/// Type of error detected in the challenge
enum ChallengeErrorType {
  structureError,    // Widget tree structure issue
  syntaxError,       // Flutter code error
  validationError,   // Challenge requirements not met
  none,              // No error
}

/// Result of challenge evaluation
/// 
/// Contains all information about whether the user's code passes
/// the challenge, and if not, what went wrong and how to fix it.
class ChallengeResult {
  /// Whether the challenge was completed successfully
  final bool success;
  
  /// Error message if challenge failed
  final String? message;
  
  /// Type of error detected
  final ChallengeErrorType errorType;
  
  /// Smart hint for this error (optional)
  final String? smartHint;
  
  /// Quick fix suggestion (optional)
  final String? quickFix;
  
  /// Learning tip related to the error (optional)
  final String? learningTip;

  /// Code quality improvement tips (optional)
  /// 
  /// Provided when code passes validation but could be improved
  /// Example: ["Consider adding const before Text", "Extract magic numbers to constants"]
  final List<String> qualityTips;

  /// Private constructor
  ChallengeResult._({
    required this.success,
    this.message,
    this.errorType = ChallengeErrorType.none,
    this.smartHint,
    this.quickFix,
    this.learningTip,
    this.qualityTips = const [],
  });

  /// Create a successful result
  /// 
  /// Used when the user's code passes all validation checks
  /// Optionally includes quality improvement tips
  factory ChallengeResult.success({List<String> qualityTips = const []}) {
    return ChallengeResult._(
      success: true,
      message: null,
      errorType: ChallengeErrorType.none,
      qualityTips: qualityTips,
    );
  }

  /// Create a structure error result
  /// 
  /// Used when code has widget tree structure issues
  /// Example: Container(children: [...]) instead of Container(child: ...)
  factory ChallengeResult.structureError(String message) {
    return ChallengeResult._(
      success: false,
      message: message,
      errorType: ChallengeErrorType.structureError,
    );
  }

  /// Create a syntax error result
  /// 
  /// Used when code has Flutter syntax mistakes
  /// Example: Row(child: ...) instead of Row(children: [...])
  factory ChallengeResult.syntaxError(
    String message, {
    String? smartHint,
    String? quickFix,
    String? learningTip,
  }) {
    return ChallengeResult._(
      success: false,
      message: message,
      errorType: ChallengeErrorType.syntaxError,
      smartHint: smartHint,
      quickFix: quickFix,
      learningTip: learningTip,
    );
  }

  /// Create a validation error result
  /// 
  /// Used when code doesn't meet challenge requirements
  /// Example: Missing required widget or property
  factory ChallengeResult.validationError(String message) {
    return ChallengeResult._(
      success: false,
      message: message,
      errorType: ChallengeErrorType.validationError,
    );
  }

  /// Create a generic error result
  /// 
  /// Used for backward compatibility or unknown errors
  factory ChallengeResult.error(String message) {
    return ChallengeResult._(
      success: false,
      message: message,
      errorType: ChallengeErrorType.validationError,
    );
  }


  /// Whether this result contains quality tips
  bool get hasQualityTips => qualityTips.isNotEmpty;
  /// Whether this result contains hints
  bool get hasHints => smartHint != null || quickFix != null || learningTip != null;

  /// Get a user-friendly title for the error type
  String get errorTitle {
    switch (errorType) {
      case ChallengeErrorType.structureError:
        return 'Structure Issue';
      case ChallengeErrorType.syntaxError:
        return 'Error Detected';
      case ChallengeErrorType.validationError:
        return 'Not Quite Right';
      case ChallengeErrorType.none:
        return 'Success';
    }
  }

  @override
  String toString() {
    if (success) {
      return 'ChallengeResult.success()';
    }
    return 'ChallengeResult.error(type: $errorType, message: $message)';
  }
}
