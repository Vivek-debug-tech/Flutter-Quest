import 'package:flutter/material.dart';
// Removed code_text_field, highlight, and flutter_highlight imports
import 'package:provider/provider.dart';
import '../models/level_model.dart' as level_model;
import '../models/challenge_models.dart' as challenge_model;
import '../models/challenge_result.dart';
import '../services/progress_service.dart';
import '../widgets/learning_progress_indicator.dart';
import '../utils/hint_manager.dart';
import '../utils/challenge_validator.dart';
import '../config/dev_config.dart';
import '../engine/challenge_engine.dart';
import '../engine/error_detector.dart';
import 'result_screen.dart';

/// Enhanced Challenge Screen with multi-step support, hints, and code validation
class ChallengeScreenEnhanced extends StatefulWidget {
  final level_model.Level level;
  final List<challenge_model.ChallengeStep>?
  challengeSteps; // Optional multi-step challenges

  const ChallengeScreenEnhanced({
    Key? key,
    required this.level,
    this.challengeSteps,
  }) : super(key: key);

  @override
  State<ChallengeScreenEnhanced> createState() =>
      _ChallengeScreenEnhancedState();
}

class _ChallengeScreenEnhancedState extends State<ChallengeScreenEnhanced> {
  int _currentStepIndex = 0;
  int _hintsUsed = 0;
  int _mistakesMade = 0;
  String? _userAnswer;
  late TextEditingController _codeController;
  String? _liveErrorMessage;
  int _baseXP = 0;
  late HintManager _hintManager;
  List<String> _qualityTips =
      []; // Store quality tips from successful evaluation

  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    _codeController.addListener(_analyzeCode);
    print("\n========================================");
    print("ACTIVE SCREEN: challenge_screen_enhanced.dart");
    print("========================================\n");

    // Developer Mode Warning
    if (DevConfig.devMode) {
      print("⚠️  DEV MODE ENABLED - All levels unlocked, validation skipped");
    }

    _baseXP = widget.level.baseXP;
    // Initialize hint manager with level hints
    _hintManager = HintManager(widget.level.hints);

