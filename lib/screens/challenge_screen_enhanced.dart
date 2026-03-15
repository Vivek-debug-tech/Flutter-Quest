// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/dart.dart';
import 'package:provider/provider.dart';
import '../models/level_model.dart';
import '../models/challenge_models.dart' as challenge_model;
import '../models/challenge_result.dart';
import '../services/progress_service.dart';
import '../widgets/learning_progress_indicator.dart';
import '../utils/hint_manager.dart';
import '../config/dev_config.dart';
import '../engine/challenge_engine.dart';
import '../engine/error_detector.dart';
import '../managers/mistake_tracker.dart';
import '../managers/xp_manager.dart';
import 'result_screen.dart';

/// Enhanced Challenge Screen with multi-step support, hints, and code validation
class ChallengeScreenEnhanced extends StatefulWidget {
  final Level level;
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
  final TextEditingController _predictOutputController = TextEditingController();
  late CodeController _codeController;
  String? _liveErrorMessage;
  bool _isCodeEditorEmpty = true;
  int _baseXP = 0;
  late HintManager _hintManager;
  List<String> _qualityTips =
      []; // Store quality tips from successful evaluation

  String _getFallbackMistakeType() {
    switch (_activeChallengeType) {
      case challenge_model.ChallengeType.multipleChoice:
        return 'multiple_choice_incorrect';
      case challenge_model.ChallengeType.predictOutput:
        return 'predict_output_incorrect';
      case challenge_model.ChallengeType.fixCode:
        return 'fix_code_validation_failed';
      case challenge_model.ChallengeType.code:
        return 'code_validation_failed';
    }
  }

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: '',
      language: dart,
    );
    _isCodeEditorEmpty = _codeController.text.trim().isEmpty;
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
        _codeController.text = _getAnswerCodeForCurrentChallenge();
        setState(() {
          _isCodeEditorEmpty = _codeController.text.trim().isEmpty;
        });
        print("🛠️ DEV MODE: Auto-filled with expected code");
      });
    }
  }

  @override
  void dispose() {
    _codeController.removeListener(_analyzeCode);
    _codeController.dispose();
    _predictOutputController.dispose();
    super.dispose();
  }

  challenge_model.ChallengeStep? get currentStep {
    if (widget.challengeSteps != null && widget.challengeSteps!.isNotEmpty) {
      return widget.challengeSteps![_currentStepIndex];
    }
    return null;
  }

  List<challenge_model.Challenge> get _levelChallenges =>
      widget.level.challenges;

  challenge_model.Challenge get _activeChallenge {
    if (_levelChallenges.isNotEmpty) {
      return _levelChallenges[_currentStepIndex];
    }

    return challenge_model.Challenge(
      type: challenge_model.ChallengeType.code,
      prompt: widget.level.challengeDescription,
      validationRules: widget.level.validationRules,
      codeSnippet: widget.level.expectedCode,
    );
  }

  int get totalSteps => _levelChallenges.isNotEmpty ? _levelChallenges.length : 1;

  void _analyzeCode() {
    if (!mounted) {
      return;
    }

    final code = _codeController.text;
    final isCodeEditorEmpty = code.trim().isEmpty;
    final error = code.trim().isEmpty
        ? null
        : FlutterErrorDetector.detectError(code)?.message;

    if (_liveErrorMessage == error && _isCodeEditorEmpty == isCodeEditorEmpty) {
      return;
    }

    setState(() {
      _isCodeEditorEmpty = isCodeEditorEmpty;
      _liveErrorMessage = error;
    });
  }

  challenge_model.ChallengeType get _activeChallengeType {
    return currentStep?.type ?? _activeChallenge.type;
  }

  String getChallengeTypeTitle() {
    final stepType = currentStep?.type;
    if (stepType != null) {
      switch (stepType) {
        case challenge_model.ChallengeType.code:
          return 'Code Challenge';
        case challenge_model.ChallengeType.multipleChoice:
          return 'Multiple Choice';
        case challenge_model.ChallengeType.fixCode:
          return 'Fix the Code';
        case challenge_model.ChallengeType.predictOutput:
          return 'Predict the Output';
      }
    }

    switch (_activeChallenge.type) {
      case challenge_model.ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case challenge_model.ChallengeType.fixCode:
        return 'Fix the Code';
      case challenge_model.ChallengeType.predictOutput:
        return 'Predict the Output';
      case challenge_model.ChallengeType.code:
        return 'Code Challenge';
    }
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

  Future<void> _submitAnswer() async {
    // Developer Mode: Skip validation and go straight to results
    if (DevConfig.devMode && DevConfig.autoComplete) {
      print("🛠️ DEV MODE: Skipping validation");

      final progressService = Provider.of<ProgressService>(
        context,
        listen: false,
      );
      final newlyUnlockedAchievements = await progressService.completeLevel(
        level: widget.level,
        hintsUsed: 0,
        mistakesMade: 0,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            level: widget.level,
            hintsUsed: 0,
            mistakesMade: 0,
            newlyUnlockedAchievements: newlyUnlockedAchievements,
          ),
        ),
      );
      return;
    }

    // Build challenge model for validation
    final activeChallenge = _activeChallenge;
    final stepOptions = currentStep?.options;
    final challengeOptions = activeChallenge.options;
    final correctIndex = stepOptions?.indexWhere((o) => o.isCorrect) ?? -1;
    final selectedIndex =
        stepOptions != null && _userAnswer != null
            ? stepOptions.indexWhere(
                (o) => o.id == _userAnswer || o.text == _userAnswer,
              )
            : challengeOptions != null && _userAnswer != null
            ? challengeOptions.indexOf(_userAnswer!)
            : null;

    final challenge = challenge_model.Challenge(
      type: _activeChallengeType,
      prompt: currentStep?.question ?? activeChallenge.prompt,
      validationRules:
          currentStep?.validationRules ?? activeChallenge.validationRules,
      options: stepOptions?.map((o) => o.text).toList() ?? activeChallenge.options,
      correctIndex:
          correctIndex >= 0 ? correctIndex : activeChallenge.correctIndex,
      brokenCode: currentStep?.brokenCode ?? activeChallenge.brokenCode,
      fixRules: currentStep?.validationRules ?? activeChallenge.fixRules,
      codeSnippet: currentStep?.codeSnippet ?? activeChallenge.codeSnippet,
      expectedOutput:
          currentStep?.expectedOutput ?? activeChallenge.expectedOutput,
    );

    final dynamic userAnswer;
    switch (_activeChallengeType) {
      case challenge_model.ChallengeType.multipleChoice:
        userAnswer = selectedIndex;
        break;
      case challenge_model.ChallengeType.predictOutput:
        userAnswer = _predictOutputController.text;
        break;
      case challenge_model.ChallengeType.fixCode:
      case challenge_model.ChallengeType.code:
        userAnswer = _codeController.text;
        break;
    }

    final isValid = ChallengeEngine.validateChallenge(challenge, userAnswer);
    final detectedError =
        (_activeChallengeType == challenge_model.ChallengeType.code ||
                _activeChallengeType == challenge_model.ChallengeType.fixCode) &&
            userAnswer is String
        ? FlutterErrorDetector.detectError(userAnswer)
        : null;
    final errorHints =
        detectedError != null
            ? ChallengeEngine.getHintsForError(detectedError.type)
            : null;
    final result = isValid
        ? ChallengeResult.success()
        : detectedError != null
        ? ChallengeResult.syntaxError(
            detectedError.message,
            smartHint: errorHints?['smartHint'],
            quickFix: errorHints?['quickFix'],
            learningTip: errorHints?['learningTip'],
          )
        : ChallengeResult.validationError(
            'Not quite right. Check your answer and try again.',
          );

    if (result.success) {
      // Challenge passed!
      print("✅ Challenge Passed");

      // Store quality tips for display in ResultScreen
      setState(() {
        _qualityTips = result.qualityTips;
      });

      if (_currentStepIndex < totalSteps - 1) {
        setState(() {
          _qualityTips = result.qualityTips;
          _currentStepIndex++;
          _prepareChallengeInput();
        });
        return;
      }

      _completeLevel();
    } else {
      // Challenge failed - show appropriate error dialog
      print("❌ Challenge Failed: ${result.errorType}");

      setState(() {
        _mistakesMade++;
      });

      final progressService = Provider.of<ProgressService>(
        context,
        listen: false,
      );
      final mistakeTracker = MistakeTracker(progressService.storageService);
      await mistakeTracker.recordMistake(
        detectedError?.type ?? _getFallbackMistakeType(),
      );

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
    _codeController.text = _getAnswerCodeForCurrentChallenge();
  }

  /// Calculate XP based on hints used
  /// Rules:
  /// - 0 hints used → full XP (60)
  /// - 1 hint used → -10 XP
  /// - 2 hints used → -20 XP
  /// - 3 hints used → -20 XP
  /// Final XP should never go below 10
  int calculateXP() {
    final hintsUsed = _hintManager.hintsUsed;
    final xp = XPManager.calculateXP(hintsUsed);

    print('💰 XP Calculation:');
    print('   Base XP: 60');
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
    progressService
        .completeLevel(
          level: widget.level,
          hintsUsed: _hintsUsed,
          mistakesMade: _mistakesMade,
        )
        .then((newlyUnlockedAchievements) {
          final xpEarned = calculateXP();
    print('💰 Total XP earned: $xpEarned');

          if (!mounted) {
            return;
          }

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(
                level: widget.level,
                hintsUsed: _hintsUsed,
                mistakesMade: _mistakesMade,
                qualityTips: _qualityTips,
                newlyUnlockedAchievements: newlyUnlockedAchievements,
              ),
            ),
          );
        });
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
                        'Challenge ${_currentStepIndex + 1} / $totalSteps',
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
                            currentStep?.description ?? widget.level.learningObjective,
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
                    currentStep?.question ?? _activeChallenge.prompt,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Challenge Input
                  _buildChallengeInput(),

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
                            ? 'Next Challenge'
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
      ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.08, end: 0),
    );
  }

  Widget _buildMultipleChoice() {
    final stepOptions = currentStep?.options ?? [];
    final challengeOptions = _activeChallenge.options ?? [];
    if (stepOptions.isEmpty && challengeOptions.isEmpty) {
      // Fallback to simple choices for old format
      final fallback = ['runApp()', 'main()', 'startApp()', 'begin()'];
      return Column(
        children: fallback
            .map(
              (label) => RadioListTile<String>(
                title: Text(label),
                value: label,
                groupValue: _userAnswer,
                onChanged: (val) {
                  setState(() {
                    _userAnswer = val;
                  });
                },
              ),
            )
            .toList(),
      );
    }

    return Column(
      children: stepOptions.isNotEmpty
          ? stepOptions.asMap().entries.map((entry) {
              final option = entry.value;
              final value = option.id.isNotEmpty ? option.id : option.text;
              return RadioListTile<String>(
                value: value,
                groupValue: _userAnswer,
                onChanged: (val) {
                  setState(() {
                    _userAnswer = val;
                  });
                },
                title: Text(option.text),
                subtitle: option.explanation != null
                    ? Text(
                        option.explanation!,
                        style: const TextStyle(fontSize: 12),
                      )
                    : null,
              );
            }).toList()
          : challengeOptions.map((option) {
              return RadioListTile<String>(
                value: option,
                groupValue: _userAnswer,
                onChanged: (val) {
                  setState(() {
                    _userAnswer = val;
                  });
                },
                title: Text(option),
              );
            }).toList(),
    );
  }

  String _getPrefillCodeForCurrentChallenge() {
    if (_activeChallengeType == challenge_model.ChallengeType.fixCode) {
      return _activeChallenge.brokenCode ?? widget.level.expectedCode;
    }

    return '';
  }

  String _getAnswerCodeForCurrentChallenge() {
    return _activeChallenge.codeSnippet ?? widget.level.expectedCode;
  }

  void _prepareChallengeInput() {
    final nextPrefill = _getPrefillCodeForCurrentChallenge();
    _codeController.text =
        _activeChallengeType == challenge_model.ChallengeType.code ||
                _activeChallengeType == challenge_model.ChallengeType.fixCode
            ? nextPrefill
            : '';
    _predictOutputController.clear();
    _userAnswer = null;
    _liveErrorMessage = null;
    _isCodeEditorEmpty = _codeController.text.trim().isEmpty;
  }

  Widget _buildFixCode() {
    final broken = currentStep?.brokenCode ?? _activeChallenge.brokenCode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (broken != null && broken.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange.shade200),
            ),
            child: Text(
              broken,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
                color: Colors.orange,
              ),
            ),
          ),
        ],
        _buildCodeEditor(),
      ],
    );
  }

  Widget _buildPredictOutput() {
    final snippet =
        currentStep?.codeSnippet ??
        _activeChallenge.codeSnippet ??
        _activeChallenge.prompt;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: Text(
            snippet,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _predictOutputController,
          decoration: const InputDecoration(
            labelText: 'Your predicted output',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            _userAnswer = value;
          },
        ),
      ],
    );
  }

  Widget _buildChallengeInput() {
    switch (_activeChallengeType) {
      case challenge_model.ChallengeType.multipleChoice:
        return _buildMultipleChoice();
      case challenge_model.ChallengeType.fixCode:
        return _buildFixCode();
      case challenge_model.ChallengeType.predictOutput:
        return _buildPredictOutput();
      case challenge_model.ChallengeType.code:
      default:
        return _buildCodeEditor();
    }
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
          Stack(
            children: [
              CodeTheme(
                data: CodeThemeData(styles: monokaiSublimeTheme),
                child: CodeField(
                  controller: _codeController,
                  textStyle: const TextStyle(
                    fontFamily: 'monospace',
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  maxLines: 10,
                  padding: const EdgeInsets.all(16),
                  lineNumberStyle: const LineNumberStyle(
                    width: 48,
                    margin: 8,
                    textStyle: TextStyle(color: Colors.white38),
                  ),
                  background: Colors.grey.shade900,
                ),
              ),
              if (_isCodeEditorEmpty)
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(72, 16, 16, 16),
                    child: Text(
                      currentStep?.brokenCode ??
                          _activeChallenge.brokenCode ??
                          '// Write your Flutter code here...',
                      style: const TextStyle(
                        color: Colors.white38,
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
            ],
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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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
