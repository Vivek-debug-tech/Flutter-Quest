/// Manages the progressive hint system for challenges
/// 
/// Provides a 3-level hint system that progressively reveals more information:
/// - Level 1: Conceptual hint about what to do
/// - Level 2: Syntax hint showing structure
/// - Level 3: Full answer or near-complete solution

class HintManager {
  final List<String> _hints;
  int _currentHintIndex = 0;
  int _hintsUsed = 0;

  /// Maximum number of hints allowed
  static const int maxHints = 3;

  HintManager(this._hints) {
    // Ensure we have exactly 3 hints, pad with generic hints if needed
    while (_hints.length < maxHints) {
      _hints.add('Try reviewing the lesson content for clues.');
    }
    
    // Limit to max hints if more are provided
    if (_hints.length > maxHints) {
      _hints.removeRange(maxHints, _hints.length);
    }
  }

  /// Get the next available hint
  /// 
  /// Returns null if no more hints are available
  String? getNextHint() {
    if (!hasMoreHints()) {
      return null;
    }

    String hint = _hints[_currentHintIndex];
    _currentHintIndex++;
    _hintsUsed++;
    
    return hint;
  }

  /// Check if more hints are available
  bool hasMoreHints() {
    return _currentHintIndex < _hints.length && _currentHintIndex < maxHints;
  }

  /// Get the number of hints used so far
  int get hintsUsed => _hintsUsed;

  /// Get the current hint index (0-based)
  int get currentHintIndex => _currentHintIndex;

  /// Get total available hints
  int get totalHints => maxHints;

  /// Get remaining hints
  int get remainingHints => maxHints - _hintsUsed;

  /// Get hint display text (e.g., "Hint 1/3", "Hint 2/3")
  String getHintDisplayText() {
    return 'Hint $_currentHintIndex/$maxHints';
  }

  /// Get button text for hint button
  String getHintButtonText() {
    if (_hintsUsed == 0) {
      return 'Get Hint (${remainingHints} available)';
    } else if (hasMoreHints()) {
      return 'Get Hint (${remainingHints} left)';
    } else {
      return 'No more hints';
    }
  }

  /// Check if all hints have been used
  bool get allHintsUsed => _hintsUsed >= maxHints;

  /// Reset the hint manager (for retrying challenge)
  void reset() {
    _currentHintIndex = 0;
    _hintsUsed = 0;
  }

  /// Get a preview of what level the next hint is
  String? getNextHintLevel() {
    if (!hasMoreHints()) return null;

    switch (_currentHintIndex) {
      case 0:
        return 'Concept Hint';
      case 1:
        return 'Syntax Hint';
      case 2:
        return 'Full Answer';
      default:
        return 'Hint';
    }
  }

  /// Create a default hint manager with generic hints
  static HintManager createDefault() {
    return HintManager([
      'Think about the basic structure of a Flutter app.',
      'Look at the syntax examples in the lesson.',
      'Check the expected code format carefully.',
    ]);
  }

  /// Create a hint manager for the "Hello Flutter" challenge
  static HintManager createForHelloFlutter() {
    return HintManager([
      'Every Flutter app starts with a main() function. Look at what function launches the app.',
      'You should call runApp() inside main() to start the widget tree.',
      'void main() {\n  runApp(MyApp());\n}',
    ]);
  }

  /// Get hint XP penalty based on hints used
  static int getXPPenalty(int hintsUsed) {
    switch (hintsUsed) {
      case 0:
        return 0; // No penalty
      case 1:
        return 10; // -10 XP
      case 2:
        return 30; // -30 XP
      case 3:
        return 50; // -50 XP
      default:
        return 50; // Maximum penalty
    }
  }
}
