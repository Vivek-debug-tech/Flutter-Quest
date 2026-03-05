import 'package:flutter/material.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../engine/challenge_engine.dart';
import '../widgets/challenge_progress_bar.dart';
import '../widgets/challenges/mcq_challenge_widget.dart';
import '../widgets/challenges/fill_blank_challenge_widget.dart';
import '../widgets/challenges/fix_code_challenge_widget.dart';
import '../widgets/hint_widget.dart';

/// Main Challenge Screen - Uses ChallengeEngine with setState
/// Clean separation: Engine handles logic, UI handles display
class ChallengeEngineScreen extends StatefulWidget {
  final LevelModel level;

  const ChallengeEngineScreen({Key? key, required this.level}) : super(key: key);

  @override
  State<ChallengeEngineScreen> createState() => _ChallengeEngineScreenState();
}

class _ChallengeEngineScreenState extends State<ChallengeEngineScreen> {
  late ChallengeEngine _engine;
  String _currentAnswer = '';
  String? _feedbackMessage;
  bool _showFeedback = false;
  Color _feedbackColor = Colors.green;
  List<String> _displayedHints = []; // Track hints displayed for current step

  @override
  void initState() {
    super.initState();
    _engine = ChallengeEngine(level: widget.level);
  }

  // ============================================
  // EVENT HANDLERS
  // ============================================

