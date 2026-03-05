import 'package:flutter/material.dart';
import '../models/level_model_v2.dart';
import '../models/challenge_models.dart';
import '../widgets/star_rating.dart';
import '../widgets/learning_progress_indicator.dart';

/// Enhanced Result Screen with Comprehensive Explanations
///
/// Features:
/// - Detailed explanations for each challenge step
/// - Visual feedback for correct/incorrect answers
/// - Step-by-step breakdown of what was learned
/// - Organized display of hints, mistakes, and XP
/// - Common mistakes and how to avoid them
/// - Code examples with syntax highlighting
class ResultScreenEnhanced extends StatefulWidget {
  final LevelModel level;
  final int hintsUsed;
  final int mistakesMade;
  final int earnedXP;
  final int totalSteps;
  final List<Map<String, dynamic>>? stepResults; // Optional detailed step results

  const ResultScreenEnhanced({
    Key? key,
    required this.level,
    required this.hintsUsed,
    required this.mistakesMade,
    required this.earnedXP,
    this.totalSteps = 1,
    this.stepResults,
  }) : super(key: key);

  @override
  State<ResultScreenEnhanced> createState() => _ResultScreenEnhancedState();
}

class _ResultScreenEnhancedState extends State<ResultScreenEnhanced>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late int _stars;

  @override
  void initState() {
    super.initState();

    _stars = _calculateStars();

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();
  }

  int _calculateStars() {
    if (widget.hintsUsed == 0 && widget.mistakesMade == 0) return 3;
    if (widget.hintsUsed <= 1 && widget.mistakesMade <= 1) return 2;
    return 1;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple.shade700,
              Colors.blue.shade600,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const LearningProgressIndicator(currentStep: 4),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Success Icon with Animation
                      _buildSuccessIcon(),
                      const SizedBox(height: 24),

                      // Success Message
                      _buildSuccessMessage(),
                      const SizedBox(height: 24),

                      // Stars
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: StarRating(stars: _stars, size: 48),
                      ),
                      const SizedBox(height: 24),

                      // Stats Card
                      _buildStatsCard(),
                      const SizedBox(height: 20),

                      // Step Results (if multi-step)
                      if (widget.totalSteps > 1) ...[
                        _buildStepResultsCard(),
                        const SizedBox(height: 20),
                      ],

                      // Main Explanation Section
                      _buildExplanationSection(),
                      const SizedBox(height: 20),

                      // Learning Objectives
                      if (widget.level.learningObjective.isNotEmpty)
                        _buildLearningObjectiveCard(),
                      const SizedBox(height: 20),

                      // Code Example
                      if (widget.level.codeExample?.isNotEmpty ?? false)
                        _buildCodeExampleCard(),
                      const SizedBox(height: 20),

                      // Common Mistakes
                      if (widget.level.commonMistakes.isNotEmpty)
                        _buildCommonMistakesCard(),
                      const SizedBox(height: 20),

                      // Step-by-Step Explanations
                      _buildStepExplanations(),
                      const SizedBox(height: 24),

                      // Action Buttons
                      _buildActionButtons(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          Icons.check_circle,
          size: 60,
          color: Colors.green.shade500,
        ),
      ),
    );
  }

  Widget _buildSuccessMessage() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          const Text(
            'Level Complete! 🎉',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.level.title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          if (widget.totalSteps > 1) ...[
            const SizedBox(height: 4),
            Text(
              'Completed ${widget.totalSteps} ${widget.totalSteps == 1 ? 'step' : 'steps'}',
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildStatRow(
            Icons.bolt,
            'XP Earned',
            '+${widget.earnedXP}',
            Colors.amber,
          ),
          const Divider(height: 24),
          _buildStatRow(
            Icons.lightbulb_outline,
            'Hints Used',
            '${widget.hintsUsed}',
            Colors.blue,
          ),
          const Divider(height: 24),
          _buildStatRow(
            Icons.error_outline,
            'Mistakes',
            '${widget.mistakesMade}',
            Colors.orange,
          ),
          if (widget.hintsUsed > 0 || widget.mistakesMade > 0) ...[
            const Divider(height: 24),
            _buildPenaltyBreakdown(),
          ],
        ],
      ),
    );
  }

  Widget _buildStatRow(
      IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildPenaltyBreakdown() {
    final int hintPenalty = widget.hintsUsed * 5;
    final int mistakePenalty = widget.mistakesMade * 3;
    final int totalPenalty = hintPenalty + mistakePenalty;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Colors.red.shade700),
              const SizedBox(width: 6),
              Text(
                'XP Penalties',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (widget.hintsUsed > 0)
            Text(
              '• Hints: ${widget.hintsUsed} × 5 = -$hintPenalty XP',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          if (widget.mistakesMade > 0)
            Text(
              '• Mistakes: ${widget.mistakesMade} × 3 = -$mistakePenalty XP',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
            ),
          const Divider(height: 12),
          Text(
            'Total Penalty: -$totalPenalty XP',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepResultsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.checklist, color: Colors.purple.shade700),
              const SizedBox(width: 8),
              Text(
                'Challenge Steps',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...List.generate(widget.totalSteps, (index) {
            final stepNumber = index + 1;
            return _buildStepResultItem(stepNumber);
          }),
        ],
      ),
    );
  }

  Widget _buildStepResultItem(int stepNumber) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: Colors.green.shade700,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Step $stepNumber Completed',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanationSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.purple.shade700, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'What You Learned',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            widget.level.explanation,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade800,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningObjectiveCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.flag, color: Colors.blue.shade700, size: 24),
              const SizedBox(width: 8),
              Text(
                'Learning Objective',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.level.learningObjective,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blue.shade900,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeExampleCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.code, color: Colors.green.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Code Example',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.level.codeExample ?? '',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.greenAccent,
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonMistakesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 24),
              const SizedBox(width: 8),
              Text(
                'Common Mistakes to Avoid',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...widget.level.commonMistakes.map((mistake) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      mistake,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.orange.shade900,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildStepExplanations() {
    if (widget.level.challengeSteps.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.level.challengeSteps.map((step) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildStepExplanationCard(step),
        );
      }).toList(),
    );
  }

  Widget _buildStepExplanationCard(ChallengeStep step) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.shade100, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Step ${step.stepNumber}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getChallengeTypeLabel(step.type),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            step.question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          if (step.explanation?.isNotEmpty ?? false) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                step.explanation ?? '',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getChallengeTypeLabel(ChallengeType type) {
    switch (type) {
      case ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case ChallengeType.fillInBlank:
        return 'Fill in the Blank';
      case ChallengeType.fixTheBug:
        return 'Fix the Bug';
      case ChallengeType.buildWidget:
        return 'Build Widget';
      case ChallengeType.arrangeCode:
        return 'Arrange Code';
      case ChallengeType.interactiveCode:
        return 'Interactive Code';
    }
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              // Go back to levels
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.list),
            label: const Text('Levels'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white, width: 2),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Go back to home
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pop(context);
            },
            icon: const Icon(Icons.home),
            label: const Text('Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.purple.shade700,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
