import 'package:flutter/material.dart';

/// Widget for displaying hints in challenges
/// Shows progressive hints with visual indicators
class HintWidget extends StatelessWidget {
  final List<String> displayedHints;
  final int totalHintsAvailable;
  final int hintsUsed;
  final VoidCallback onRequestHint;
  final bool hasMoreHints;
  final int xpPenaltyPerHint;

  const HintWidget({
    Key? key,
    required this.displayedHints,
    required this.totalHintsAvailable,
    required this.hintsUsed,
    required this.onRequestHint,
    required this.hasMoreHints,
    this.xpPenaltyPerHint = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber.shade50,
            Colors.orange.shade50,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.amber.shade200,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with hint icon and counter
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lightbulb,
                  color: Colors.amber.shade700,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hints',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber.shade900,
                      ),
                    ),
                    Text(
                      '$hintsUsed/$totalHintsAvailable used • -$xpPenaltyPerHint XP each',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasMoreHints)
                ElevatedButton.icon(
                  onPressed: onRequestHint,
                  icon: const Icon(Icons.help_outline, size: 18),
                  label: const Text('Get Hint'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
            ],
          ),
          
          if (displayedHints.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            
            // Display hints list
            ...displayedHints.asMap().entries.map((entry) {
              final index = entry.key;
              final hint = entry.value;
              final isStrongerHint = index >= 2; // After 2 hints, show stronger guidance
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildHintCard(
                  hintNumber: index + 1,
                  hint: hint,
                  isStrongerHint: isStrongerHint,
                ),
              );
            }).toList(),
          ],
          
          if (displayedHints.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Need help? Click "Get Hint" to reveal a clue.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          
          if (!hasMoreHints && displayedHints.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade300),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'No more hints available. Try solving it yourself!',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.orange.shade900,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHintCard({
    required int hintNumber,
    required String hint,
    required bool isStrongerHint,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isStrongerHint ? Colors.orange.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isStrongerHint ? Colors.orange.shade300 : Colors.amber.shade200,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hint number badge
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: isStrongerHint ? Colors.orange.shade600 : Colors.amber.shade600,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                '$hintNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Hint text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isStrongerHint)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      'STRONGER HINT',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange.shade700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                Text(
                  hint,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.4,
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

/// Compact hint button for embedding in challenge widgets
class HintButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool hasMoreHints;
  final int hintsUsed;
  final int totalHints;
  final int xpPenalty;

  const HintButton({
    Key? key,
    required this.onPressed,
    required this.hasMoreHints,
    required this.hintsUsed,
    required this.totalHints,
    this.xpPenalty = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: hasMoreHints ? onPressed : null,
      icon: Icon(
        Icons.lightbulb_outline,
        size: 18,
        color: hasMoreHints ? Colors.amber.shade700 : Colors.grey,
      ),
      label: Text(
        hasMoreHints 
            ? 'Hint ($hintsUsed/$totalHints) -${xpPenalty}XP'
            : 'No More Hints',
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: hasMoreHints ? Colors.amber.shade700 : Colors.grey,
        side: BorderSide(
          color: hasMoreHints ? Colors.amber.shade300 : Colors.grey.shade300,
          width: 1.5,
        ),
        backgroundColor: hasMoreHints ? Colors.amber.shade50 : Colors.grey.shade100,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