  void _handleSubmit() {
    if (_currentAnswer.isEmpty) {
      _showSnackBar('Please provide an answer', Colors.orange);
      return;
    }

    final result = _engine.validateAnswer(_currentAnswer);

    setState(() {
      _showFeedback = true;
      _feedbackMessage = result.feedback;
      _feedbackColor = result.isCorrect ? Colors.green : Colors.red;
    });

    if (result.isCorrect) {
      // Auto-advance after showing success feedback
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          _handleNext();
        }
      });
    }
  }

  void _handleNext() {
    if (_engine.isComplete) {
      _showCompletionDialog();
      return;
    }

    if (_engine.canGoToNextStep()) {
      setState(() {
        _engine.nextStep();
        _currentAnswer = '';
        _showFeedback = false;
        _feedbackMessage = null;
        _displayedHints = []; // Clear hints when moving to next step
      });
    } else {
      _showCompletionDialog();
    }
  }

  void _handlePrevious() {
    if (_engine.canGoToPreviousStep()) {
      setState(() {
        _engine.previousStep();
        _currentAnswer = '';
        _showFeedback = false;
        _feedbackMessage = null;
        _displayedHints = []; // Clear hints when moving back
      });
    }
  }

  void _handleHint() {
    final hint = _engine.getNextHint();

    if (hint != null) {
      setState(() {
        _displayedHints.add(hint);
      });
      _showSnackBar(
        'Hint revealed! -5 XP',
        Colors.amber.shade700,
      );
    } else {
      _showSnackBar('No more hints available', Colors.grey);
    }
  }

  void _handleAnswerChanged(String answer) {
    setState(() {
      _currentAnswer = answer;
      _showFeedback = false;
    });
  }

  // ============================================
  // UI DIALOGS
  // ============================================

  void _showCompletionDialog() {
    final stats = _engine.getStats();
    final xpBreakdown = _engine.getXPBreakdown();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            const Text('Level Complete!'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.level.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Stats
              _buildStatRow(
                Icons.check_circle,
                'Completed',
                '${stats.completedSteps}/${stats.totalSteps} steps',
                Colors.green,
              ),
              _buildStatRow(
                Icons.close,
                'Mistakes',
                '${stats.mistakesCount}',
                Colors.red,
              ),
              _buildStatRow(
                Icons.lightbulb_outline,
                'Hints Used',
                '${stats.hintsUsed}',
                Colors.amber,
              ),
              _buildStatRow(
                Icons.percent,
                'Accuracy',
                '${stats.accuracyPercentage.toStringAsFixed(1)}%',
                Colors.blue,
              ),
              const Divider(height: 32),

              // XP Breakdown
              const Text(
                'XP Breakdown',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildXPRow('Base XP', xpBreakdown.baseXP, Colors.blue),
              _buildXPRow('Steps XP', xpBreakdown.stepsXP, Colors.green),
              if (xpBreakdown.accuracyBonus > 0)
                _buildXPRow('Accuracy Bonus', xpBreakdown.accuracyBonus,
                    Colors.purple),
              if (xpBreakdown.hintPenalty > 0)
                _buildXPRow(
                    'Hint Penalty', -xpBreakdown.hintPenalty, Colors.orange),
              const Divider(height: 16),
              _buildXPRow('Total XP', xpBreakdown.totalXP, Colors.indigo,
                  isBold: true),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to previous screen
            },
            child: const Text('Back to Levels'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _engine.reset();
                _currentAnswer = '';
                _showFeedback = false;
                _displayedHints = []; // Clear hints on reset
              });
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
      IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPRow(String label, int value, Color color,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          const Spacer(),
          Text(
            value >= 0 ? '+$value' : '$value',
            style: TextStyle(
              fontSize: isBold ? 16 : 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // ============================================
  // BUILD METHOD
  // ============================================

  @override
  Widget build(BuildContext context) {
    final currentStep = _engine.currentStep;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.title),
        backgroundColor: Colors.indigo.shade700,
      ),
      body: Column(
        children: [
          // Progress Bar
          ChallengeProgressBar(
            currentStep: _engine.currentStepNumber,
            totalSteps: _engine.totalSteps,
            mistakesCount: _engine.mistakesCount,
            hintsUsed: _engine.hintsUsed,
          ),

          // Challenge Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Dynamic Challenge Widget
                  _buildChallengeWidget(currentStep),

                  const SizedBox(height: 24),

                  // Hint System Widget
                  if (currentStep.hints.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: HintWidget(
                        displayedHints: _displayedHints,
                        totalHintsAvailable: currentStep.hints.length,
                        hintsUsed: _engine.getHintsUsedForCurrentStep(),
                        hasMoreHints: _engine.hasMoreHints(),
                        onRequestHint: _handleHint,
                        xpPenaltyPerHint: 5,
                      ),
                    ),

                  // Feedback message
                  if (_showFeedback && _feedbackMessage != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _feedbackColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _feedbackColor,
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _feedbackColor == Colors.green
                                ? Icons.check_circle
                                : Icons.error,
                            color: _feedbackColor,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _feedbackMessage!,
                              style: TextStyle(
                                fontSize: 14,
                                color: _feedbackColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Primary action button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _showFeedback && _feedbackColor == Colors.green
                        ? _handleNext
                        : _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _showFeedback && _feedbackColor == Colors.green
                          ? (_engine.isLastStep ? 'Finish' : 'Next Step')
                          : 'Submit Answer',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Secondary buttons
                Row(
                  children: [
                    // Previous button
                    if (!_engine.isFirstStep)
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _handlePrevious,
                          icon: const Icon(Icons.arrow_back, size: 18),
                          label: const Text('Previous'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    if (!_engine.isFirstStep) const SizedBox(width: 12),

                    // Hint button
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _engine.hasMoreHints()
                            ? _handleHint
                            : null,
                        icon: const Icon(Icons.lightbulb_outline, size: 18),
                        label: Text(
                          _engine.hasHints()
                              ? 'Hint (${_engine.getHintsUsedForCurrentStep()}/${_engine.currentStep.hints.length})'
                              : 'No Hints',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.amber.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // DYNAMIC CHALLENGE WIDGET BUILDER
  // ============================================

  Widget _buildChallengeWidget(ChallengeStep step) {
    switch (step.type) {
      case ChallengeType.multipleChoice:
        return MCQChallengeWidget(
          step: step,
          onAnswerSelected: _handleAnswerChanged,
          selectedAnswer: _currentAnswer.isEmpty ? null : _currentAnswer,
        );

      case ChallengeType.fillInBlank:
        return FillBlankChallengeWidget(
          step: step,
          onAnswerChanged: _handleAnswerChanged,
        );

      case ChallengeType.arrangeCode:
        // TODO: Implement ArrangeCodeChallengeWidget
        return Center(
          child: Text('ArrangeCode widget not yet implemented'),
        );

      case ChallengeType.fixTheBug:
        return FixCodeChallengeWidget(
          step: step,
          onCodeChanged: _handleAnswerChanged,
        );

      case ChallengeType.buildWidget:
        // BuildWidget uses same editor as FixTheBug but with different styling
        return FixCodeChallengeWidget(
          step: step,
          onCodeChanged: _handleAnswerChanged,
        );

      case ChallengeType.interactiveCode:
        return FixCodeChallengeWidget(
          step: step,
          onCodeChanged: _handleAnswerChanged,
        );
    }
  }
}
