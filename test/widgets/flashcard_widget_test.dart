import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var testCard = Flashcard(
    id: '1',
    title: 'hello',
    transcription: 'həˈləʊ',
    audioPath: null,
    description: 'greeting',
    translation: 'привет',
    hint: 'He said hello.',
  );

  testWidgets('shoud display the face side of a card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: FlashcardWidget(flashcard: testCard, isTurned: false)),
    );

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('həˈləʊ'), findsOneWidget);
    expect(find.text('he said hello.'), findsOneWidget);

    expect(find.text('Привет'), findsNothing);
    expect(find.text('greeting'), findsNothing);
  });

  testWidgets('shoud display the back side of a card', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: FlashcardWidget(flashcard: testCard, isTurned: true)),
    );

    expect(find.text('Привет'), findsOneWidget);
    expect(find.text('greeting'), findsOneWidget);

    expect(find.text('Hello'), findsNothing);
    expect(find.text('he said hello.'), findsNothing);
  });
}
