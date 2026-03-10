import 'package:flutter/material.dart';
import '../models/level_model.dart';
import '../models/world_model.dart';
import '../utils/xp_calculator.dart';
import '../widgets/star_rating.dart';
import '../widgets/learning_progress_indicator.dart';
import '../data/worlds_data.dart';
import 'lesson_screen.dart';
import 'level_screen.dart';

class ResultScreen extends StatefulWidget {
  final Level level;
  final int hintsUsed;
  final int mistakesMade;

  const ResultScreen({
    Key? key,
    required this.level,
    required this.hintsUsed,
    required this.mistakesMade,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late int _earnedXP;
  late int _stars;

  @override
  void initState() {
    super.initState();

    // Calculate results using the new XP Calculator
    _earnedXP = XPCalculator.calculateXP(widget.hintsUsed);
    _stars = XPCalculator.calculateStars(widget.hintsUsed);

    // Setup animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward();
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
                      const SizedBox(height: 40),

                      // Success Icon
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
                          color: Colors.black.withOpacity(0.2),
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

                // Success Message
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

                // Stars
                StarRating(stars: _stars, size: 48),
                const SizedBox(height: 16),
                
                // Performance message
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    XPCalculator.getPerformanceText(widget.hintsUsed),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Stats Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildStatRow(
                        Icons.bolt,
                        'XP Earned',
                        '$_earnedXP',
                        Colors.amber,
                      ),
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
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Explanation Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
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
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Back to Levels',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _getNextButtonText(),
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
            ),
        ),
      ),
    );
  }

  Widget _buildStatRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
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

  String _getNextButtonText() {
    // Find the current world and level index
    final worlds = GameData.getAllWorlds();
    World? currentWorld;
    int? levelIndex;

    // Find which world this level belongs to
    for (final world in worlds) {
      for (int i = 0; i < world.levels.length; i++) {
        if (world.levels[i].id == widget.level.id) {
          currentWorld = world;
          levelIndex = i;
          break;
        }
      }
      if (currentWorld != null) break;
    }

    // If we couldn't find the world, show generic text
    if (currentWorld == null || levelIndex == null) {
      return 'Next Level';
    }
    
    // Check if this is the last level in the world
    final isLastLevel = levelIndex >= currentWorld.levels.length - 1;
    return isLastLevel ? 'Finish World' : 'Next Level';
  }

  void _handleNextLevel(BuildContext context) {
    // Find the current world and level index
    final worlds = GameData.getAllWorlds();
    World? currentWorld;
    int? levelIndex;

    // Find which world this level belongs to
    for (final world in worlds) {
      for (int i = 0; i < world.levels.length; i++) {
        if (world.levels[i].id == widget.level.id) {
          currentWorld = world;
          levelIndex = i;
          break;
        }
      }
      if (currentWorld != null) break;
    }

    // If we couldn't find the world, just go back
    if (currentWorld == null || levelIndex == null) {
      Navigator.pop(context);
      Navigator.pop(context);
      return;
    }

    final isLastLevel = levelIndex >= currentWorld.levels.length - 1;
    
    if (isLastLevel) {
      // Last level - go back to world's level screen
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LevelScreen(world: currentWorld!),
        ),
        (route) => false,
      );
    } else {
      // Navigate to next level
      final nextIndex = levelIndex + 1;
      final nextLevel = currentWorld.levels[nextIndex];
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LessonScreen(level: nextLevel),
        ),
      );
    }
  }
}
