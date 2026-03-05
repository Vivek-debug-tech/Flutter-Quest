/// =============================================================================
/// HINT SYSTEM DOCUMENTATION
/// =============================================================================
/// 
/// This document explains the hint system implementation in the Flutter
/// learning game challenge engine.
///
/// OVERVIEW:
/// The hint system provides progressive assistance to users during challenges,
/// with each hint reducing earned XP. After 2 hints, stronger guidance is
/// provided visually.
///
/// =============================================================================

/// KEY FEATURES:
/// ============
/// 
/// 1. MULTIPLE HINTS PER STEP
///    - Each ChallengeStep can have a list of hints
///    - Hints are revealed one at a time
///    - All revealed hints remain visible
///
/// 2. XP PENALTY SYSTEM
///    - Each hint costs 5 XP
///    - Penalty is deducted from total XP calculation
///    - Displayed in XP breakdown
///
/// 3. PROGRESSIVE HINT STRENGTH
///    - First 2 hints: Gentle guidance (yellow theme)
///    - After 2 hints: Stronger hints (orange theme with label)
///    - Visual indicator shows hint strength
///
/// 4. TRACKING AND STATE
///    - Total hints used tracked globally
///    - Hints used per step tracked individually
///    - State resets when moving between steps
///
/// =============================================================================

import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../models/level_model_v2.dart';
import '../engine/challenge_engine.dart';
import '../widgets/hint_widget.dart';

/// IMPLEMENTATION GUIDE
/// ===================

/// STEP 1: ADD HINTS TO CHALLENGE STEPS
/// -------------------------------------
/// When creating ChallengeStep objects, add hints in progressive order:
/// 
/// Example:
void exampleCreateChallengeWithHints() {
  const step = ChallengeStep(
    id: 'step1',
    stepNumber: 1,
    type: ChallengeType.multipleChoice,
    question: 'What widget creates vertical layout?',
    options: [
      OptionModel(id: '1', text: 'Row', isCorrect: false),
      OptionModel(id: '2', text: 'Column', isCorrect: true),
      OptionModel(id: '3', text: 'Stack', isCorrect: false),
    ],
    xpReward: 15,
    
    // Progressive hints: gentle → specific → strong
    hints: [
      'Think about vertical vs horizontal layouts.',
      'Row arranges items horizontally, so what arranges them vertically?',
      'The answer rhymes with "solemn".',
      'FINAL HINT: It starts with "Col" and ends with "umn".',
    ],
    
    explanation: 'Column arranges children vertically from top to bottom.',
  );
  
  // Use the step in a level
  print('Created challenge step: ${step.id} with ${step.hints.length} hints');
}

/// STEP 2: USING THE CHALLENGE ENGINE HINT METHODS
/// -----------------------------------------------
/// The ChallengeEngine provides several hint-related methods:

void exampleEngineHintMethods() {
  // Example engine usage
  final engine = ChallengeEngine(level: exampleLevel);
  
  // Check if current step has hints
  if (engine.hasHints()) {
    print('Hints available!');
  }
  
  // Check if more hints can be revealed
  if (engine.hasMoreHints()) {
    // Get the next hint (increments count and returns hint text)
    final hint = engine.getNextHint();
    print('Hint: $hint');
  }
  
  // Get number of hints used for current step
  final hintsUsed = engine.getHintsUsedForCurrentStep();
  print('Hints used: $hintsUsed');
  
  // Get total hints available for current step
  final totalHints = engine.currentStep.hints.length;
  print('Total hints: $totalHints');
  
  // XP penalty is automatically calculated
  final xpBreakdown = engine.getXPBreakdown();
  print('Hint penalty: -${xpBreakdown.hintPenalty} XP');
}

/// STEP 3: DISPLAYING HINTS IN UI
/// ------------------------------
/// Use the HintWidget to display hints with rich UI:

class ExampleHintUI extends StatefulWidget {
  final ChallengeEngine engine;

  const ExampleHintUI({Key? key, required this.engine}) : super(key: key);

  @override
  State<ExampleHintUI> createState() => _ExampleHintUIState();
}

class _ExampleHintUIState extends State<ExampleHintUI> {
  List<String> _displayedHints = [];

