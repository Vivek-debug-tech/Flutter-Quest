/// XP calculation utilities for challenge completion
/// 
/// Calculates XP earned based on hints used and mistakes made.
/// Implements a deduction system that rewards players who complete
/// challenges with fewer hints.

class XPCalculator {
  /// Base XP for completing a challenge
  static const int baseXP = 60;

  /// Calculate XP earned based on hints used
  /// 
  /// Deduction rules:
  /// - 0 hints → 60 XP (full points)
  /// - 1 hint  → 50 XP (-10 points)
  /// - 2 hints → 30 XP (-30 points)
  /// - 3 hints → 10 XP (-50 points)
  /// 
  /// Returns the final XP amount
  static int calculateXP(int hintsUsed) {
    switch (hintsUsed) {
      case 0:
        return 60; // Perfect! No hints used
      case 1:
        return 50; // Good! Only one hint
      case 2:
        return 30; // Okay! Two hints
      case 3:
        return 10; // Completed with all hints
      default:
        return hintsUsed > 3 ? 10 : 60; // Safety check
    }
  }

  /// Calculate star rating based on hints used
  /// 
  /// Star rules:
  /// - 0 hints → ⭐⭐⭐ (3 stars)
  /// - 1 hint  → ⭐⭐ (2 stars)
  /// - 2+ hints → ⭐ (1 star)
  static int calculateStars(int hintsUsed) {
    if (hintsUsed == 0) {
      return 3; // Perfect performance
    } else if (hintsUsed == 1) {
      return 2; // Good performance
    } else {
      return 1; // Completed
    }
  }

  /// Get the XP deduction amount for a given number of hints
  static int getHintPenalty(int hintsUsed) {
    return baseXP - calculateXP(hintsUsed);
  }

  /// Get descriptive text for the performance
  static String getPerformanceText(int hintsUsed) {
    switch (hintsUsed) {
      case 0:
        return 'Perfect! Solved without hints!';
      case 1:
        return 'Great job! Only needed one hint.';
      case 2:
        return 'Good effort! You completed it!';
      case 3:
        return 'Nice work! Keep practicing!';
      default:
        return 'Challenge completed!';
    }
  }

  /// Get star description text
  static String getStarDescription(int stars) {
    switch (stars) {
      case 3:
        return 'Outstanding!';
      case 2:
        return 'Excellent!';
      case 1:
        return 'Good!';
      default:
        return 'Completed!';
    }
  }

  /// Calculate bonus XP for completing without mistakes
  /// This can be added to the base calculation
  static int getMistakeFreeBonus(int mistakesMade) {
    return mistakesMade == 0 ? 10 : 0;
  }

  /// Calculate total XP including mistake bonus
  static int calculateTotalXP(int hintsUsed, int mistakesMade) {
    int baseXP = calculateXP(hintsUsed);
    int bonus = getMistakeFreeBonus(mistakesMade);
    return baseXP + bonus;
  }

  /// Get breakdown of XP calculation for display
  static Map<String, int> getXPBreakdown(int hintsUsed, int mistakesMade) {
    return {
      'base': calculateXP(hintsUsed),
      'hintPenalty': getHintPenalty(hintsUsed),
      'mistakeBonus': getMistakeFreeBonus(mistakesMade),
      'total': calculateTotalXP(hintsUsed, mistakesMade),
    };
  }

  /// Check if performance deserves a perfect score badge
  static bool isPerfectScore(int hintsUsed, int mistakesMade) {
    return hintsUsed == 0 && mistakesMade == 0;
  }

  /// Get motivational message based on performance
  static String getMotivationalMessage(int hintsUsed, int mistakesMade) {
    if (isPerfectScore(hintsUsed, mistakesMade)) {
      return '🏆 Perfect Score! You\'re a Flutter master!';
    } else if (hintsUsed == 0) {
      return '🌟 Solved without hints! Amazing!';
    } else if (hintsUsed == 1 && mistakesMade == 0) {
      return '✨ Great work! Nearly perfect!';
    } else if (mistakesMade == 0) {
      return '👏 No mistakes! Keep it up!';
    } else {
      return '💪 You did it! Keep learning!';
    }
  }

  /// Get color for XP display based on performance
  static String getXPColor(int hintsUsed) {
    switch (hintsUsed) {
      case 0:
        return '#FFD700'; // Gold
      case 1:
        return '#C0C0C0'; // Silver
      case 2:
        return '#CD7F32'; // Bronze
      default:
        return '#4CAF50'; // Green
    }
  }
}
