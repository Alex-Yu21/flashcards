import 'package:flashcards/features/home/presentation/widgets/start_learning_card_swiper_widget.dart';
import 'package:flashcards/shared/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartLearningCardSwiperWidget', () {
    testWidgets('should render blurred disabled CardSwiper and trigger onTap', (
      WidgetTester tester,
    ) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: StartLearningCardSwiperWidget(
                w: 800,
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      final cardSwiperFinder = find.byType(CardSwiper);
      expect(cardSwiperFinder, findsOneWidget);

      final cardSwiper = tester.widget<CardSwiper>(cardSwiperFinder);
      expect(cardSwiper.isDisabled, isTrue);

      expect(find.byType(FlashcardWidget), findsWidgets);
      expect(find.byType(ImageFiltered), findsOneWidget);

      final buttonFinder = find.widgetWithText(
        ElevatedButton,
        'Start learning',
      );
      expect(buttonFinder, findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
