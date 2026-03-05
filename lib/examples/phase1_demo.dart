import 'package:flutter/material.dart';
import '../data/world_data_enhanced.dart';

/// Demo to test Phase 1 features with enhanced data
class Phase1DemoScreen extends StatelessWidget {
  const Phase1DemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final enhancedWorlds = EnhancedWorldData.getAllWorlds();
    final enhancedLevel = EnhancedWorldData.getAllLevels().first;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Phase 1 Features Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.auto_awesome, color: Colors.amber, size: 40),
              title: const Text('Phase 1 Enhanced Data',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              subtitle: Text('${enhancedWorlds.length} worlds with full Phase 1 features'),
            ),
          ),
          const SizedBox(height: 20),
          
          _buildFeatureCard(
            context,
            icon: Icons.school,
            title: 'Lesson Content',
            description: 'View lesson with code examples',
            color: Colors.purple,
            onTap: () {
              // Show phase 1 lesson content
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Lesson Content Sample'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title: ${enhancedLevel.title}'),
                        const SizedBox(height: 8),
                        Text('Concept: ${enhancedLevel.concept}'),
                        const SizedBox(height: 8),
                        const Text('Lesson Text:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(enhancedLevel.lessonText.substring(0, 200) + '...'),
                        const SizedBox(height: 8),
                        const Text('Code Example:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey.shade200,
                          child: Text(
                            enhancedLevel.codeExample ?? 'No code example',
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                          ),
                        ),
                      ],
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
            },
          ),
          
          _buildFeatureCard(
            context,
            icon: Icons.view_list,
            title: 'Multi-step Challenges',
            description: '${enhancedLevel.challengeSteps.length} challenge steps with types',
            color: Colors.blue,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Challenge Steps Sample'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Steps: ${enhancedLevel.challengeSteps.length}'),
                        const SizedBox(height: 16),
                        ...enhancedLevel.challengeSteps.asMap().entries.map((entry) {
                          final index = entry.key;
                          final step = entry.value;
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step ${index + 1}: ${step.type.toString().split('.').last}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(step.question),
                                  const SizedBox(height: 4),
                                  Text('Hints: ${step.hints.length}', style: TextStyle(color: Colors.amber.shade700)),
                                  Text('XP: ${step.xpReward}', style: const TextStyle(color: Colors.green)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
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
            },
          ),
          
          _buildFeatureCard(
            context,
            icon: Icons.lightbulb,
            title: 'Hint System',
            description: 'Progressive hints with XP penalties',
            color: Colors.amber,
            onTap: () {
              final firstStep = enhancedLevel.challengeSteps.first;
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Hint System Sample'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Challenge: ${firstStep.question}'),
                      const SizedBox(height: 16),
                      const Text('Available Hints:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...firstStep.hints.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const  EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.amber.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Text('${entry.key + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(entry.value)),
                              const Text('-5 XP', style: TextStyle(color: Colors.red, fontSize: 12)),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          
          _buildFeatureCard(
            context,
            icon: Icons.info,
            title: 'Explanation System',
            description: 'Comprehensive post-challenge explanations',
            color: Colors.green,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Explanation System Sample'),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Main Explanation:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(enhancedLevel.explanation),
                        const SizedBox(height: 16),
                        const Text('Common Mistakes:', style: TextStyle(fontWeight: FontWeight.bold)),
                        ...enhancedLevel.commonMistakes.map((mistake) => 
                          Padding(
                            padding: const EdgeInsets.only(left: 8, top: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('⚠️ '),
                                Expanded(child: Text(mistake)),
                              ],
                            ),
                          )
                        ).toList(),
                      ],
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
            },
          ),
          
          _buildFeatureCard(
            context,
            icon: Icons.category,
            title: 'Challenge Types',
            description: 'View all 6 challenge types in action',
            color: Colors.deepOrange,
            onTap: () {
              final allLevels = EnhancedWorldData.getAllLevels();
              final challengeTypes = <String, int>{};
              
              for (var level in allLevels) {
                for (var step in level.challengeSteps) {
                  final typeName = step.type.toString().split('.').last;
                  challengeTypes[typeName] = (challengeTypes[typeName] ?? 0) + 1;
                }
              }
              
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Challenge Types Distribution'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: challengeTypes.entries.map((entry) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.check_circle, color: Colors.green),
                          title: Text(entry.key),
                          trailing: Text('${entry.value}x', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      );
                    }).toList(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
          ),
          
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EnhancedDataHomeScreen(),
                ),
              );
            },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('Launch App with Phase 1 Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// Home screen using Enhanced World Data with Phase 1 features
class EnhancedDataHomeScreen extends StatelessWidget {
  const EnhancedDataHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final worlds = EnhancedWorldData.getAllWorlds();
    final  allLevels = EnhancedWorldData.getAllLevels();

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterQuest - Phase 1'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.deepPurple.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome, size: 48, color: Colors.deepPurple),
                  const SizedBox(height: 8),
                  const Text(
                    'Enhanced Phase 1 Data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'All features: Multi-step challenges, hints, explanations, 6 types',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ...worlds.map((world) {
            // Filter levels for this world
            final worldLevels = allLevels.where((level) => level.worldId == world.id).toList();
            final totalChallenges = worldLevels.fold<int>(0, (sum, l) => sum + l.challengeSteps.length);
            final totalXP = worldLevels.fold<int>(0, (sum, level) => sum + level.baseXP);
            
            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  // Navigate to levels (would need to create enhanced level screen)
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(world.title),
                      content: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(world.description),
                            const SizedBox(height: 16),
                            Text('Levels: ${worldLevels.length}'),
                            Text('Total XP: $totalXP'),
                            const SizedBox(height: 16),
                            const Text('Tap a level to start:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            ...worldLevels.map((level) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: const Icon(Icons.play_circle, color: Colors.green),
                                title: Text(level.title),
                                subtitle: Text('${level.challengeSteps.length} steps • ${level.baseXP} XP'),
                                onTap: () {
                                  Navigator.pop(context);
                                  // Would navigate to lesson screen here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Level: ${level.title}\nThis would start the full learning flow!')),
                                  );
                                },
                              );
                            }).toList(),
                          ],
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
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            world.icon,
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  world.title,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  world.description,
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildBadge('${worldLevels.length} Levels', const Color(0xFF2196F3)),
                          const SizedBox(width: 8),
                          _buildBadge('$totalChallenges Challenges', const Color(0xFF4CAF50)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
