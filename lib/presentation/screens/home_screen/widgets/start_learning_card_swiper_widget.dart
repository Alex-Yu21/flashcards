import 'dart:ui';

import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/presentation/extensions/context_extensions.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class StartLearningCardSwiperWidget extends StatelessWidget {
  const StartLearningCardSwiperWidget({
    super.key,
    required this.w,
    required this.onTap,
  });

  final double w;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: CardSwiper(
            isDisabled: true,
            numberOfCardsDisplayed: 3,
            backCardOffset: Offset(30, -20),
            cardsCount: 3,
            cardBuilder:
                (context, index, percentThresholdX, percentThresholdY) =>
                    FlashcardWidget(flashcard: dummyFlashcards.last),
            padding: EdgeInsets.zero,
          ),
        ),
        Center(
          child: SizedBox(
            width: w * 0.5,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size.fromHeight(0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start learning',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodyStyle,
                  ),
                  const Icon(Icons.play_arrow, size: 28),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
