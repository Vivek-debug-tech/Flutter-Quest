/// MIGRATION GUIDE: Old Level Model → New Scalable Model
/// 
/// This guide shows how the old single-challenge model
/// evolved into the new multi-challenge scalable model.

// ============================================
// OLD MODEL (level_model.dart)
// ============================================

/*
class Level {
  final String id;
  final String title;
  final ChallengeType challengeType;      // ❌ Only ONE challenge type per level
  final String challengeDescription;      // ❌ Only ONE challenge
  final String expectedCode;
  final List<String> hints;
  final String explanation;
  final int baseXP;
  
  // Learning content was separate (lessonContent, guidedExample)
}
*/

// ============================================
// NEW MODEL (level_model_v2.dart + challenge_models.dart)
// ============================================

/*
class LevelModel {
  // Lesson Content (Built-in)
  final String lessonText;               // ✅ Main teaching content
  final String? codeExample;             // ✅ Example code
  final List<String> keyTakeaways;       // ✅ Key points
  final String? analogy;                 // ✅ Real-world comparison
  
  // Multiple Challenges
  final List<ChallengeStep> challengeSteps; // ✅ MULTIPLE challenges per level!
  
  // Each ChallengeStep can be different types:
  // - MultipleChoice with options
  // - FillInBlank with correct answer
  // - FixTheBug with broken/fixed code
  // - BuildWidget with requirements
  
  // Metadata
  final int baseXP;
  final int bonusXP;                     // ✅ Bonus for perfect completion
  final Duration? timeEstimate;          // ✅ Estimated completion time
  final List<String>? prerequisites;     // ✅ Required prior knowledge
}

class ChallengeStep {
  final ChallengeType type;              // ✅ Each step has its own type
  final String question;
  final int xpReward;                    // ✅ XP per challenge step
  final List<String> hints;              // ✅ Hints per step
  final String? explanation;             // ✅ Explanation per step
  
  // Type-specific fields
  final List<OptionModel>? options;      // For MCQ
  final String? correctAnswer;           // For FillInBlank
  final String? brokenCode;              // For FixTheBug
  final String? widgetRequirement;       // For BuildWidget
}
*/

// ============================================
// KEY IMPROVEMENTS
// ============================================

/// 1. FLEXIBILITY: Multiple challenge types per level
///    Old: 1 level = 1 challenge type
///    New: 1 level = multiple challenges of different types
///
/// 2. SCALABILITY: Easy to add new challenge types
///    Old: Adding types required modifying Level class
///    New: Add to ChallengeType enum + fields to ChallengeStep
///
/// 3. GRANULARITY: XP and hints per challenge step
///    Old: One XP value for entire level
///    New: Each step has its own XP reward
///
/// 4. STRUCTURE: Clean separation of concerns
///    Old: Lesson content in separate classes
///    New: Everything in one cohesive LevelModel
///
/// 5. ANALYTICS: Easy to track progress per step
///    Old: Level complete or not
///    New: Track completion of individual steps

// ============================================
// CONVERSION EXAMPLE
// ============================================

/*
// OLD: Single MCQ level
Level(
  id: 'w1_l1',
  title: 'Hello Flutter',
  challengeType: ChallengeType.multipleChoice,
  challengeDescription: 'What function starts your app?',
  baseXP: 50,
  hints: ['Hint 1', 'Hint 2'],
  explanation: 'Explanation here',
)

// NEW: Same level with multiple challenges
LevelModel(
  id: 'w1_l1',
  title: 'Hello Flutter',
  lessonText: 'Teaching content here...',
  codeExample: 'void main() { runApp(MyApp()); }',
  keyTakeaways: ['Point 1', 'Point 2'],
  challengeSteps: [
    // Step 1: MCQ about main()
    ChallengeStep(
      id: 'w1_l1_c1',
      stepNumber: 1,
      type: ChallengeType.multipleChoice,
      question: 'What is main()?',
      options: [...],
      xpReward: 20,
      hints: ['Hint for step 1'],
      explanation: 'Explanation for step 1',
    ),
    // Step 2: Fill in blank
    ChallengeStep(
      id: 'w1_l1_c2',
      stepNumber: 2,
      type: ChallengeType.fillInBlank,
      question: 'Complete: void main() { _____(); }',
      correctAnswer: 'runApp',
      xpReward: 15,
    ),
    // Step 3: Fix the bug
    ChallengeStep(
      id: 'w1_l1_c3',
      stepNumber: 3,
      type: ChallengeType.fixTheBug,
      question: 'Fix the broken code',
      brokenCode: '...',
      fixedCode: '...',
      xpReward: 25,
    ),
  ],
  baseXP: 50,
  bonusXP: 30,
  explanation: 'Overall level explanation',
)
*/

