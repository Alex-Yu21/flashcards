import 'dart:ui';

import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class StartLearningCardSwiperWidget extends StatelessWidget {
  const StartLearningCardSwiperWidget({
    super.key,
    required this.w,
    required this.onTap,
    required this.cards,
  });

  final double w;
  final VoidCallback onTap;
  final List<FlashcardEntity> cards;

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      // TODO if (cards.isEmpty)
    }

    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: CardSwiper(
            isDisabled: true,
            numberOfCardsDisplayed: 3,
            backCardOffset: const Offset(30, -20),
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
                  Expanded(
                    child: Text(
                      'Start learning',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: context.bodyStyle,
                    ),
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
// FIXME last card did not registers? line is not complite