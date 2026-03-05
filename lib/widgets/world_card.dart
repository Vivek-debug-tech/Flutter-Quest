import 'package:flutter/material.dart';
import '../models/world_model.dart';
import '../services/progress_service.dart';
import 'package:provider/provider.dart';

class WorldCard extends StatelessWidget {
  final World world;
  final VoidCallback onTap;

  const WorldCard({
    Key? key,
    required this.world,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressService = Provider.of<ProgressService>(context);
    final isUnlocked = progressService.isWorldUnlocked(world.id);
    final completion = progressService.getWorldCompletion(world);
    final totalStars = progressService.getWorldStars(world);

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: isUnlocked ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: isUnlocked
                ? LinearGradient(
                    colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.grey.shade300, Colors.grey.shade400],
                  ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    world.icon,
                    style: TextStyle(
                      fontSize: 48,
                      color: isUnlocked ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          world.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isUnlocked ? Colors.white : Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          world.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isUnlocked ? Colors.white70 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isUnlocked)
                    Icon(
                      Icons.lock,
                      size: 32,
                      color: Colors.grey.shade600,
                    ),
                ],
              ),
              const SizedBox(height: 16),
              if (isUnlocked) ...[
                Row(
                  children: [
                    Icon(Icons.stars, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '$totalStars/${world.levels.length * 3}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: LinearProgressIndicator(
                        value: completion,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(completion * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Requires ${world.requiredStars} stars',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
