import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/dev_config.dart';
import '../models/challenge_models.dart' show ChallengeType;
import '../models/level_model.dart';
import '../services/progress_service.dart';

class LevelCard extends StatelessWidget {
  final Level level;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressService = Provider.of<ProgressService>(context);
    final levelUnlocked = progressService.isLevelUnlocked(level);
    final isUnlocked = DevConfig.devMode ? true : levelUnlocked;
    final levelProgress = progressService.getLevelProgress(level.id);
    final isCompleted = levelProgress?.isCompleted ?? false;
    final stars = levelProgress?.starsEarned ?? 0;

    Color getDifficultyColor() {
      switch (level.difficulty) {
        case DifficultyLevel.easy:
          return Colors.green;
        case DifficultyLevel.medium:
          return Colors.orange;
        case DifficultyLevel.hard:
          return Colors.red;
      }
    }

    String getChallengeTypeLabel() {
      if (level.challenges.length > 1) {
        return 'MIX';
      }

      switch (level.primaryChallenge.type) {
        case ChallengeType.multipleChoice:
          return 'MC';
        case ChallengeType.fixCode:
          return 'FIX';
        case ChallengeType.predictOutput:
          return 'OUT';
        case ChallengeType.code:
          return 'CODE';
      }
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: isUnlocked ? onTap : null,
        borderRadius: BorderRadius.circular(12),
        child: Opacity(
          opacity: isUnlocked ? 1.0 : 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isUnlocked
                        ? (isCompleted ? Colors.green : Colors.blue)
                        : Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      isUnlocked
                          ? (isCompleted ? 'OK' : '${level.levelNumber}')
                          : 'L',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Text(
                              getChallengeTypeLabel(),
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              level.concept,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: getDifficultyColor().withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.trending_up,
                                  size: 14,
                                  color: getDifficultyColor(),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  level.difficulty.name.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: getDifficultyColor(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.bolt, size: 14, color: Colors.amber),
                          const SizedBox(width: 2),
                          Text(
                            '${level.baseXP} XP',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Row(
                    children: List.generate(
                      3,
                      (index) => Icon(
                        index < stars ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
