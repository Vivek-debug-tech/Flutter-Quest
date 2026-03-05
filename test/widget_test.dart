// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_game/main.dart';
import 'package:flutter_game/services/storage_service.dart';

void main() {
  testWidgets('FlutterQuest app smoke test', (WidgetTester tester) async {
    // Initialize storage service for testing
    final storageService = StorageService();
    await storageService.init();
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(FlutterQuestApp(storageService: storageService));

    // Verify the app loads
    expect(find.text('Choose Your Quest'), findsOneWidget);
    expect(find.text('Flutter Basics'), findsOneWidget);
  });
}
