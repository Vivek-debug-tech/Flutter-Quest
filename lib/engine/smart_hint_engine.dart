/// Smart Hint Engine
/// 
/// Provides context-aware hints based on detected error types
/// to help learners understand and fix their Flutter code mistakes.
class SmartHintEngine {
  /// Returns a smart hint based on the error type.
  /// Returns a helpful hint string, or null if no specific hint exists.
  static String? getSmartHint(String errorType) {
    switch (errorType) {
      case 'container_children':
        return "💡 Smart Hint: Container is like a box that holds ONE item. "
            "If you need multiple items, wrap them in a Column or Row first, "
            "then put that inside the Container.\n\n"
            "Think: Container → child (singular)";

      case 'row_child':
        return "💡 Smart Hint: Row arranges widgets horizontally (side by side). "
            "Since it can hold multiple widgets, use 'children:' with a list [].\n\n"
            "Think: Row → children (plural) → horizontal layout";

      case 'column_child':
        return "💡 Smart Hint: Column stacks widgets vertically (top to bottom). "
            "Since it can hold multiple widgets, use 'children:' with a list [].\n\n"
            "Think: Column → children (plural) → vertical layout";

      case 'center_children':
        return "💡 Smart Hint: Center widget centers ONE widget in the middle of its parent. "
            "If you need to center multiple widgets, wrap them in a Column or Row first.\n\n"
            "Example: Center(child: Column(children: [...]));";

      case 'padding_children':
        return "💡 Smart Hint: Padding adds space around ONE widget. "
            "If you need padding around multiple widgets, wrap them in a Column or Row first.\n\n"
            "Example: Padding(padding: ..., child: Row(children: [...]));";

      case 'missing_material_app':
        return "💡 Smart Hint: MaterialApp is the root widget that sets up your entire app. "
            "It provides navigation, themes, and Material Design components.\n\n"
            "Structure: runApp(MaterialApp(home: YourScreen()));";

      case 'missing_scaffold':
        return "💡 Smart Hint: Scaffold provides the basic visual structure for a screen. "
            "It gives you an AppBar, body, floating action button, and more.\n\n"
            "Most screens need: Scaffold(body: YourContent());";

      case 'text_without_quotes':
        return "💡 Smart Hint: In Dart, text must be wrapped in quotes to be a String. "
            "Without quotes, Dart thinks it's a variable name.\n\n"
            "Use 'single quotes' or \"double quotes\" around your text.";

      case 'missing_comma':
        return "💡 Smart Hint: In Dart lists, each item must be separated by a comma. "
            "Even the last item should have a comma (it helps with formatting).\n\n"
            "Tip: Add a comma after every widget's closing parenthesis.";

      case 'missing_close_paren':
        return "💡 Smart Hint: Every opening '(' must have a matching closing ')'. "
            "Count your parentheses to find where the closing one is missing.\n\n"
            "Tip: IDEs usually highlight matching pairs when you click on one.";

      case 'extra_close_paren':
        return "💡 Smart Hint: You have more closing ')' than opening '('. "
            "Look for an extra ')' that doesn't belong.\n\n"
            "Tip: Remove parentheses one at a time and check if the error goes away.";

      case 'missing_close_bracket':
        return "💡 Smart Hint: Lists in Dart use brackets []. Every opening '[' needs a closing ']'. "
            "Check your children: [...] lists to ensure they're properly closed.\n\n"
            "Tip: Proper formatting makes brackets easier to match.";

      case 'extra_close_bracket':
        return "💡 Smart Hint: You have more closing ']' than opening '['. "
            "Look for an extra ']' that doesn't belong.\n\n"
            "Tip: Check your children: lists for extra brackets.";

      default:
        // No specific hint for this error type
        return null;
    }
  }

  /// Returns a quick fix suggestion for common errors
  static String? getQuickFix(String errorType) {
    switch (errorType) {
      case 'container_children':
        return "Quick Fix: Change 'children:' to 'child:'";

      case 'row_child':
        return "Quick Fix: Change 'child:' to 'children: [...]'";

      case 'column_child':
        return "Quick Fix: Change 'child:' to 'children: [...]'";

      case 'center_children':
        return "Quick Fix: Change 'children:' to 'child:'";

      case 'padding_children':
        return "Quick Fix: Change 'children:' to 'child:'";

      case 'text_without_quotes':
        return "Quick Fix: Wrap your text in 'quotes'";

      case 'missing_comma':
        return "Quick Fix: Add commas after each widget";

      default:
        return null;
    }
  }

  /// Provides learning resources based on error type
  static String? getLearningTip(String errorType) {
    switch (errorType) {
      case 'container_children':
      case 'center_children':
      case 'padding_children':
        return "📚 Remember: Widgets that wrap ONE child use 'child:', "
            "while widgets that contain MULTIPLE children use 'children:'.";

      case 'row_child':
      case 'column_child':
        return "📚 Remember: Row and Column are layout widgets that hold multiple children. "
            "Think of them as containers that organize several widgets.";

      case 'missing_material_app':
      case 'missing_scaffold':
        return "📚 Remember: Flutter apps have a structure: "
            "MaterialApp → Scaffold → Your Content. Each layer serves a purpose.";

      case 'text_without_quotes':
        return "📚 Remember: Strings (text) must be in quotes. "
            "This is how Dart knows it's text, not a variable name.";

      case 'missing_comma':
        return "📚 Remember: Dart is strict about commas in lists. "
            "It's a good habit to add a trailing comma after every item.";

      default:
        return null;
    }
  }
}
