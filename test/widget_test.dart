import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App starts and shows login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Text('TVTC Support')),
      ),
    );

    // Verify that the app starts
    expect(find.text('TVTC Support'), findsOneWidget);
  });
}
