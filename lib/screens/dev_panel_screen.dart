import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/progress_service.dart';
import '../config/dev_config.dart';

/// Developer Debug Panel
/// Hidden testing tool for rapid game progress manipulation
/// 
/// Access: Long-press XP bar on HomeScreen (only in dev mode)
class DevPanelScreen extends StatefulWidget {
  const DevPanelScreen({Key? key}) : super(key: key);

  @override
  State<DevPanelScreen> createState() => _DevPanelScreenState();
}

class _DevPanelScreenState extends State<DevPanelScreen> {
  bool _isLoading = false;
  String _statusMessage = '';

  @override
  void initState() {
    super.initState();
    // Check dev mode access
    if (!DevConfig.devMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('❌ Developer Panel disabled in production mode'),
            backgroundColor: Colors.red,
          ),
        );
      });
    } else {
      print("🛠️ Developer Panel Opened");
    }
  }

  void _showStatus(String message, {bool isError = false}) {
    setState(() {
      _statusMessage = message;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<void> _unlockAllLevels() async {
    setState(() => _isLoading = true);
    try {
      final progressService = Provider.of<ProgressService>(context, listen: false);
      
      // Unlock all 10 worlds
      for (int i = 1; i <= 10; i++) {
        await progressService.unlockWorld('world_$i');
      }

      // Mark first 5 levels as completed
      final completedLevels = ['w1-l1', 'w1-l2', 'w1-l3', 'w1-l4', 'w1-l5'];
      for (var levelId in completedLevels) {
        if (!progressService.userProgress.completedLevels.contains(levelId)) {
          progressService.userProgress.completedLevels.add(levelId);
        }
      }
      
      await progressService.userProgress.save();
      
      print("✅ Unlocked all 10 worlds + completed lessons 1-5");
      _showStatus('✅ All levels unlocked! Worlds 1-10 + Lessons 1-5 completed');
    } catch (e) {
      print("❌ Error unlocking levels: $e");
      _showStatus('❌ Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resetProgress() async {
    // Show confirmation dialog
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('⚠️ Reset All Progress?'),
        content: const Text(
          'This will delete ALL game progress:\n\n'
          '• XP reset to 0\n'
          '• Level 1\n'
          '• Only World 1 unlocked\n'
          '• All completed lessons cleared\n\n'
          'Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset All'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => _isLoading = true);
    try {
      final progressService = Provider.of<ProgressService>(context, listen: false);
      await progressService.resetProgress();
      
      print("✅ Progress reset complete");
      _showStatus('✅ Progress reset! Back to Level 1');
    } catch (e) {
      print("❌ Error resetting progress: $e");
      _showStatus('❌ Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _add500XP() async {
    setState(() => _isLoading = true);
    try {
      final progressService = Provider.of<ProgressService>(context, listen: false);
      progressService.userProgress.addXP(500);
      
      print("✅ Added 500 XP (Level: ${progressService.userProgress.currentLevel}, Total XP: ${progressService.userProgress.totalXP})");
      _showStatus('✅ +500 XP! Now Level ${progressService.userProgress.currentLevel}');
    } catch (e) {
      print("❌ Error adding XP: $e");
      _showStatus('❌ Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _completeCurrentLesson() async {
    setState(() => _isLoading = true);
    try {
      final progressService = Provider.of<ProgressService>(context, listen: false);
      final completedCount = progressService.userProgress.completedLevels.length;
      final nextLessonNumber = completedCount + 1;
      final nextLevelId = 'w1-l$nextLessonNumber';

      if (!progressService.userProgress.completedLevels.contains(nextLevelId)) {
        progressService.userProgress.completedLevels.add(nextLevelId);
        progressService.userProgress.addXP(60); // Award 60 XP
        await progressService.userProgress.save();
        
        print("✅ Completed lesson $nextLessonNumber ($nextLevelId) + 60 XP");
        _showStatus('✅ Lesson $nextLessonNumber completed! +60 XP');
      } else {
        _showStatus('💡 Lesson already completed', isError: true);
      }
    } catch (e) {
      print("❌ Error completing lesson: $e");
      _showStatus('❌ Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _jumpToLesson5() async {
    setState(() => _isLoading = true);
    try {
      final progressService = Provider.of<ProgressService>(context, listen: false);
      
      // Complete lessons 1-4 to unlock lesson 5
      final lessons = ['w1-l1', 'w1-l2', 'w1-l3', 'w1-l4'];
      for (var levelId in lessons) {
        if (!progressService.userProgress.completedLevels.contains(levelId)) {
          progressService.userProgress.completedLevels.add(levelId);
        }
      }
      
      // Add XP (60 XP per lesson × 4 = 240 XP)
      progressService.userProgress.addXP(240);
      await progressService.userProgress.save();
      
      print("✅ Jumped to Lesson 5 (completed 1-4) + 240 XP");
      _showStatus('✅ Jumped to Lesson 5! Lessons 1-4 completed +240 XP');
    } catch (e) {
      print("❌ Error jumping to lesson: $e");
      _showStatus('❌ Error: $e', isError: true);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressService = Provider.of<ProgressService>(context);
    final userProgress = progressService.userProgress;

    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: const Row(
          children: [
            Icon(Icons.bug_report, color: Colors.white),
            SizedBox(width: 8),
            Text('Developer Debug Panel'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.deepOrange),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Warning Banner
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.shade900,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning, color: Colors.yellow, size: 32),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '⚠️ TESTING ONLY\nChanges affect real game data',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Current Status Card
                  _buildStatusCard(userProgress),
                  const SizedBox(height: 24),

                  // Action Buttons
                  _buildActionButton(
                    icon: Icons.lock_open,
                    label: 'Unlock All Levels',
                    description: 'Unlock Worlds 1-10 + Complete Lessons 1-5',
                    color: Colors.green,
                    onPressed: _unlockAllLevels,
                  ),
                  const SizedBox(height: 12),

                  _buildActionButton(
                    icon: Icons.refresh,
                    label: 'Reset Progress',
                    description: 'Clear all data (back to Level 1)',
                    color: Colors.red,
                    onPressed: _resetProgress,
                  ),
                  const SizedBox(height: 12),

                  _buildActionButton(
                    icon: Icons.add_circle,
                    label: 'Add 500 XP',
                    description: 'Boost XP (may level up)',
                    color: Colors.purple,
                    onPressed: _add500XP,
                  ),
                  const SizedBox(height: 12),

                  _buildActionButton(
                    icon: Icons.check_circle,
                    label: 'Complete Current Lesson',
                    description: 'Finish next incomplete lesson + 60 XP',
                    color: Colors.blue,
                    onPressed: _completeCurrentLesson,
                  ),
                  const SizedBox(height: 12),

                  _buildActionButton(
                    icon: Icons.fast_forward,
                    label: 'Jump to Lesson 5',
                    description: 'Complete lessons 1-4 + 240 XP',
                    color: Colors.orange,
                    onPressed: _jumpToLesson5,
                  ),

                  const SizedBox(height: 24),

                  // Status Message
                  if (_statusMessage.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _statusMessage,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildStatusCard(userProgress) {
    return Card(
      color: Colors.grey.shade800,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info, color: Colors.cyan, size: 24),
                SizedBox(width: 8),
                Text(
                  'Current Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 8),
            _buildStatusRow('Level', '${userProgress.currentLevel}'),
            _buildStatusRow('Total XP', '${userProgress.totalXP}'),
            _buildStatusRow(
                'Title', userProgress.userTitle),
            _buildStatusRow('Unlocked Worlds',
                '${userProgress.unlockedWorlds.length}'),
            _buildStatusRow('Completed Lessons',
                '${userProgress.completedLevels.length}'),
            _buildStatusRow(
                'Streak', '${userProgress.currentStreak} days'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required String description,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
