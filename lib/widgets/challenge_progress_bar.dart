import 'package:flutter/material.dart';

/// Progress indicator showing current step progress
class ChallengeProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final int mistakesCount;
  final int hintsUsed;

  const ChallengeProgressBar({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.mistakesCount = 0,
    this.hintsUsed = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final progress = currentStep / totalSteps;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Step indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step $currentStep of $totalSteps',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (mistakesCount > 0) ...[
                    Icon(Icons.close, size: 16, color: Colors.red.shade600),
                    const SizedBox(width: 4),
                    Text(
                      '$mistakesCount',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  if (hintsUsed > 0) ...[
                    Icon(Icons.lightbulb_outline,
                        size: 16, color: Colors.amber.shade700),
                    const SizedBox(width: 4),
                    Text(
                      '$hintsUsed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.amber.shade700,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress bar
          Stack(
            children: [
              // Background
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Progress
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade400, Colors.blue.shade600],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Step circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalSteps, (index) {
              final stepNumber = index + 1;
              final isCompleted = stepNumber < currentStep;
              final isCurrent = stepNumber == currentStep;

              return Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green
                      : isCurrent
                          ? Colors.blue.shade600
                          : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : Text(
                          '$stepNumber',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: isCurrent ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
