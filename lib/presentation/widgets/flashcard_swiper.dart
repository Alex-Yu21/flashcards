import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';

class FlashcardSwiper extends StatelessWidget {
  const FlashcardSwiper({
    super.key,
    required this.height,
    required this.width,
    required this.flashcards,
    required this.swiperCtrl,
    required this.flipCtrls,
    required this.onSwipe,
  });

  final double height;
  final double width;
  final List<Flashcard> flashcards;
  final CardSwiperController swiperCtrl;
  final List<FlipCardController> flipCtrls;
  final bool Function(int, int?, CardSwiperDirection) onSwipe;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: CardSwiper(
        controller: swiperCtrl,
        cardsCount: flashcards.length,
        numberOfCardsDisplayed: 3,
        allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
          horizontal: true,
        ),
        backCardOffset: const Offset(0, -30),
        padding: EdgeInsets.zero,
        isLoop: false,
        cardBuilder:
            (_, index, __, ___) => FlipCard(
              key: ValueKey('flip_$index'),
              rotateSide: RotateSide.right,
              animationDuration: const Duration(milliseconds: 400),
              onTapFlipping: false,
              axis: FlipAxis.vertical,
              controller: flipCtrls[index],
              frontWidget: FlashcardWidget(
                flashcard: flashcards[index],
                color: Theme.of(context).colorScheme.primary,
              ),
              backWidget: FlashcardWidget(
                flashcard: flashcards[index],
                isTurned: true,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
        onSwipe: onSwipe,
      ),
    );
  }
}
