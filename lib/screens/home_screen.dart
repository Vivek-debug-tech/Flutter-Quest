// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_game/screens/level_screen.dart';
import '../widgets/xp_bar.dart';
import '../widgets/world_card.dart';
import '../data/worlds_data.dart';
import '../config/dev_config.dart';
import '../services/progress_service.dart';
import 'dev_panel_screen.dart';
import '../managers/achievement_manager.dart';
import 'learning_dashboard_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final worlds = GameData.getAllWorlds();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          // Dev Panel Access: Long-press XP bar (only in dev mode)
          GestureDetector(
            onLongPress: () {
              if (DevConfig.devMode) {
                print("🛠️ Opening Developer Panel (long-press detected)");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DevPanelScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🔒 Developer Panel is disabled'),
                    duration: Duration(seconds: 1),
                  ),
                );
              }
            },
            child: const XPBar(),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Choose Your Quest',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.analytics_outlined),
                        tooltip: 'Learning dashboard',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const LearningDashboardScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ...worlds.map((world) {
                  return WorldCard(
                    world: world,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelScreen(world: world),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAchievementsDialog(context);
        },
        icon: const Icon(Icons.emoji_events),
        label: const Text('Achievements'),
        backgroundColor: Colors.amber,
      ),
    );
  }

  void _showAchievementsDialog(BuildContext context) {
    final storageService = Provider.of<ProgressService>(
      context,
      listen: false,
    ).storageService;
    final unlockedAchievements = storageService
        .getUnlockedAchievements()
        .map(AchievementManager.getTitle)
        .toList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: double.maxFinite,
          child: unlockedAchievements.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Complete challenges to unlock achievements!',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: unlockedAchievements.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: Text(unlockedAchievements[index]),
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
