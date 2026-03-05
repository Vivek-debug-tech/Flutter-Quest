import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';

/// Core Challenge Engine - Manages challenge state and logic
/// Pure Dart class with no UI dependencies
class ChallengeEngine {
  final LevelModel level;
  
  // State tracking
  int _currentStepIndex = 0;
  int _mistakesCount = 0;
  int _hintsUsed = 0;
  final Map<String, bool> _stepCompletionStatus = {};
  final Map<String, int> _stepMistakes = {};
  final Map<String, int> _stepHints = {};
  
  ChallengeEngine({required this.level}) {
    _initializeSteps();
  }
  
  void _initializeSteps() {
    for (final step in level.challengeSteps) {
      _stepCompletionStatus[step.id] = false;
      _stepMistakes[step.id] = 0;
      _stepHints[step.id] = 0;
    }
  }
  
  // ============================================
  // GETTERS - Current State
  // ============================================
  
  ChallengeStep get currentStep => level.challengeSteps[_currentStepIndex];
  
  int get currentStepNumber => _currentStepIndex + 1;
  
  int get totalSteps => level.challengeSteps.length;
  
  int get mistakesCount => _mistakesCount;
  
  int get hintsUsed => _hintsUsed;
  
  double get progressPercentage => (_currentStepIndex / totalSteps) * 100;
  
  bool get isFirstStep => _currentStepIndex == 0;
  
  bool get isLastStep => _currentStepIndex == totalSteps - 1;
  
  bool get isComplete => _currentStepIndex >= totalSteps;
  
  int get completedStepsCount {
    return _stepCompletionStatus.values.where((completed) => completed).length;
  }
  
  // ============================================
  // NAVIGATION
  // ============================================
  
  bool canGoToNextStep() {
    return _currentStepIndex < totalSteps - 1;
  }
  
  bool canGoToPreviousStep() {
    return _currentStepIndex > 0;
  }
  
  void nextStep() {
    if (canGoToNextStep()) {
      _currentStepIndex++;
    }
  }
  
  void previousStep() {
    if (canGoToPreviousStep()) {
      _currentStepIndex--;
    }
  }
  
  void goToStep(int index) {
    if (index >= 0 && index < totalSteps) {
      _currentStepIndex = index;
    }
  }
  
  // ============================================
  // ANSWER VALIDATION
  // ============================================
  
  /// Validates user answer and returns result
  ChallengeResult validateAnswer(String userAnswer) {
    final step = currentStep;
    bool isCorrect = false;
    String feedback = '';
    
    switch (step.type) {
      case ChallengeType.multipleChoice:
        isCorrect = _validateMCQ(step, userAnswer);
        feedback = _getMCQFeedback(step, userAnswer);
        break;
        
      case ChallengeType.fillInBlank:
        isCorrect = _validateFillInBlank(step, userAnswer);
        feedback = isCorrect 
            ? 'Correct! ${step.explanation ?? ""}'
            : 'Not quite. Try again or use a hint!';
        break;
        
      case ChallengeType.arrangeCode:
        // Validate that user arranged code pieces in correct order
        isCorrect = _validateArrangeCode(step, userAnswer);
        feedback = isCorrect
            ? 'Perfect! ${step.explanation ?? ""}'
            : 'Not quite the right order. Try again!';
        break;
        
      case ChallengeType.fixTheBug:
        isCorrect = _validateFixTheBug(step, userAnswer);
        feedback = isCorrect
            ? 'Bug fixed! ${step.explanation ?? ""}'
            : 'The code still has issues. ${step.bugHint ?? ""}';
        break;
        
      case ChallengeType.buildWidget:
        isCorrect = _validateBuildWidget(step, userAnswer);
        feedback = isCorrect
            ? 'Widget built successfully! ${step.explanation ?? ""}'
            : 'The widget doesn\'t meet requirements yet.';
        break;

      case ChallengeType.interactiveCode:
        isCorrect = _validateFixTheBug(step, userAnswer);
        feedback = isCorrect
            ? 'Code is correct! ${step.explanation ?? ""}'
            : 'The code needs some adjustments. Try again!';
        break;
    }
    
    // Track mistakes
    if (!isCorrect) {
      _mistakesCount++;
      _stepMistakes[step.id] = (_stepMistakes[step.id] ?? 0) + 1;
    } else {
      _stepCompletionStatus[step.id] = true;
    }
    
    return ChallengeResult(
      isCorrect: isCorrect,
      feedback: feedback,
      currentStepCompleted: isCorrect,
    );
  }
  
