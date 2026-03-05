/// EXAMPLE: How to use the new scalable Level data model
/// 
/// This file demonstrates best practices for working with:
/// - LevelModel
/// - ChallengeStep  
/// - OptionModel
/// - LevelDataUtils
///
/// Copy these patterns when creating new levels or challenge types.

import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../data/sample_level_data.dart';
import '../utils/level_data_utils.dart';

void main() {
  // ============================================
  // EXAMPLE 1: Loading and inspecting a level
  // ============================================
  
  final level = SampleLevelData.getWorld1Level1();
  
  print('📚 Level: ${level.title}');
  print('🎯 Concept: ${level.concept}');
  print('⭐ Difficulty: ${level.difficulty.name}');
  print('💰 Total XP: ${level.totalPossibleXP}');
  print('🎮 Challenges: ${level.totalChallenges}');
  print('');
  
  // ============================================
  // EXAMPLE 2: Iterating through challenges
  // ============================================
  
  print('📝 Challenge Breakdown:');
  for (final challenge in level.challengeSteps) {
    final icon = LevelDataUtils.getChallengeTypeIcon(challenge.type);
    final name = LevelDataUtils.getChallengeTypeName(challenge.type);
    print('  $icon Step ${challenge.stepNumber}: $name (${challenge.xpReward} XP)');
  }
  print('');
  
  // ============================================
  // EXAMPLE 3: Working with MCQ challenges
  // ============================================
  
  final mcqChallenges = LevelDataUtils.getMCQChallenges(level);
  print('🎯 MCQ Challenges Found: ${mcqChallenges.length}');
  
  if (mcqChallenges.isNotEmpty) {
    final firstMCQ = mcqChallenges.first;
    print('Question: ${firstMCQ.question}');
    print('Options:');
    
    for (final option in firstMCQ.options ?? []) {
      final marker = option.isCorrect ? '✅' : '❌';
      print('  $marker ${option.text}');
    }
  }
  print('');
  
  // ============================================
  // EXAMPLE 4: Tracking progress
  // ============================================
  
  // Simulate user completing some challenges
  final completedSteps = <String>{
    'w1_l1_c1', // Completed step 1
    'w1_l1_c2', // Completed step 2
  };
  
  final progress = LevelDataUtils.calculateProgress(level, completedSteps);
  print('📊 Progress: ${progress.toStringAsFixed(1)}%');
  
  final earnedXP = LevelDataUtils.calculateEarnedXP(
    level,
    completedSteps,
    false, // Not perfect completion
  );
  print('💎 XP Earned: $earnedXP / ${level.totalPossibleXP}');
  
  final isComplete = LevelDataUtils.isLevelComplete(level, completedSteps);
  print('✅ Level Complete: $isComplete');
  print('');
  
  // ============================================
  // EXAMPLE 5: Getting next challenge
  // ============================================
  
  final nextChallenge = LevelDataUtils.getNextChallenge(level, completedSteps);
  if (nextChallenge != null) {
    print('➡️  Next Challenge:');
    print('   Step ${nextChallenge.stepNumber}: ${nextChallenge.question}');
    print('   Type: ${LevelDataUtils.getChallengeTypeName(nextChallenge.type)}');
  }
  print('');
  
  // ============================================
  // EXAMPLE 6: Validating answers
  // ============================================
  
  final fillInBlankChallenge = level.challengeSteps.firstWhere(
    (step) => step.type == ChallengeType.fillInBlank,
  );
  
  print('💡 Testing Answer Validation:');
  print('Question: ${fillInBlankChallenge.question}');
  
  final testAnswers = ['runApp', 'RunApp', 'run', 'main'];
  for (final answer in testAnswers) {
    final isCorrect = LevelDataUtils.validateAnswer(
      fillInBlankChallenge,
      answer,
    );
    final marker = isCorrect ? '✅' : '❌';
    print('  $marker "$answer" -> ${isCorrect ? "Correct!" : "Wrong"}');
  }
  print('');
  
  // ============================================
  // EXAMPLE 7: Analytics - Challenge distribution
  // ============================================
  
  final distribution = LevelDataUtils.getChallengeTypeDistribution(level);
  print('📊 Challenge Type Distribution:');
  distribution.forEach((type, count) {
    final name = LevelDataUtils.getChallengeTypeName(type);
    print('  • $name: $count');
  });
  print('');
  
  // ============================================
  // EXAMPLE 8: Level summary
  // ============================================
  
  print(LevelDataUtils.getLevelSummary(level));
  
  // ============================================
  // EXAMPLE 9: Creating a custom level
  // ============================================
  
  final customLevel = LevelModel(
    id: 'custom_1',
    worldId: 'world_1',
    levelNumber: 99,
    title: 'Custom Challenge',
    concept: 'Putting it all together',
    lessonText: 'This is a custom level demonstrating the flexibility of the model.',
    learningObjective: 'Master all challenge types',
    challengeSteps: [
      // You can mix and match any challenge types!
      ChallengeStep(
        id: 'custom_c1',
        stepNumber: 1,
        type: ChallengeType.multipleChoice,
        question: 'What is Flutter?',
        options: [
          OptionModel(
            id: 'c1',
            text: 'A UI framework',
            isCorrect: true,
          ),
          OptionModel(
            id: 'c2',
            text: 'A database',
            isCorrect: false,
          ),
        ],
      ),
      ChallengeStep(
        id: 'custom_c2',
        stepNumber: 2,
        type: ChallengeType.buildWidget,
        question: 'Build a Container with blue background',
        widgetRequirement: 'Container with color',
        requiredWidgets: ['Container', 'Color'],
        expectedOutput: 'A blue container',
      ),
    ],
    baseXP: 100,
    explanation: 'Great job!',
    isLocked: false,
  );
  
  print('🎨 Custom Level Created:');
  print('   Title: ${customLevel.title}');
  print('   Challenges: ${customLevel.totalChallenges}');
  print('   Total XP: ${customLevel.totalPossibleXP}');
}

// ============================================
// EXTENDING THE MODEL: Add new challenge types
// ============================================

/// To add a new challenge type:
/// 
/// 1. Add to ChallengeType enum in challenge_models.dart:
///    enum ChallengeType {
///      multipleChoice,
///      fillInBlank,
///      fixTheBug,
///      buildWidget,
///      dragAndDrop,  // NEW!
///    }
/// 
/// 2. Add relevant fields to ChallengeStep class:
///    final List<DragItem>? dragItems;  // For dragAndDrop
///    final List<DropZone>? dropZones;  // For dragAndDrop
/// 
/// 3. Update validation logic in LevelDataUtils
/// 
/// 4. Create UI component to display the new challenge type
/// 
/// That's it! The model is designed to be extended easily.

// ============================================
// BEST PRACTICES
// ============================================

/// 1. Always provide meaningful explanations for wrong answers
/// 2. Include 2-3 hints per challenging step
/// 3. Keep lessonText concise but informative
/// 4. Use analogies to make concepts relatable
/// 5. Test validation rules thoroughly
/// 6. Set realistic timeEstimate values
/// 7. Balance XP rewards across challenge types
/// 8. Use keyTakeaways to reinforce learning
/// 9. Link related concepts for deeper learning
/// 10. Make first levels easy to build confidence
