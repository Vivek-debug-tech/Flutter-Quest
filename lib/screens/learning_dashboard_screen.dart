import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/worlds_data.dart';
import '../managers/achievement_manager.dart';
import '../managers/mistake_tracker.dart';
import '../managers/xp_manager.dart';
import '../models/level_model.dart';
import '../services/progress_service.dart';

class LearningDashboardScreen extends StatelessWidget {
  const LearningDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progressService = Provider.of<ProgressService>(context);
    final userProgress = progressService.userProgress;
    final storageService = progressService.storageService;
    final mistakeTracker = MistakeTracker(storageService);
    final unlockedAchievements = storageService.getUnlockedAchievements();
    final topMistakes = mistakeTracker.getMostCommonMistakes();
    final worlds = GameData.getAllWorlds();
    final completedLevels = worlds
        .expand((world) => world.levels)
        .where((level) => userProgress.completedLevels.contains(level.id))
        .toList();

    final totalChallengesSolved = completedLevels.fold<int>(
      0,
      (total, level) => total + _challengeCountForLevel(level),
    );
    final mostCommonMistake =
        topMistakes.isEmpty
            ? 'None yet'
            : '${_formatErrorType(topMistakes.first.errorType)} (${topMistakes.first.count})';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Dashboard'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _SectionTitle(
            title: 'Overview',
            subtitle: 'Base XP per completed level: ${XPManager.baseXP}',
          ),
          const SizedBox(height: 12),
          _MetricCard(
            title: 'Lessons Completed',
            value: '${userProgress.completedLevels.length}',
            icon: Icons.menu_book,
            color: Colors.blue,
          ),
          _MetricCard(
            title: 'Total Challenges Solved',
            value: '$totalChallengesSolved',
            icon: Icons.extension,
            color: Colors.green,
          ),
          _MetricCard(
            title: 'Total XP Earned',
            value: '${userProgress.totalXP}',
            icon: Icons.bolt,
            color: Colors.amber,
          ),
          _MetricCard(
            title: 'Current Learning Streak',
            value: '${userProgress.currentStreak} days',
            icon: Icons.local_fire_department,
            color: Colors.deepOrange,
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            title: 'Achievements',
            subtitle:
                '${unlockedAchievements.length} unlocked achievements',
          ),
          const SizedBox(height: 12),
          Card(
            child: unlockedAchievements.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No achievements unlocked yet.'),
                  )
                : Column(
                    children: unlockedAchievements
                        .map(
                          (achievementId) => ListTile(
                            leading: const Icon(
                              Icons.emoji_events,
                              color: Colors.amber,
                            ),
                            title: Text(
                              AchievementManager.getTitle(achievementId),
                            ),
                          ),
                        )
                        .toList(),
                  ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(
            title: 'Mistake Insights',
            subtitle: 'Common beginner issues from recent attempts',
          ),
          const SizedBox(height: 12),
          _MetricCard(
            title: 'Most Common Mistake',
            value: mostCommonMistake,
            icon: Icons.analytics,
            color: Colors.purple,
          ),
          Card(
            child: topMistakes.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('No tracked mistakes yet.'),
                  )
                : Column(
                    children: topMistakes.take(5).map((mistake) {
                      return ListTile(
                        leading: const Icon(Icons.error_outline),
                        title: Text(_formatErrorType(mistake.errorType)),
                        trailing: Text('${mistake.count}'),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }

  static int _challengeCountForLevel(Level level) {
    return level.challenges.isEmpty ? 1 : level.challenges.length;
  }

  static String _formatErrorType(String errorType) {
    return errorType
        .split('_')
        .map((part) => part.isEmpty ? part : '${part[0].toUpperCase()}${part.substring(1)}')
        .join(' ');
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionTitle({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final MaterialColor color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withValues(alpha: 0.12),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