  void _requestHint() {
    final hint = widget.engine.getNextHint();
    if (hint != null) {
      setState(() {
        _displayedHints.add(hint);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return HintWidget(
      displayedHints: _displayedHints,
      totalHintsAvailable: widget.engine.currentStep.hints.length,
      hintsUsed: widget.engine.getHintsUsedForCurrentStep(),
      hasMoreHints: widget.engine.hasMoreHints(),
      onRequestHint: _requestHint,
      xpPenaltyPerHint: 5,
    );
  }
}

/// STEP 4: COMPACT HINT BUTTON
/// ---------------------------
/// Use HintButton for inline hint access:

class ExampleCompactHintButton extends StatelessWidget {
  final ChallengeEngine engine;
  final VoidCallback onHintRequested;

  const ExampleCompactHintButton({
    Key? key,
    required this.engine,
    required this.onHintRequested,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HintButton(
      onPressed: onHintRequested,
      hasMoreHints: engine.hasMoreHints(),
      hintsUsed: engine.getHintsUsedForCurrentStep(),
      totalHints: engine.currentStep.hints.length,
      xpPenalty: 5,
    );
  }
}

/// =============================================================================
/// XP CALCULATION WITH HINTS
/// =============================================================================

/// The XP calculation formula includes hint penalty:
/// 
/// Total XP = Base XP + Steps XP + Accuracy Bonus - Hint Penalty
/// 
/// Where:
/// - Base XP: Level's base reward
/// - Steps XP: Sum of completed step rewards
/// - Accuracy Bonus: 0 mistakes = full bonus, 1-2 mistakes = 50% bonus
/// - Hint Penalty: 5 XP per hint used
///
/// Example calculation:
/// Base XP:         50
/// Steps XP:       +30  (3 steps × 10 XP each)
/// Accuracy Bonus: +20  (no mistakes)
/// Hint Penalty:   -15  (3 hints × 5 XP)
/// ─────────────────
/// Total XP:        85

/// =============================================================================
/// PROGRESSIVE HINT SYSTEM
/// =============================================================================

/// HINT DESIGN GUIDELINES:
/// 
/// 1. HINT 1 (Gentle):
///    - Broad conceptual guidance
///    - Points in right direction without revealing answer
///    Example: "Think about which layout arranges items vertically"
///
/// 2. HINT 2 (Moderate):
///    - More specific clues
///    - Narrows down options
///    Example: "Row is horizontal, Column is..."
///
/// 3. HINT 3+ (Strong):
///    - Very specific guidance
///    - May include partial answer
///    - Marked with orange theme and "STRONGER HINT" label
///    Example: "The answer starts with 'Col' and has 6 letters"
///
/// 4. FINAL HINT (Strongest):
///    - Nearly reveals the answer
///    - Used as last resort
///    Example: "The answer is 'Column'"

/// =============================================================================
/// BEST PRACTICES
/// =============================================================================

/// DO:
/// ✓ Provide 3-5 hints per challenge
/// ✓ Make first hints conceptual and educational
/// ✓ Make later hints more direct
/// ✓ Clear displayed hints when moving between steps
/// ✓ Show hint penalty in snackbar when hint is used
/// ✓ Update XP calculations to include hint penalty
///
/// DON'T:
/// ✗ Give away the answer in first hint
/// ✗ Make all hints equally specific
/// ✗ Forget to track hint usage per step
/// ✗ Hide hint penalty from user
/// ✗ Allow infinite hints
/// ✗ Make hints too vague to be helpful

/// =============================================================================
/// INTEGRATION CHECKLIST
/// =============================================================================

/// When adding hint system to a new challenge screen:
/// 
/// □ 1. Import hint_widget.dart
/// □ 2. Add List<String> _displayedHints = [] to state
/// □ 3. Create _handleHint() method that calls engine.getNextHint()
/// □ 4. Add HintWidget to UI with proper parameters
/// □ 5. Clear _displayedHints when moving between steps
/// □ 6. Clear _displayedHints on reset
/// □ 7. Show hint penalty in snackbar/notification
/// □ 8. Test with multiple hints
/// □ 9. Verify XP calculation includes penalty
/// □ 10. Test hint exhaustion (no more hints available)

/// =============================================================================
/// CUSTOMIZATION OPTIONS
/// =============================================================================

/// The hint system can be customized:
///
/// 1. XP PENALTY
///    Change xpPenaltyPerHint parameter in HintWidget
///    Update calculation in ChallengeEngine (line 271 & 295)
///
/// 2. PROGRESSIVE HINT THRESHOLD
///    Change isStrongerHint = index >= 2 in HintWidget (line 114)
///    Currently triggers after 2 hints (0-indexed: hints 3+)
///
/// 3. VISUAL STYLING
///    Modify colors in HintWidget:
///    - Gentle hints: amber theme
///    - Strong hints: orange theme
///    - Modify gradients, borders, and shadows
///
/// 4. HINT BUTTON PLACEMENT
///    HintWidget: Full-featured card with all hints
///    HintButton: Compact button for inline use
///    Place either in challenge UI as needed

/// =============================================================================
/// TESTING THE HINT SYSTEM
/// =============================================================================

/// Run the hint system demo:
/// ```
/// flutter run lib/examples/hint_system_demo.dart
/// ```
///
/// This includes 4 demo scenarios:
/// 1. MCQ with 4 progressive hints
/// 2. Fill in the blank with 3 hints
/// 3. Fix the bug with 5 hints (showing progressive guidance)
/// 4. Build widget with 3 hints
///
/// Test checklist:
/// □ Hints display correctly
/// □ Progressive hint styling after 2nd hint
/// □ XP penalty shows in completion dialog
/// □ "No more hints" state works
/// □ Hints clear when moving to next step
/// □ Hints clear when resetting challenge
/// □ Snackbar shows when hint is used

/// =============================================================================
/// TROUBLESHOOTING
/// =============================================================================

/// ISSUE: Hints not showing
/// FIX: Ensure ChallengeStep has hints: [...] with content
///
/// ISSUE: Hint count not updating
/// FIX: Call setState() after engine.getNextHint()
///
/// ISSUE: XP penalty not applying
/// FIX: Check ChallengeEngine lines 271 & 295 have correct multiplier (5)
///
/// ISSUE: Hints don't clear between steps
/// FIX: Add _displayedHints = [] in navigation methods
///
/// ISSUE: "Stronger hint" label not showing
/// FIX: Need at least 3 hints, as it triggers on index >= 2

/// =============================================================================
/// API REFERENCE
/// =============================================================================

/// ChallengeEngine Methods:
/// ------------------------
/// bool hasHints()
///   Returns true if current step has any hints
///
/// String? getNextHint()
///   Returns next hint text and increments counter
///   Returns null if no more hints available
///
/// int getHintsUsedForCurrentStep()
///   Returns number of hints used for current step only
///
/// bool hasMoreHints()
///   Returns true if more hints can be revealed
///
/// XPBreakdown getXPBreakdown()
///   Returns breakdown including hintPenalty field

/// HintWidget Parameters:
/// ---------------------
/// displayedHints: List<String> - hints currently shown
/// totalHintsAvailable: int - total hints in current step
/// hintsUsed: int - hints used so far
/// hasMoreHints: bool - whether more hints can be revealed
/// onRequestHint: VoidCallback - called when "Get Hint" clicked
/// xpPenaltyPerHint: int - XP cost per hint (default: 5)

/// HintButton Parameters:
/// ---------------------
/// onPressed: VoidCallback - called when button pressed
/// hasMoreHints: bool - whether more hints available
/// hintsUsed: int - hints used so far
/// totalHints: int - total hints in step
/// xpPenalty: int - XP cost per hint (default: 5)

/// =============================================================================

// Dummy data for examples
final exampleLevel = LevelModel(
  id: 'example',
  worldId: 'world1',
  levelNumber: 1,
  title: 'Example Level',
  concept: 'Hint System',
  lessonText: 'Example lesson text',
  learningObjective: 'Learn how to use the hint system',
  difficulty: DifficultyLevel.beginner,
  baseXP: 50,
  bonusXP: 20,
  explanation: 'Example explanation',
  isLocked: false,
  challengeSteps: [],
);
