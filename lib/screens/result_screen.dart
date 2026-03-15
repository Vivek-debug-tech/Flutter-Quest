import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../data/worlds_data.dart';
import '../managers/achievement_manager.dart';
import '../managers/level_manager.dart';
import '../managers/star_manager.dart';
import '../managers/xp_manager.dart';
import '../models/level_model.dart';
import '../models/world_model.dart';
import '../services/progress_service.dart';
import '../widgets/learning_progress_indicator.dart';
import 'lesson_screen.dart';
import 'level_screen.dart';

class ResultScreen extends StatefulWidget {
  final Level level;
  final int hintsUsed;
  final int mistakesMade;
  final List<String> qualityTips;
  final List<String> newlyUnlockedAchievements;

  const ResultScreen({
    super.key,
    required this.level,
    required this.hintsUsed,
    required this.mistakesMade,
    this.qualityTips = const [],
    this.newlyUnlockedAchievements = const [],
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final ConfettiController _confettiController;
  late final int _earnedXP;
  late final int _stars;
  late final List<String> _newlyUnlockedAchievements;

  @override
  void initState() {
    super.initState();
    _earnedXP = XPManager.calculateXP(widget.hintsUsed);
    _stars = StarManager.calculateStars(widget.hintsUsed);
    _newlyUnlockedAchievements = widget.newlyUnlockedAchievements;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _animationController.forward();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _confettiController.play();
      }
    });

    if (_newlyUnlockedAchievements.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        for (final achievement in _newlyUnlockedAchievements) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Achievement Unlocked\n${AchievementManager.getTitle(achievement)}',
              ),
              backgroundColor: Colors.amber,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>().userProgress;
    final levelInfo = LevelManager.getLevelProgressInfo(progress.totalXP);

