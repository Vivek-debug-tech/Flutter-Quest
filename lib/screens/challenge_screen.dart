import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/level_model.dart';
import '../services/progress_service.dart';
import '../widgets/learning_progress_indicator.dart';
import 'result_screen.dart';

class ChallengeScreen extends StatefulWidget {
  final Level level;

  const ChallengeScreen({Key? key, required this.level}) : super(key: key);

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int _hintsUsed = 0;
  int _mistakesMade = 0;
  int _currentHintIndex = 0;
  String? _userAnswer;
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  String getChallengeTypeTitle() {
    switch (widget.level.challengeType) {
      case ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case ChallengeType.fixBrokenUI:
        return 'Fix the Code';
      case ChallengeType.buildFromScratch:
        return 'Build From Scratch';
      case ChallengeType.dragAndDrop:
        return 'Drag & Drop';
    }
  }

  void _showHint() {
    if (_currentHintIndex < widget.level.hints.length) {
      setState(() {
        _hintsUsed++;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.lightbulb, color: Colors.amber),
              const SizedBox(width: 8),
              Text('Hint ${_currentHintIndex + 1}'),
            ],
          ),
          content: Text(widget.level.hints[_currentHintIndex]),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _currentHintIndex++;
                });
                Navigator.pop(context);
              },
              child: const Text('Got it!'),
            ),
          ],
        ),
      );
    }
  }

  void _submitAnswer() {
    // Simple validation for demonstration
    // In a real app, you'd have more sophisticated code validation
    
    bool isCorrect = false;

    if (widget.level.challengeType == ChallengeType.multipleChoice) {
      // For multiple choice, check if answer matches the correct answer
      // For "Hello Flutter" level, the correct answer is "runApp()"
      isCorrect = _userAnswer != null && _userAnswer == 'runApp()';
    } else {
      // For code challenges, check if it contains required elements
      final userCode = _codeController.text.trim();
      // Check validation rules
      bool hasAllRules = true;
      for (var rule in widget.level.validationRules) {
        if (!userCode.contains(rule.replaceAll('Must have ', '').replaceAll('Must call ', ''))) {
          hasAllRules = false;
          break;
        }
      }
      isCorrect = userCode.isNotEmpty && hasAllRules;
    }

    if (!isCorrect) {
      setState(() {
        _mistakesMade++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not quite right. Try again!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Complete level
    final progressService = Provider.of<ProgressService>(context, listen: false);
    progressService.completeLevel(
      level: widget.level,
      hintsUsed: _hintsUsed,
      mistakesMade: _mistakesMade,
    );

    // Navigate to result screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          level: widget.level,
          hintsUsed: _hintsUsed,
          mistakesMade: _mistakesMade,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.level.title),
        actions: [
          if (widget.level.hints.isNotEmpty && _currentHintIndex < widget.level.hints.length)
            IconButton(
              icon: const Icon(Icons.lightbulb_outline),
              onPressed: _showHint,
              tooltip: 'Get a hint',
            ),
        ],
      ),
      body: Column(
        children: [
          const LearningProgressIndicator(currentStep: 3),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Challenge Type Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                getChallengeTypeTitle(),
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Learning Objective
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.purple.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.school, color: Colors.purple.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.level.learningObjective,
                      style: TextStyle(
                        color: Colors.purple.shade900,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Challenge Description
            Text(
              'Challenge:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.level.challengeDescription,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Challenge Input
            if (widget.level.challengeType == ChallengeType.multipleChoice)
              _buildMultipleChoice()
            else
              _buildCodeEditor(),

            const SizedBox(height: 24),

            // Stats
            Row(
              children: [
                _buildStatChip(Icons.psychology, 'Hints: $_hintsUsed', Colors.blue),
                const SizedBox(width: 12),
                _buildStatChip(Icons.error_outline, 'Mistakes: $_mistakesMade', Colors.orange),
              ],
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _submitAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Submit Answer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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

  Widget _buildMultipleChoice() {
    return Column(
      children: [
        _buildChoiceCard('runApp()', 'runApp()'),
        _buildChoiceCard('main()', 'main()'),
        _buildChoiceCard('startApp()', 'startApp()'),
        _buildChoiceCard('begin()', 'begin()'),
      ],
    );
  }

  Widget _buildChoiceCard(String label, String value) {
    final isSelected = _userAnswer == value;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isSelected ? Colors.blue.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _userAnswer = value;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: isSelected ? Colors.blue : Colors.grey,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCodeEditor() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade700),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'main.dart',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          TextField(
            controller: _codeController,
            maxLines: 10,
            style: const TextStyle(
              fontFamily: 'monospace',
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: const InputDecoration(
              hintText: '// Write your Flutter code here...',
              hintStyle: TextStyle(color: Colors.white38),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