  bool _validateMCQ(ChallengeStep step, String selectedOptionId) {
    if (step.options == null) return false;
    
    final selectedOption = step.options!.firstWhere(
      (opt) => opt.id == selectedOptionId,
      orElse: () => step.options!.first,
    );
    
    return selectedOption.isCorrect;
  }
  
  String _getMCQFeedback(ChallengeStep step, String selectedOptionId) {
    if (step.options == null) return '';
    
    final selectedOption = step.options!.firstWhere(
      (opt) => opt.id == selectedOptionId,
      orElse: () => step.options!.first,
    );
    
    return selectedOption.explanation ?? 
           (selectedOption.isCorrect ? 'Correct!' : 'Incorrect.');
  }
  
  bool _validateFillInBlank(ChallengeStep step, String answer) {
    if (step.correctAnswer == null) return false;
    
    // Case-sensitive comparison (can be adjusted)
    return step.correctAnswer!.trim() == answer.trim();
  }
  
  bool _validateFixTheBug(ChallengeStep step, String userCode) {
    if (step.validationRules == null || step.validationRules!.isEmpty) {
      // Basic check: code is not empty and different from broken code
      return userCode.trim().isNotEmpty && 
             userCode.trim() != (step.brokenCode?.trim() ?? '');
    }
    
    // Check all validation rules
    for (final rule in step.validationRules!) {
      if (!userCode.contains(rule)) {
        return false;
      }
    }
    
    return true;
  }
  