    return Scaffold(
      body: Stack(
        children: [
          Container(
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
                          const SizedBox(height: 40),
                          Lottie.asset(
                            'assets/animations/success.json',
                            height: 150,
                            repeat: false,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 16),
                          ScaleTransition(
                            scale: _scaleAnimation,
                            child: Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.check_circle,
                                size: 80,
                                color: Colors.green.shade500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Level Complete!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.level.title,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          _buildStars(),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getPerformanceText(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '+$_earnedXP XP',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                              .animate()
                              .fadeIn(duration: 400.ms)
                              .scaleXY(begin: 0.8, end: 1.12, duration: 400.ms)
                              .then(delay: 80.ms)
                              .scaleXY(begin: 1.12, end: 1.0, duration: 180.ms),
                          const SizedBox(height: 32),
                          _buildStatsCard(levelInfo),
                          const SizedBox(height: 32),
                          _buildProgressCard(progress.currentStreak, levelInfo),
                          const SizedBox(height: 24),
                          _buildLearningCard(),
                          if (widget.qualityTips.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            _buildQualityTipsCard(),
                          ],
                          if (_newlyUnlockedAchievements.isNotEmpty) ...[
                            const SizedBox(height: 24),
                            _buildAchievementsCard(),
                          ],
                          const SizedBox(height: 32),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => _goBackToLevels(context),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    'Back to Levels',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _handleNextLevel(context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.purple.shade700,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    _getNextButtonText(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(duration: 450.ms).slideY(begin: 0.06, end: 0),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
              colors: const [
                Colors.amber,
                Colors.purple,
                Colors.blue,
                Colors.green,
                Colors.pink,
                Colors.orange,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStars() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        final filled = index < _stars;
        return Padding(
          padding: EdgeInsets.only(right: index == 2 ? 0 : 8),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 48,
          )
              .animate()
              .fadeIn(
                delay: (200 + (index * 140)).ms,
                duration: 260.ms,
              )
              .scaleXY(
                delay: (200 + (index * 140)).ms,
                begin: 0.5,
                end: 1.15,
                duration: 320.ms,
              )
              .then()
              .scaleXY(begin: 1.15, end: 1.0, duration: 160.ms),
        );
      }),
    );
  }

  Widget _buildStatsCard(LevelProgressInfo levelInfo) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _buildStatRow(Icons.bolt, 'XP Earned', '$_earnedXP', Colors.amber),
          const Divider(height: 32),
          _buildStatRow(
            Icons.lightbulb_outline,
            'Hints Used',
            '${widget.hintsUsed}',
            Colors.blue,
          ),
          const Divider(height: 32),
          _buildStatRow(
            Icons.error_outline,
            'Mistakes',
            '${widget.mistakesMade}',
            Colors.orange,
          ),
          const Divider(height: 32),
          _buildStatRow(
            Icons.trending_up,
            'Current Level',
            '${levelInfo.currentLevel}',
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard(int streak, LevelProgressInfo levelInfo) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Level Progress',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Level ${levelInfo.currentLevel} • '
            '${levelInfo.currentLevelXP}/${levelInfo.xpNeededForNextLevel} XP',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: levelInfo.progress,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Streak: $streak day${streak == 1 ? '' : 's'}',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.school, color: Colors.purple.shade700),
              const SizedBox(width: 8),
              Text(
                'What You Learned',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.level.explanation,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.level.expectedCode,
              style: const TextStyle(
                fontFamily: 'monospace',
                color: Colors.greenAccent,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualityTipsCard() {
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
              Icon(Icons.lightbulb, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Code Quality Tips',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Great job! Here are some ways to improve your Flutter code:',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 12),
          ...widget.qualityTips.map(
            (tip) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade800,
                        height: 1.4,
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

  Widget _buildAchievementsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Achievements',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade900,
            ),
          ),
          const SizedBox(height: 12),
          ..._newlyUnlockedAchievements.map(
            (id) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.emoji_events,
                    color: Colors.green.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      AchievementManager.getTitle(id),
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontSize: 14,
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

  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  String _getPerformanceText() {
    switch (widget.hintsUsed) {
      case 0:
        return 'Perfect! Solved without hints!';
      case 1:
        return 'Great job! Only needed one hint.';
      default:
        return 'Nice work! Keep practicing!';
    }
  }

  String _getNextButtonText() {
    final position = _findCurrentPosition();
    final currentWorld = position?.world;
    final levelIndex = position?.levelIndex;

    if (currentWorld == null || levelIndex == null) {
      return 'Next Level';
    }

    final isLastLevel = levelIndex >= currentWorld.levels.length - 1;
    return isLastLevel ? 'Finish World' : 'Next Level';
  }

  void _handleNextLevel(BuildContext context) {
    final position = _findCurrentPosition();
    final currentWorld = position?.world;
    final levelIndex = position?.levelIndex;

    if (currentWorld == null || levelIndex == null) {
      Navigator.pop(context);
      return;
    }

    final isLastLevel = levelIndex >= currentWorld.levels.length - 1;

    if (isLastLevel) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LevelScreen(world: currentWorld),
        ),
        (route) => false,
      );
      return;
    }

    final nextLevel = currentWorld.levels[levelIndex + 1];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LessonScreen(level: nextLevel),
      ),
    );
  }

  void _goBackToLevels(BuildContext context) {
    final currentWorld = _findCurrentPosition()?.world;
    if (currentWorld == null) {
      Navigator.pop(context);
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LevelScreen(world: currentWorld),
      ),
      (route) => false,
    );
  }

  _LevelPosition? _findCurrentPosition() {
    for (final world in GameData.getAllWorlds()) {
      for (int i = 0; i < world.levels.length; i++) {
        if (world.levels[i].id == widget.level.id) {
          return _LevelPosition(world: world, levelIndex: i);
        }
      }
    }
    return null;
  }
}

class _LevelPosition {
  final World world;
  final int levelIndex;

  const _LevelPosition({
    required this.world,
    required this.levelIndex,
  });
}
