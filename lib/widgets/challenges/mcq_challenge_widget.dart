import 'package:flutter/material.dart';
import '../../models/challenge_models.dart';

/// Widget for rendering Multiple Choice Questions
class MCQChallengeWidget extends StatefulWidget {
  final ChallengeStep step;
  final Function(String) onAnswerSelected;
  final String? selectedAnswer;

  const MCQChallengeWidget({
    Key? key,
    required this.step,
    required this.onAnswerSelected,
    this.selectedAnswer,
  }) : super(key: key);

  @override
  State<MCQChallengeWidget> createState() => _MCQChallengeWidgetState();
}

class _MCQChallengeWidgetState extends State<MCQChallengeWidget> {
  String? _selectedOptionId;

  @override
  void initState() {
    super.initState();
    _selectedOptionId = widget.selectedAnswer;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.step.options == null || widget.step.options!.isEmpty) {
      return const Center(child: Text('No options available'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.quiz, color: Colors.blue.shade700),
                  const SizedBox(width: 8),
                  const Text(
                    'Multiple Choice',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.step.question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (widget.step.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  widget.step.description!,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Options
        ...widget.step.options!.map((option) {
          final isSelected = _selectedOptionId == option.id;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedOptionId = option.id;
                });
                widget.onAnswerSelected(option.id);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue.shade50 : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? Colors.blue.shade600 
                        : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected 
                              ? Colors.blue.shade600 
                              : Colors.grey.shade400,
                          width: 2,
                        ),
                        color: isSelected 
                            ? Colors.blue.shade600 
                            : Colors.transparent,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option.text,
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected 
                              ? Colors.blue.shade900 
                              : Colors.black87,
                          fontWeight: isSelected 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
