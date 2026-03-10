import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/level_model.dart' hide ChallengeType;
import '../models/challenge_models.dart';
import '../services/progress_service.dart';
import '../widgets/learning_progress_indicator.dart';
import '../utils/challenge_validator.dart';
import '../utils/hint_manager.dart';
import '../config/dev_config.dart';
import 'result_screen.dart';

/// Enhanced Challenge Screen with multi-step support, hints, and code validation
class ChallengeScreenEnhanced extends StatefulWidget {
  final Level level;
  final List<ChallengeStep>? challengeSteps; // Optional multi-step challenges

  const ChallengeScreenEnhanced({
    Key? key,
    required this.level,
    this.challengeSteps,
  }) : super(key: key);

  @override
  State<ChallengeScreenEnhanced> createState() => _ChallengeScreenEnhancedState();
}

class _ChallengeScreenEnhancedState extends State<ChallengeScreenEnhanced> {
  int _currentStepIndex = 0;
  int _hintsUsed = 0;
  int _mistakesMade = 0;
  String? _userAnswer;
  final TextEditingController _codeController = TextEditingController();
  int _baseXP = 0;
  late HintManager _hintManager;

  @override
  void initState() {
    super.initState();
    print("\n========================================");
    print("ACTIVE SCREEN: challenge_screen_enhanced.dart");
    print("========================================\n");
    
    // Developer Mode Warning
    if (DevConfig.devMode) {
      print("⚠️  DEV MODE ENABLED - All levels unlocked, validation skipped");
    }
    
    _baseXP = widget.level.baseXP;
    // Initialize hint manager with level hints
    _hintManager = HintManager(widget.level.hints);
    
    // Auto-fill starter code in developer mode
    if (DevConfig.devMode && DevConfig.autoComplete) {
      // Use a small delay to ensure controller is ready
      Future.microtask(() {
        _codeController.text = widget.level.expectedCode;
        print("🛠️ DEV MODE: Auto-filled with expected code");
      });
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  ChallengeStep? get currentStep {
    if (widget.challengeSteps != null && widget.challengeSteps!.isNotEmpty) {
      return widget.challengeSteps![_currentStepIndex];
    }
    return null;
  }

  int get totalSteps => widget.challengeSteps?.length ?? 1;

  String getChallengeTypeTitle() {
    final type = currentStep?.type ?? widget.level.challengeType;
    switch (type) {
      case ChallengeType.multipleChoice:
        return 'Multiple Choice';
      case ChallengeType.fillInBlank:
        return 'Fill in the Blank';
      case ChallengeType.fixTheBug:
        return 'Fix the Bug';
      case ChallengeType.buildWidget:
        return 'Build Widget';
      case ChallengeType.arrangeCode:
        return 'Arrange Code';
      case ChallengeType.interactiveCode:
        return 'Interactive Code';
      default:
        return 'Code Challenge';
    }
  }

  void _showHint() {
    final hint = _hintManager.getNextHint();
    
    if (hint == null) {
      // No more hints available
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No more hints available!'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    setState(() {
      _hintsUsed = _hintManager.hintsUsed;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.amber, size: 28),
            const SizedBox(width: 12),
            Text('Hint ${_hintManager.currentHintIndex}/${HintManager.maxHints}'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _hintManager.getHintDisplayText(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hint,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Got it!', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  void _submitAnswer() {
    // Developer Mode: Skip validation and go straight to results
    if (DevConfig.devMode && DevConfig.autoComplete) {
      print("🛠️ DEV MODE: Skipping validation");
      
      final progressService = Provider.of<ProgressService>(context, listen: false);
      progressService.completeLevel(
        level: widget.level,
        hintsUsed: 0,
        mistakesMade: 0,
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            level: widget.level,
            hintsUsed: 0,
            mistakesMade: 0,
          ),
        ),
      );
      return;
    }
    
    // Normal validation flow
    // Get user's code from the controller
    String code = _codeController.text;

    // DEBUG: Print user code before validation
    print("\n==================== SUBMIT ANSWER ====================");
    print("USER CODE:");
    print(code);
    print("======================================================\n");

    // Validate the code using new validator
    bool isValid = ChallengeValidator.validateHelloFlutter(code);

    // DEBUG: Print validation result
    print("VALIDATION RESULT: $isValid\n");

    if (isValid) {
      // Challenge passed!
      print("✅ Challenge Passed");
      _completeLevel();
    } else {
      // Challenge failed - show error dialog
      print("❌ Challenge Failed");
      setState(() {
        _mistakesMade++;
      });
      _showIncorrectDialog();
    }
  }

  void _showIncorrectDialog() {
    final explanation = currentStep?.explanation ?? widget.level.explanation;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.orange.shade700, size: 28),
            const SizedBox(width: 12),
            const Text('Not Quite Right'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Keep trying! Review the question and try again.',
              style: TextStyle(fontSize: 16),
            ),
            if (explanation.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text(
                'Hint:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                explanation.split('\n').first,
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ],
        ),
        actions: [
          if (_hintManager.hasMoreHints())
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showHint();
              },
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Get Hint'),
            ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  /// Calculate XP based on hints used
  /// Rules:
  /// - 0 hints used → full XP (60)
  /// - 1 hint used → -10 XP
  /// - 2 hints used → -20 XP
  /// - 3 hints used → -20 XP
  /// Final XP should never go below 10
  int calculateXP(int baseXP) {
    int hintsUsed = _hintManager.hintsUsed;
    int xp = baseXP;

    if (hintsUsed == 1) {
      xp -= 10;
    } else if (hintsUsed == 2) {
      xp -= 20;
    } else if (hintsUsed >= 3) {
      xp -= 20;
    }

    // Ensure XP never goes below 10
    if (xp < 10) xp = 10;

    print('💰 XP Calculation:');
    print('   Base XP: $baseXP');
    print('   Hints Used: $hintsUsed');
    print('   Final XP: $xp');

    return xp;
  }

  void _completeLevel() {
    print('✅ Challenge completed!');
    print('📊 Hints used: $_hintsUsed');
    print('❌ Mistakes made: $_mistakesMade');
    
    final progressService = Provider.of<ProgressService>(context, listen: false);
    progressService.completeLevel(
      level: widget.level,
      hintsUsed: _hintsUsed,
      mistakesMade: _mistakesMade,
    );

    // Calculate final XP
    final xpEarned = calculateXP(widget.level.baseXP);
    print('💰 Total XP earned: $xpEarned');

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
          if (_hintManager.hasMoreHints())
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.lightbulb_outline),
                  onPressed: _showHint,
                  tooltip: 'Get a hint',
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_hintManager.remainingHints}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          const LearningProgressIndicator(currentStep: 3),
          
          // Step Progress Indicator
          if (totalSteps > 1)
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step ${_currentStepIndex + 1} / $totalSteps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'XP: $_baseXP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (_currentStepIndex + 1) / totalSteps,
                    backgroundColor: Colors.blue.shade100,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade700),
                    minHeight: 8,
                  ),
                ],
              ),
            ),
          
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
                            currentStep?.description ?? widget.level.learningObjective,
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

                  // Challenge Question
                  Text(
                    'Challenge:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentStep?.question ?? widget.level.challengeDescription,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Challenge Input
                  if (currentStep?.type == ChallengeType.multipleChoice ||
                      widget.level.challengeType == ChallengeType.multipleChoice)
                    _buildMultipleChoice()
                  else
                    _buildCodeEditor(),

                  const SizedBox(height: 24),

                  // Stats
                  Row(
                    children: [
                      _buildStatChip(Icons.lightbulb_outline, 'Hints: $_hintsUsed', Colors.blue),
                      const SizedBox(width: 12),
                      _buildStatChip(Icons.error_outline, 'Mistakes: $_mistakesMade', Colors.orange),
                      const SizedBox(width: 12),
                      _buildStatChip(Icons.bolt, 'XP: $_baseXP', Colors.amber),
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
                      child: Text(
                        totalSteps > 1 && _currentStepIndex < totalSteps - 1
                            ? 'Next Step'
                            : 'Submit Answer',
                        style: const TextStyle(
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
    final options = currentStep?.options ?? [];
    if (options.isEmpty) {
      // Fallback to simple choices for old format
      return Column(
        children: [
          _buildChoiceCard('runApp()', 'runApp()'),
          _buildChoiceCard('main()', 'main()'),
          _buildChoiceCard('startApp()', 'startApp()'),
          _buildChoiceCard('begin()', 'begin()'),
        ],
      );
    }

    return Column(
      children: options.map((option) {
        return _buildChoiceCard(option.text, option.id);
      }).toList(),
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
            decoration: InputDecoration(
              hintText: currentStep?.brokenCode ?? '// Write your Flutter code here...',
              hintStyle: const TextStyle(color: Colors.white38),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label, MaterialColor color) {
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
