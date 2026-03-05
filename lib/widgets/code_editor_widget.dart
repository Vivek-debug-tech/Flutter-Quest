import 'package:flutter/material.dart';

/// Simple code editor widget for editing Flutter code
/// Uses a styled TextField with monospace font and code-like appearance
/// 
/// For full syntax highlighting, add package: code_text_field
/// Then replace TextField with CodeField widget
class CodeEditorWidget extends StatefulWidget {
  final String initialCode;
  final void Function(String code) onCodeChanged;
  final bool readOnly;
  final int maxLines;
  final String placeholder;

  const CodeEditorWidget({
    Key? key,
    this.initialCode = '',
    required this.onCodeChanged,
    this.readOnly = false,
    this.maxLines = 15,
    this.placeholder = '// Write your code here...',
  }) : super(key: key);

  @override
  State<CodeEditorWidget> createState() => _CodeEditorWidgetState();
}

class _CodeEditorWidgetState extends State<CodeEditorWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialCode);
    _controller.addListener(() {
      widget.onCodeChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade700,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Editor header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  color: Colors.blue.shade300,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Code Editor',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                // Language indicator
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade700.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Dart',
                    style: TextStyle(
                      color: Colors.blue.shade200,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Code editor area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _controller,
                readOnly: widget.readOnly,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontFamily: 'Courier',
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
          
          // Line count footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.grey[600],
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  'Lines: ${_controller.text.split('\n').length}',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Characters: ${_controller.text.length}',
                  style: TextStyle(
                    color: Colors.grey[500],
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

/// Compact code display widget (read-only)
class CodeDisplayWidget extends StatelessWidget {
  final String code;
  final String title;

  const CodeDisplayWidget({
    Key? key,
    required this.code,
    this.title = 'Code',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(7),
                topRight: Radius.circular(7),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.code,
                  color: Colors.grey[400],
                  size: 16,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          // Code display
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              code,
              style: const TextStyle(
                fontFamily: 'Courier',
                fontSize: 13,
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Fill-in-the-blank code editor with blanks highlighted
class FillInBlankCodeEditor extends StatefulWidget {
  final String templateCode;
  final List<String> blankPlaceholders;
  final void Function(Map<int, String> answers) onAnswersChanged;

  const FillInBlankCodeEditor({
    Key? key,
    required this.templateCode,
    this.blankPlaceholders = const ['______'],
    required this.onAnswersChanged,
  }) : super(key: key);

  @override
  State<FillInBlankCodeEditor> createState() => _FillInBlankCodeEditorState();
}

class _FillInBlankCodeEditorState extends State<FillInBlankCodeEditor> {
  final Map<int, TextEditingController> _controllers = {};
  final Map<int, String> _answers = {};

  @override
  void initState() {
    super.initState();
    // Find all blanks in template
    for (int i = 0; i < widget.blankPlaceholders.length; i++) {
      _controllers[i] = TextEditingController();
      _controllers[i]!.addListener(() {
        _answers[i] = _controllers[i]!.text;
        widget.onAnswersChanged(_answers);
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.blue.shade700,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Instructions
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade900.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: Colors.yellow.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Fill in the blanks with the correct code',
                    style: TextStyle(
                      color: Colors.blue.shade100,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Code template with inline blanks
          SelectableText(
            widget.templateCode,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Blank input fields
          ...List.generate(
            widget.blankPlaceholders.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Blank ${index + 1}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controllers[index],
                      style: const TextStyle(
                        fontFamily: 'Courier',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: widget.blankPlaceholders[index],
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Courier',
                        ),
                        filled: true,
                        fillColor: Colors.grey[850],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.blue.shade400,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
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
}