// ============================================
// USAGE PATTERNS
// ============================================

/// Pattern 1: Progressive difficulty within a level
/// Start with easy MCQ → FillInBlank → FixTheBug → BuildWidget

/// Pattern 2: Concept reinforcement
/// Teach concept → Test with MCQ → Apply with BuildWidget

/// Pattern 3: Debugging focused
/// Multiple FixTheBug challenges with increasing complexity

/// Pattern 4: Mixed practice
/// Random mix of all challenge types for review levels

// ============================================
// FUTURE EXTENSIONS
// ============================================

/// The new model supports easy addition of:
/// 
/// 1. New Challenge Types:
///    - DragAndDrop (order code lines)
///    - CodeCompletion (autocomplete practice)
///    - HotReload (modify running app)
///    - UIMatch (recreate given design)
///    - PerformanceChallenge (optimize code)
///
/// 2. New Metadata:
///    - tags: ['widgets', 'layout', 'state']
///    - videoUrl: Link to tutorial video
///    - communityRating: User ratings
///    - attemptCount: Tracking difficulty
///
/// 3. Adaptive Learning:
///    - dynamicDifficulty: Adjust based on performance
///    - personalizedHints: Based on user's weak areas
///    - skipPrerequisites: For advanced users
///
/// 4. Gamification:
///    - achievements: Unlock badges
///    - leaderboards: Compare with others
///    - streaks: Daily challenge completion
///    - powerups: Hint multipliers, XP boosts

// ============================================
// BACKWARD COMPATIBILITY
// ============================================

/// To support old Level class in existing code:

/*
extension LevelToLevelModel on Level {
  LevelModel toNewModel() {
    return LevelModel(
      id: id,
      worldId: worldId,
      levelNumber: levelNumber,
      title: title,
      concept: concept,
      lessonText: lessonContent?.conceptExplanation ?? explanation,
      codeExample: lessonContent?.codeExample ?? expectedCode,
      learningObjective: learningObjective,
      keyTakeaways: lessonContent?.keyPoints ?? [],
      challengeSteps: [
        // Convert single challenge to one step
        ChallengeStep(
          id: '${id}_c1',
          stepNumber: 1,
          type: challengeType,
          question: challengeDescription,
          xpReward: baseXP,
          hints: hints,
          explanation: explanation,
        ),
      ],
      baseXP: baseXP,
      explanation: explanation,
      difficulty: difficulty,
      isLocked: isLocked,
    );
  }
}
*/

// ============================================
// RECOMMENDED TIMELINE
// ============================================

/// Phase 1: Create new models (✅ DONE)
/// - challenge_models.dart
/// - level_model_v2.dart
/// - sample_level_data.dart
///
/// Phase 2: Create utilities (✅ DONE)
/// - level_data_utils.dart
/// - data_model_usage_example.dart
///
/// Phase 3: Update UI (TODO)
/// - Create new challenge screens for each type
/// - Update level screen to iterate through steps
/// - Add progress tracking UI
///
/// Phase 4: Migrate data (TODO)
/// - Convert worlds_data.dart to new format
/// - Create levels for all worlds using new model
///
/// Phase 5: Update services (TODO)
/// - progress_service.dart → track per-step completion
/// - storage_service.dart → save step progress
/// - xp_service.dart → calculate per-step XP
///
/// Phase 6: Testing (TODO)
/// - Test all challenge types
/// - Validate XP calculations
/// - Test progress tracking
///
/// Phase 7: Cleanup (TODO)
/// - Remove old level_model.dart
/// - Remove lesson_content_model.dart
/// - Update all imports

// ============================================
// SUMMARY
// ============================================

/// The new model provides:
/// ✅ Multiple challenges per level
/// ✅ Mixed challenge types
/// ✅ Granular XP rewards
/// ✅ Better progress tracking
/// ✅ Easier to extend
/// ✅ Clean data structure
/// ✅ No UI code in models
/// ✅ JSON serialization ready
/// ✅ Backward compatible (with extension)
/// ✅ Future-proof architecture