    // Auto-fill starter code in developer mode
    if (DevConfig.devMode && DevConfig.autoComplete) {
      // Use a small delay to ensure controller is ready
      Future.microtask(() {
        _codeController.text = widget.level.expectedCode;
        print("🛠️ DEV MODE: Auto-filled with expected code");
      });
    }
  }

  @override
  void dispose() {
    _codeController.removeListener(_analyzeCode);
    _codeController.dispose();
    super.dispose();
  }

  challenge_model.ChallengeStep? get currentStep {
    if (widget.challengeSteps != null && widget.challengeSteps!.isNotEmpty) {
      return widget.challengeSteps![_currentStepIndex];
    }
    return null;
  }

  int get totalSteps => widget.challengeSteps?.length ?? 1;

  void _analyzeCode() {
    if (!mounted) {
      return;
    }

    final code = _codeController.text;
    final error = code.trim().isEmpty
        ? null
        : FlutterErrorDetector.detectError(code)?.message;

    if (_liveErrorMessage == error) {
      return;
    }

    setState(() {
      _liveErrorMessage = error;
    });
  }

  bool get _isMultipleChoiceChallenge {
    final stepType = currentStep?.type;
    if (stepType != null) {
      return stepType == challenge_model.ChallengeType.multipleChoice;
    }

    return widget.level.challengeType ==
        level_model.ChallengeType.multipleChoice;
  }

  String getChallengeTypeTitle() {
    final stepType = currentStep?.type;
    if (stepType != null) {
      switch (stepType) {
        case challenge_model.ChallengeType.multipleChoice:
          return 'Multiple Choice';
        case challenge_model.ChallengeType.fillInBlank:
          return 'Fill in the Blank';
        case challenge_model.ChallengeType.fixTheBug:
          return 'Fix the Bug';
        case challenge_model.ChallengeType.buildWidget:
          return 'Build Widget';
        case challenge_model.ChallengeType.arrangeCode:
          return 'Arrange Code';
        case challenge_model.ChallengeType.interactiveCode:
          return 'Interactive Code';
      }
    }

    switch (widget.level.challengeType) {
      case level_model.ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case level_model.ChallengeType.fixBrokenUI:
        return 'Fix the Bug';
      case level_model.ChallengeType.buildFromScratch:
        return 'Build Widget';
      case level_model.ChallengeType.dragAndDrop:
        return 'Arrange Code';
    }

    return 'Code Challenge';
  }

  void _showHint() {
    final hint = _hintManager.getNextHint();

    if (hint == null) {
      // No more hints available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No more hints available!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _hintsUsed = _hintManager.hintsUsed;
    });

    final bool isFinalHint =
        _hintManager.currentHintIndex >= HintManager.maxHints;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.amber, size: 28),
            const SizedBox(width: 12),
            Text(
              'Hint ${_hintManager.currentHintIndex}/${HintManager.maxHints}',
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _hintManager.getHintDisplayText(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(hint, style: const TextStyle(fontSize: 16, height: 1.5)),
          ],
        ),
        actions: [
          if (isFinalHint) ...[
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
              },
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                _revealAnswerAnimated(); // Start animation
              },
              child: const Text('Reveal Answer'),
            ),
          ] else
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Got it!', style: TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }

  void _submitAnswer() {
    // Developer Mode: Skip validation and go straight to results
    if (DevConfig.devMode && DevConfig.autoComplete) {
      print("🛠️ DEV MODE: Skipping validation");

      final progressService = Provider.of<ProgressService>(
        context,
        listen: false,
      );
      progressService.completeLevel(
        level: widget.level,
        hintsUsed: 0,
        mistakesMade: 0,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResultScreen(level: widget.level, hintsUsed: 0, mistakesMade: 0),
        ),
      );
      return;
    }

    // Normal validation flow using centralized Challenge Engine
    String code = _codeController.text;

    // DEBUG: Print user code before validation
    print("\n==================== SUBMIT ANSWER ====================");
    print("USER CODE:");
    print(code);
    print("======================================================\n");

    // Evaluate code using a custom validator that uses the level's validation rules
    final result = ChallengeEngine.evaluateWithValidator(
      code,
      validator: (c) =>
          ChallengeValidator.validateCode(c, widget.level.validationRules),
    );

    // DEBUG: Print evaluation result
    print("EVALUATION RESULT: ${result.success}");
    if (!result.success) {
      print("Error Type: ${result.errorType}");
      print("Message: ${result.message}");
    }
    print("======================================================\n");

    if (result.success) {
      // Challenge passed!
      print("✅ Challenge Passed");

      // Store quality tips for display in ResultScreen
      setState(() {
        _qualityTips = result.qualityTips;
      });

      _completeLevel();
    } else {
      // Challenge failed - show appropriate error dialog
      print("❌ Challenge Failed: ${result.errorType}");

      setState(() {
        _mistakesMade++;
      });

      _showChallengeResultDialog(result);
    }
  }

  /// Shows unified dialog for all challenge result types
  ///
  /// Handles structure errors, syntax errors, and validation errors
  /// with appropriate icons, colors, and hint displays
  void _showChallengeResultDialog(ChallengeResult result) {
    // Determine icon and color based on error type
    IconData dialogIcon;
    Color iconColor;

    switch (result.errorType) {
      case ChallengeErrorType.structureError:
        dialogIcon = Icons.architecture;
        iconColor = Colors.orange.shade700;
        break;
      case ChallengeErrorType.syntaxError:
        dialogIcon = Icons.tips_and_updates;
        iconColor = Colors.blue.shade700;
        break;
      case ChallengeErrorType.validationError:
        dialogIcon = Icons.error_outline;
        iconColor = Colors.red.shade700;
        break;
      case ChallengeErrorType.none:
        dialogIcon = Icons.check_circle;
        iconColor = Colors.green.shade700;
        break;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(dialogIcon, color: iconColor, size: 28),
            const SizedBox(width: 12),
            Text(result.errorTitle),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error Message
              if (result.message != null)
                Text(
                  result.message!,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),

              // Smart Hint Section (for syntax errors)
              if (result.smartHint != null) ...[
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Colors.green.shade700,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Smart Hint',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        result.smartHint!,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],

              // Quick Fix Section (for syntax errors)
              if (result.quickFix != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.build,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          result.quickFix!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.orange.shade900,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // Learning Tip Section (for syntax errors)
              if (result.learningTip != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Text(
                    result.learningTip!,
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],

              // Footer message
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.school, color: Colors.blue.shade700, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        result.errorType == ChallengeErrorType.structureError
                            ? 'Fix the widget structure before submitting.'
                            : result.hasHints
                            ? 'Fix this error and try again!'
                            : 'Review the code and try again!',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          // Show hint button if hints are available
          if (_hintManager.hasMoreHints())
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showHint();
              },
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Get Hint'),
            ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade700,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Future<void> _revealAnswerAnimated() async {
    String answer = widget.level.expectedCode;
    _codeController.clear();
    for (int i = 0; i < answer.length; i++) {
      await Future.delayed(const Duration(milliseconds: 10));
      if (mounted) {
        _codeController.text += answer[i];
      }
    }
  }

  /// Calculate XP based on hints used
  /// Rules:
  /// - 0 hints used → full XP (60)
  /// - 1 hint used → -10 XP
  /// - 2 hints used → -20 XP
  /// - 3 hints used → -20 XP
  /// Final XP should never go below 10
  int calculateXP(int baseXP) {
    int hintsUsed = _hintManager.hintsUsed;
    int xp = baseXP;

    if (hintsUsed == 1) {
      xp -= 10;
    } else if (hintsUsed == 2) {
      xp -= 20;
    } else if (hintsUsed >= 3) {
      xp -= 20;
    }

    // Ensure XP never goes below 10
    if (xp < 10) xp = 10;

    print('💰 XP Calculation:');
    print('   Base XP: $baseXP');
    print('   Hints Used: $hintsUsed');
    print('   Final XP: $xp');

    return xp;
  }

  void _completeLevel() {
    print('✅ Challenge completed!');
    print('📊 Hints used: $_hintsUsed');
    print('❌ Mistakes made: $_mistakesMade');

    final progressService = Provider.of<ProgressService>(
      context,
      listen: false,
    );
    progressService.completeLevel(
      level: widget.level,
      hintsUsed: _hintsUsed,
      mistakesMade: _mistakesMade,
    );

    // Calculate final XP
    final xpEarned = calculateXP(widget.level.baseXP);
    print('💰 Total XP earned: $xpEarned');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          level: widget.level,
          hintsUsed: _hintsUsed,
          mistakesMade: _mistakesMade,
          qualityTips: _qualityTips,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.title),
        actions: [
          if (_hintManager.hasMoreHints())
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.lightbulb_outline),
                  onPressed: _showHint,
                  tooltip: 'Get a hint',
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_hintManager.remainingHints}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          const LearningProgressIndicator(currentStep: 3),

          // Step Progress Indicator
          if (totalSteps > 1)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStepIndex + 1} / $totalSteps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'XP: $_baseXP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (_currentStepIndex + 1) / totalSteps,
                    backgroundColor: Colors.blue.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.blue.shade700,
                    ),
                    minHeight: 8,
                  ),
                ],
              ),
            ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Challenge Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      getChallengeTypeTitle(),
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Learning Objective
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.purple.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.school, color: Colors.purple.shade700),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            currentStep?.description ??
                                widget.level.learningObjective,
                            style: TextStyle(
                              color: Colors.purple.shade900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Challenge Question
                  Text(
                    'Challenge:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentStep?.question ?? widget.level.challengeDescription,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Challenge Input
                  if (_isMultipleChoiceChallenge)
                    _buildMultipleChoice()
                  else
                    _buildCodeEditor(),

                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _buildStatChip(
                        Icons.lightbulb_outline,
                        'Hints: $_hintsUsed',
                        Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _buildStatChip(
                        Icons.error_outline,
                        'Mistakes: $_mistakesMade',
                        Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      _buildStatChip(Icons.bolt, 'XP: $_baseXP', Colors.amber),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submitAnswer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        totalSteps > 1 && _currentStepIndex < totalSteps - 1
                            ? 'Next Step'
                            : 'Submit Answer',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoice() {
    final options = currentStep?.options ?? [];
    if (options.isEmpty) {
      // Fallback to simple choices for old format
      return Column(
        children: [
          _buildChoiceCard('runApp()', 'runApp()'),
          _buildChoiceCard('main()', 'main()'),
          _buildChoiceCard('startApp()', 'startApp()'),
          _buildChoiceCard('begin()', 'begin()'),
        ],
      );
    }

    return Column(
      children: options.map((option) {
        return _buildChoiceCard(option.text, option.id);
      }).toList(),
    );
  }

  Widget _buildChoiceCard(String label, String value) {
    final isSelected = _userAnswer == value;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected ? Colors.blue.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _userAnswer = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'main.dart',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          TextField(
            controller: _codeController,
            maxLines: 10,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText:
                  currentStep?.brokenCode ??
                  '// Write your Flutter code here...',
              hintStyle: const TextStyle(color: Colors.white38),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
          if (_liveErrorMessage != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                border: Border(top: BorderSide(color: Colors.orange.shade300)),
              ),
              child: Text(
                _liveErrorMessage!,
                style: TextStyle(
                  color: Colors.orange.shade900,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, MaterialColor color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
