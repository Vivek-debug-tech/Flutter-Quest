import '../models/achievement_model.dart';

class AchievementsData {
  static List<Badge> getAllBadges() {
    return [
      Badge(
        id: 'scaffold_starter',
        title: 'Scaffold Starter',
        description: 'Complete all levels in World 1',
        emoji: '🏗️',
      ),
      Badge(
        id: 'layout_ninja',
        title: 'Layout Ninja',
        description: 'Get 3 stars in all Layout Mastery levels',
        emoji: '🥷',
      ),
      Badge(
        id: 'bug_fixer',
        title: 'Bug Fixer',
        description: 'Fix 10 broken UIs',
        emoji: '🐛',
      ),
      Badge(
        id: 'no_hint_hero',
        title: 'No Hint Hero',
        description: 'Complete 5 levels without using hints',
        emoji: '🦸',
      ),
      Badge(
        id: 'streak_master',
        title: 'Streak Master',
        description: 'Maintain a 7-day streak',
        emoji: '🔥',
      ),
      Badge(
        id: 'ui_artist',
        title: 'UI Artist',
        description: 'Complete all levels in UI & Styling',
        emoji: '🎨',
      ),
      Badge(
        id: 'perfectionist',
        title: 'Perfectionist',
        description: 'Get 3 stars on 10 levels',
        emoji: '⭐',
      ),
      Badge(
        id: 'flutter_beginner',
        title: 'Flutter Beginner',
        description: 'Reach Level 3',
        emoji: '🌱',
      ),
      Badge(
        id: 'widget_explorer',
        title: 'Widget Explorer',
        description: 'Reach Level 6',
        emoji: '🔍',
      ),
      Badge(
        id: 'layout_master',
        title: 'Layout Master',
        description: 'Reach Level 10',
        emoji: '📐',
      ),
    ];
  }

  static List<Achievement> getAllAchievements() {
    return [
      Achievement(
        id: 'world_1_complete',
        title: 'Basic Training Complete',
        description: 'Complete all levels in Flutter Basics',
        icon: '🚀',
        xpReward: 100,
        type: AchievementType.completeWorld,
        targetValue: 5,
      ),
      Achievement(
        id: 'world_2_complete',
        title: 'Layout Expert',
        description: 'Complete all levels in Layout Mastery',
        icon: '📐',
        xpReward: 150,
        type: AchievementType.completeWorld,
        targetValue: 5,
      ),
      Achievement(
        id: 'world_3_complete',
        title: 'Style Guru',
        description: 'Complete all levels in UI & Styling',
        icon: '🎨',
        xpReward: 200,
        type: AchievementType.completeWorld,
        targetValue: 5,
      ),
      Achievement(
        id: 'perfect_5',
        title: 'Perfection Streak',
        description: 'Get 3 stars on 5 consecutive levels',
        icon: '✨',
        xpReward: 75,
        type: AchievementType.perfectStars,
        targetValue: 5,
      ),
      Achievement(
        id: 'fix_10_bugs',
        title: 'Debugger',
        description: 'Fix 10 broken UIs',
        icon: '🔧',
        xpReward: 100,
        type: AchievementType.fixBugs,
        targetValue: 10,
      ),
      Achievement(
        id: 'no_hints_champion',
        title: 'Independent Learner',
        description: 'Complete 10 levels without hints',
        icon: '🧠',
        xpReward: 150,
        type: AchievementType.noHints,
        targetValue: 10,
      ),
      Achievement(
        id: 'week_streak',
        title: 'Dedicated Student',
        description: 'Login for 7 consecutive days',
        icon: '📅',
        xpReward: 100,
        type: AchievementType.dailyStreak,
        targetValue: 7,
      ),
      Achievement(
        id: 'level_10',
        title: 'Rising Star',
        description: 'Reach User Level 10',
        icon: '🌟',
        xpReward: 200,
        type: AchievementType.levelUp,
        targetValue: 10,
      ),
    ];
  }
}
