import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_state.dart';
import 'package:flashcards/presentation/views/learning/widgets/answer_buttons.dart';
import 'package:flashcards/presentation/views/learning/widgets/flashcard_swiper.dart';
import 'package:flashcards/presentation/views/learning/widgets/progress_line_widget.dart';
import 'package:flashcards/presentation/views/learning/widgets/undo_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';

class LearningView extends StatefulWidget {
  const LearningView({super.key});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  late final CardSwiperController _swiperCtrl;
  List<FlipCardController> _flipCtrls = [];

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _swiperCtrl = CardSwiperController();
  }

  void _reveal() {
    if (_currentIndex < _flipCtrls.length) {
      _flipCtrls[_currentIndex].flipcard();
    }
  }

  void _undoSwipe() {
    if (_currentIndex == 0) return;
    _swiperCtrl.undo();
    setState(() => _currentIndex--);
  }

  void _processAnswer(FlashcardEntity card, CardSwiperDirection dir) {
    final cubit = context.read<FlashcardCubit>();

    if (dir == CardSwiperDirection.left) {
      cubit.regressCard(card);
    } else if (dir == CardSwiperDirection.right) {
      cubit.promoteCard(card);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final padXS = context.paddingXS;
    final padM = context.paddingM;

    return Scaffold(
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ProgressLineWidget(
                  learned: _currentIndex,
                  total: flashcards.length,
                ),
                UndoButton(
                  isVisible: _currentIndex != 0,
                  height: h * 0.16,
                  rightPadding: padM,
                  topPadding: padXS,
                  bottomPadding: padM,
                  buttonSize: h * 0.064,
                  onUndo: _undoSwipe,
                ),
                FlashcardSwiper(
                  height: h * 0.30,
                  width: w * 0.98,
                  flashcards: flashcards,
                  swiperCtrl: _swiperCtrl,
                  flipCtrls: _flipCtrls,
                  onSwipe: (oldIdx, newIdx, dir) {
                    _processAnswer(flashcards[oldIdx], dir);
                    if (newIdx != null) {
                      setState(() => _currentIndex = newIdx);
                    }
                    return true;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: padM,
                    vertical: padXS,
                  ),
                  child: SizedBox(
                    height: h * 0.28,
                    child: AnswerButtons(
                      onReveal: _reveal,
                      onSwipeLeft:
                          () => _swiperCtrl.swipe(CardSwiperDirection.left),
                      onSwipeRight:
                          () => _swiperCtrl.swipe(CardSwiperDirection.right),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// FIXME double promouting 
// TODO dispose  and (promoteCard,_currentIndex, regressCard) in cubit