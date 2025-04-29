import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcards/features/home/presentation/widgets/status_overview_widget.dart';

void main() {
  group('StatusOverviewWidget', () {
    testWidgets('should display all labels and counters', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatusOverviewWidget(
              newWords: 5,
              learning: 3,
              reviewing: 7,
              mastered: 2,
            ),
          ),
        ),
      );

      expect(find.text('New Words'), findsOneWidget);
      expect(find.text('Learning'), findsOneWidget);
      expect(find.text('Reviewing'), findsOneWidget);
      expect(find.text('Mastered'), findsOneWidget);

      expect(find.text('5'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      expect(find.byIcon(Icons.circle), findsNWidgets(4));
    });
  });
}
