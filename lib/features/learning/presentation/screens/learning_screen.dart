import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/features/learning/cubit/flashcard_cubit.dart';
import 'package:flashcards/features/learning/presentation/widgets/action_button_widget.dart';
import 'package:flashcards/features/learning/presentation/widgets/progress_lint_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/shared/widgets/flashcard_widget.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentIndex = 0;
  late final FlashcardCubit _cubit;
  final _swiperCtrl = CardSwiperController();

  @override
  void initState() {
    super.initState();
    _cubit = FlashcardCubit()..loadFlashcards(dummyFlashcards);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  // void _dontKnow() {
  //   _cubit.regressCard(dummyFlashcards[currentIndex]);
  //   _nextCard();
  // }

  // void _know() {
  //   _cubit.promoteCard(dummyFlashcards[currentIndex]);
  //   _nextCard();
  // }

  void _reveal() {
    // TODO: показать обратную сторону карточки
  }

  // void _nextCard() {
  //   setState(() => currentIndex = (currentIndex + 1) % dummyFlashcards.length);
  // }

  void _processAnswer(CardSwiperDirection dir) {
    final card = dummyFlashcards[currentIndex];
    if (dir == CardSwiperDirection.left) {
      _cubit.regressCard(card);
    } else if (dir == CardSwiperDirection.right) {
      _cubit.promoteCard(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final padXS = context.paddingXS;
    final padM = context.paddingM;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey.withAlpha((0.2 * 255).round()),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha((0.2 * 255).round()),
          ),
          child: Column(
            children: [
              _progressLine(context),
              SizedBox(height: h * 0.12),
              SizedBox(
                height: h * 0.3,
                width: w * 0.98,
                child: _cardSwiper(context),
              ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padM,
                  vertical: padXS,
                ),
                child: SizedBox(height: h * 0.28, child: _buttons()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _buttons() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButtonWidget(
              icon: Icons.close,
              onTap: () => _swiperCtrl.swipe(CardSwiperDirection.left),
            ),
            ActionButtonWidget(
              icon: Icons.done,
              onTap: () => _swiperCtrl.swipe(CardSwiperDirection.right),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: ActionButtonWidget(
            onTap: _reveal,
            icon: Icons.visibility_off_outlined,
          ),
        ),
      ],
    );
  }

  CardSwiper _cardSwiper(BuildContext context) {
    return CardSwiper(
      controller: _swiperCtrl,
      cardsCount: dummyFlashcards.length,
      numberOfCardsDisplayed: 3,
      allowedSwipeDirection: AllowedSwipeDirection.symmetric(
        horizontal: true,
        vertical: false,
      ),
      backCardOffset: const Offset(0, -30),
      padding: EdgeInsets.zero,
      isLoop: false,
      cardBuilder:
          (ctx, index, _, __) => FlashcardWidget(
            flashcard: dummyFlashcards[index],
            color: Theme.of(context).colorScheme.primary,
          ),

      onSwipe: (oldIndex, newIndex, dir) {
        _processAnswer(dir);
        if (newIndex != null) {
          setState(() => currentIndex = newIndex);
        }
        return true;
      },
    );
  }

  Padding _progressLine(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.paddingM),
      child: ProgressLineWidget(
        learned: currentIndex,
        total: dummyFlashcards.length,
      ),
    );
  }
}
