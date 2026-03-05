import 'package:flutter/material.dart';
import '../models/challenge_models.dart';
import '../services/code_validation_service.dart';
import '../widgets/code_editor_widget.dart';

/// Interactive Code Challenge Screen
/// Allows users to edit and run Flutter code challenges with validation
class InteractiveCodeChallengeScreen extends StatefulWidget {
  final ChallengeStep challenge;
  final VoidCallback? onSuccess;
  final VoidCallback? onSkip;

  const InteractiveCodeChallengeScreen({
    Key? key,
    required this.challenge,
    this.onSuccess,
    this.onSkip,
  }) : super(key: key);

  @override
  State<InteractiveCodeChallengeScreen> createState() => 
      _InteractiveCodeChallengeScreenState();
}

class _InteractiveCodeChallengeScreenState 
    extends State<InteractiveCodeChallengeScreen> {
  
  String _userCode = '';
  int _hintsUsed = 0;
  int _attempts = 0;
  bool _isValidating = false;

  @override
  void initState() {
    super.initState();
    // Initialize with broken code if available (for fix-the-bug challenges)
    if (widget.challenge.type == ChallengeType.fixTheBug && 
        widget.challenge.brokenCode != null) {
      _userCode = widget.challenge.brokenCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Code Challenge'),
        backgroundColor: Colors.blue[700],
        elevation: 0,
        actions: [
          // Skip button
          if (widget.onSkip != null)
            TextButton.icon(
              onPressed: widget.onSkip,
              icon: const Icon(Icons.skip_next, color: Colors.white),
              label: const Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Challenge header
            _buildChallengeHeader(),
            
            // Main content area (scrollable)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Challenge description
                    _buildDescription(),
                    
                    const SizedBox(height: 20),
                    
                    // Code editor
                    _buildCodeEditor(),
                    
                    const SizedBox(height: 20),
                    
                    // Action buttons
                    _buildActionButtons(),
                    
                    const SizedBox(height: 16),
                    
                    // Stats
                    _buildStats(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[700],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Challenge type badge
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getChallengeIcon(),
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _getChallengeTypeName(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // XP reward
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.challenge.xpReward} XP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Challenge question
          Text(
            widget.challenge.question,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    if (widget.challenge.description == null) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue[200]!,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue[700],
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              widget.challenge.description!,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeEditor() {
    return SizedBox(
      height: 400,
      child: CodeEditorWidget(
        initialCode: _userCode,
        onCodeChanged: (code) {
          setState(() {
            _userCode = code;
          });
        },
        placeholder: _getPlaceholder(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Run Code button
        ElevatedButton.icon(
          onPressed: _isValidating ? null : _runCode,
          icon: _isValidating
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Icon(Icons.play_arrow, size: 24),
          label: Text(
            _isValidating ? 'Validating...' : 'Run Code',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(double.infinity, 56),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Secondary action buttons
        Row(
          children: [
            // Hint button
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _canShowHint() ? _showHint : null,
                icon: const Icon(Icons.lightbulb_outline, size: 20),
                label: Text(
                  'Hint (${_hintsUsed}/${widget.challenge.hints.length})',
                  style: const TextStyle(fontSize: 14),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange[700],
                  side: BorderSide(
                    color: _canShowHint() 
                        ? Colors.orange[700]! 
                        : Colors.grey[400]!,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 12),
            
            // Submit button
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _userCode.trim().isEmpty ? null : _submitAnswer,
                icon: const Icon(Icons.check, size: 20),
                label: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.replay,
            label: 'Attempts',
            value: _attempts.toString(),
            color: Colors.blue,
          ),
          _buildStatItem(
            icon: Icons.lightbulb,
            label: 'Hints Used',
            value: _hintsUsed.toString(),
            color: Colors.orange,
          ),
          _buildStatItem(
            icon: Icons.star,
            label: 'XP Reward',
            value: widget.challenge.xpReward.toString(),
            color: Colors.amber,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required MaterialColor color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color[700], size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color[700],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // ===== CHALLENGE LOGIC =====

  void _runCode() async {
    if (_userCode.trim().isEmpty) {
      _showErrorDialog('Please write some code first!');
      return;
    }

    setState(() {
      _isValidating = true;
      _attempts++;
    });

    // Simulate validation delay
    await Future.delayed(const Duration(milliseconds: 800));

    final result = _validateCode();

    setState(() {
      _isValidating = false;
    });

    if (result.isCorrect) {
      _showSuccessDialog(result.feedback);
    } else {
      _showErrorDialog(result.feedback);
    }
  }

  void _submitAnswer() {
    _runCode();
  }

  ValidationResult _validateCode() {
    return CodeValidationService.validateCode(
      userCode: _userCode,
      correctAnswer: widget.challenge.correctAnswer,
      validationRules: widget.challenge.validationRules,
    );
  }

  bool _canShowHint() {
    return _hintsUsed < widget.challenge.hints.length;
  }

  void _showHint() {
    if (!_canShowHint()) return;

    final hint = widget.challenge.hints[_hintsUsed];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.orange[700]),
            const SizedBox(width: 8),
            Text('Hint ${_hintsUsed + 1}'),
          ],
        ),
        content: Text(
          hint,
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _hintsUsed++;
              });
            },
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String feedback) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[600], size: 32),
            const SizedBox(width: 12),
            const Text('Correct!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            
            if (widget.challenge.explanation != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.challenge.explanation!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue[900],
                    height: 1.4,
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // XP earned
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.yellow[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.yellow[700]!),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.yellow[700]),
                  const SizedBox(width: 8),
                  Text(
                    '+${widget.challenge.xpReward} XP earned!',
                    style: TextStyle(
                      color: Colors.yellow[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.onSuccess != null) {
                widget.onSuccess!();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String feedback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.orange[700], size: 32),
            const SizedBox(width: 12),
            const Text('Not Quite Right'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            
            const SizedBox(height: 16),
            
            // Hint suggestion
            if (_canShowHint())
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.orange[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Need help? Try using a hint!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        actions: [
          if (_canShowHint())
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                _showHint();
              },
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('Show Hint'),
            ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  // ===== HELPER METHODS =====

  IconData _getChallengeIcon() {
    switch (widget.challenge.type) {
      case ChallengeType.fixTheBug:
        return Icons.bug_report;
      case ChallengeType.buildWidget:
        return Icons.widgets;
      case ChallengeType.fillInBlank:
        return Icons.edit;
      default:
        return Icons.code;
    }
  }

  String _getChallengeTypeName() {
    switch (widget.challenge.type) {
      case ChallengeType.fixTheBug:
        return 'Fix the Bug';
      case ChallengeType.buildWidget:
        return 'Build Widget';
      case ChallengeType.fillInBlank:
        return 'Fill in Blank';
      case ChallengeType.arrangeCode:
        return 'Arrange Code';
      default:
        return 'Code Challenge';
    }
  }

  String _getPlaceholder() {
    switch (widget.challenge.type) {
      case ChallengeType.fixTheBug:
        return '// Fix the bug in this code...';
      case ChallengeType.buildWidget:
        return '// Write your widget code here...';
      case ChallengeType.fillInBlank:
        return '// Complete the code...';
      default:
        return '// Write your code here...';
    }
  }
}

/// Example usage and integration
class InteractiveCodeChallengeExample {
  static ChallengeStep getExampleChallenge() {
    return const ChallengeStep(
      id: 'code_challenge_1',
      stepNumber: 1,
      type: ChallengeType.fillInBlank,
      question: 'Complete the Main Function',
      description: 'Fill in the blank to launch the Flutter app.',
      xpReward: 20,
      correctAnswer: 'runApp',
      validationRules: ['runApp', 'MyApp'],
      hints: [
        'This function launches widgets.',
        'It is called inside main().',
        'The function starts with "run".',
      ],
      explanation: 'runApp() launches the Flutter app. It takes a widget '
          'as a parameter and makes it the root of the widget tree.',
    );
  }
  
  static void showExample(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InteractiveCodeChallengeScreen(
          challenge: getExampleChallenge(),
          onSuccess: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Challenge completed!')),
            );
          },
        ),
      ),
    );
  }
}