  bool _validateBuildWidget(ChallengeStep step, String userCode) {
    if (step.requiredWidgets == null || step.requiredWidgets!.isEmpty) {
      return userCode.trim().isNotEmpty;
    }
    
    // Check that all required widgets are present
    for (final widget in step.requiredWidgets!) {
      if (!userCode.contains(widget)) {
        return false;
      }
    }
    
    // Check validation rules if present
    if (step.validationRules != null) {
      for (final rule in step.validationRules!) {
        if (!userCode.contains(rule)) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  bool _validateArrangeCode(ChallengeStep step, String userAnswer) {
    if (step.correctOrder == null || step.correctOrder!.isEmpty) {
      return false;
    }
    
    // userAnswer should be comma-separated indices or joined string
    // Compare with the correct order
    return userAnswer == step.correctOrder!.join(',');
  }
  
  // ============================================
  // HINTS
  // ============================================
  
  bool hasHints() {
    return currentStep.hints.isNotEmpty;
  }
  
  String? getNextHint() {
    final step = currentStep;
    final currentHintIndex = _stepHints[step.id] ?? 0;
    
    if (currentHintIndex >= step.hints.length) {
      return null; // No more hints
    }
    
    _hintsUsed++;
    _stepHints[step.id] = currentHintIndex + 1;
    
    return step.hints[currentHintIndex];
  }
  
  int getHintsUsedForCurrentStep() {
    return _stepHints[currentStep.id] ?? 0;
  }
  
  bool hasMoreHints() {
    final step = currentStep;
    final currentHintIndex = _stepHints[step.id] ?? 0;
    return currentHintIndex < step.hints.length;
  }
  
  // ============================================
  // XP CALCULATION
  // ============================================
  
  /// Calculate total XP earned
  /// XP = BaseXP + ChallengeStepsXP + AccuracyBonus - HintPenalty
  int calculateTotalXP() {
    int totalXP = level.baseXP;
    
    // Add XP from completed steps
    int stepsXP = 0;
    for (final step in level.challengeSteps) {
      if (_stepCompletionStatus[step.id] == true) {
        stepsXP += step.xpReward;
      }
    }
    totalXP += stepsXP;
    
    // Accuracy bonus (no mistakes = full bonus)
    if (_mistakesCount == 0 && completedStepsCount == totalSteps) {
      totalXP += level.bonusXP;
    } else if (_mistakesCount <= 2 && completedStepsCount == totalSteps) {
      totalXP += (level.bonusXP * 0.5).toInt(); // 50% bonus for few mistakes
    }
    
    // Hint penalty (each hint costs 5 XP)
    int hintPenalty = _hintsUsed * 5;
    totalXP -= hintPenalty;
    
    // Ensure XP doesn't go negative
    return totalXP < 0 ? 0 : totalXP;
  }
  
  /// Get XP breakdown for display
  XPBreakdown getXPBreakdown() {
    int stepsXP = 0;
    for (final step in level.challengeSteps) {
      if (_stepCompletionStatus[step.id] == true) {
        stepsXP += step.xpReward;
      }
    }
    
    int accuracyBonus = 0;
    if (_mistakesCount == 0 && completedStepsCount == totalSteps) {
      accuracyBonus = level.bonusXP;
    } else if (_mistakesCount <= 2 && completedStepsCount == totalSteps) {
      accuracyBonus = (level.bonusXP * 0.5).toInt();
    }
    
    int hintPenalty = _hintsUsed * 5;
    
    return XPBreakdown(
      baseXP: level.baseXP,
      stepsXP: stepsXP,
      accuracyBonus: accuracyBonus,
      hintPenalty: hintPenalty,
      totalXP: calculateTotalXP(),
    );
  }
  
  // ============================================
  // STATISTICS
  // ============================================
  
  /// Get performance statistics
  ChallengeStats getStats() {
    return ChallengeStats(
      totalSteps: totalSteps,
      completedSteps: completedStepsCount,
      mistakesCount: _mistakesCount,
      hintsUsed: _hintsUsed,
      accuracyPercentage: _calculateAccuracy(),
    );
  }
  
  double _calculateAccuracy() {
    if (completedStepsCount == 0) return 0.0;
    
    int totalAttempts = completedStepsCount + _mistakesCount;
    if (totalAttempts == 0) return 0.0;
    
    return (completedStepsCount / totalAttempts) * 100;
  }
  
  // ============================================
  // RESET
  // ============================================
  
  void reset() {
    _currentStepIndex = 0;
    _mistakesCount = 0;
    _hintsUsed = 0;
    _stepCompletionStatus.clear();
    _stepMistakes.clear();
    _stepHints.clear();
    _initializeSteps();
  }
}

// ============================================
// RESULT CLASSES
// ============================================

class ChallengeResult {
  final bool isCorrect;
  final String feedback;
  final bool currentStepCompleted;
  
  const ChallengeResult({
    required this.isCorrect,
    required this.feedback,
    required this.currentStepCompleted,
  });
}

class XPBreakdown {
  final int baseXP;
  final int stepsXP;
  final int accuracyBonus;
  final int hintPenalty;
  final int totalXP;
  
  const XPBreakdown({
    required this.baseXP,
    required this.stepsXP,
    required this.accuracyBonus,
    required this.hintPenalty,
    required this.totalXP,
  });
  
  @override
  String toString() {
    return '''
Base XP: $baseXP
Steps XP: +$stepsXP
Accuracy Bonus: +$accuracyBonus
Hint Penalty: -$hintPenalty
─────────────────
Total XP: $totalXP
''';
  }
}

class ChallengeStats {
  final int totalSteps;
  final int completedSteps;
  final int mistakesCount;
  final int hintsUsed;
  final double accuracyPercentage;
  
  const ChallengeStats({
    required this.totalSteps,
    required this.completedSteps,
    required this.mistakesCount,
    required this.hintsUsed,
    required this.accuracyPercentage,
  });
}
