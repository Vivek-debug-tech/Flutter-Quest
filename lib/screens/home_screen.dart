import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/xp_bar.dart';
import '../widgets/world_card.dart';
import '../data/worlds_data.dart';
import '../services/progress_service.dart';
import 'level_screen.dart';
import '../examples/phase1_demo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final worlds = GameData.getAllWorlds();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const XPBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Choose Your Quest',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Phase 1 Demo Card
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 4,
                  color: Colors.deepPurple.shade50,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Phase1DemoScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.deepPurple,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.auto_awesome,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '✨ Phase 1 Features Demo',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'See all Phase 1 features in action',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward, color: Colors.deepPurple),
                        ],
                      ),
                    ),
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
    final progressService = Provider.of<ProgressService>(context, listen: false);
    final earnedBadges = progressService.userProgress.earnedBadges;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🏆 Your Achievements'),
        content: SizedBox(
          width: double.maxFinite,
          child: earnedBadges.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Complete challenges to earn badges!',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: earnedBadges.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.star, color: Colors.amber),
                      title: Text(earnedBadges[index]),
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
