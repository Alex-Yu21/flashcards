import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/features/learning/cubit/flashcard_cubit.dart';
import 'package:flashcards/features/learning/cubit/flashcard_state.dart';
import 'package:flashcards/features/learning/presentation/widgets/action_button_widget.dart';
import 'package:flashcards/features/learning/presentation/widgets/progress_line_widget.dart';
import 'package:flashcards/shared/domain/entities/flashcard.dart';
import 'package:flashcards/shared/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/shared/widgets/flashcard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  late final FlashcardCubit _cubit;
  late final CardSwiperController _swiperCtrl;
  List<FlipCardController> _flipCtrls = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cubit = FlashcardCubit(context.read<FlashcardRepository>())..init();
    _swiperCtrl = CardSwiperController();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _reveal() {
    if (_currentIndex < _flipCtrls.length) {
      _flipCtrls[_currentIndex].flipcard();
    }
  }

  void _processAnswer(Flashcard card, CardSwiperDirection dir) {
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
          color: Colors.grey.withAlpha((0.2 * 255).round()),
          child: BlocBuilder<FlashcardCubit, FlashcardState>(
            builder: (_, state) {
              if (state is! FlashcardsLoaded) {
                return const Center(child: CircularProgressIndicator());
              }
              final flashcards = state.flashcards;
              if (_flipCtrls.length != flashcards.length) {
                _flipCtrls = List.generate(
                  flashcards.length,
                  (_) => FlipCardController(),
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(context.paddingM),
                    child: ProgressLineWidget(
                      learned: _currentIndex,
                      total: flashcards.length,
                    ),
                  ),

                  SizedBox(height: h * 0.12),
                  SizedBox(
                    height: h * 0.30,
                    width: w * 0.98,
                    child: CardSwiper(
                      controller: _swiperCtrl,
                      cardsCount: flashcards.length,
                      numberOfCardsDisplayed: 3,
                      allowedSwipeDirection:
                          const AllowedSwipeDirection.symmetric(
                            horizontal: true,
                          ),
                      backCardOffset: const Offset(0, -30),
                      padding: EdgeInsets.zero,
                      isLoop: false,
                      cardBuilder:
                          (_, index, __, ___) => FlipCard(
                            key: ValueKey('flip_$index'),
                            rotateSide: RotateSide.right,
                            animationDuration: const Duration(
                              milliseconds: 400,
                            ),
                            onTapFlipping: false,
                            axis: FlipAxis.vertical,
                            controller: _flipCtrls[index],
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
                      onSwipe: (oldIdx, newIdx, dir) {
                        _processAnswer(flashcards[oldIdx], dir);
                        if (newIdx != null)
                          setState(() => _currentIndex = newIdx);
                        return true;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padM,
                      vertical: padXS,
                    ),
                    child: SizedBox(height: h * 0.28, child: _buttons()),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Stack _buttons() => Stack(
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
