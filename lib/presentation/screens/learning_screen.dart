import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/flashcard_state.dart';
import 'package:flashcards/presentation/widgets/answer_buttons.dart';
import 'package:flashcards/presentation/widgets/flashcard_swiper.dart';
import 'package:flashcards/presentation/widgets/progress_line_widget.dart';
import 'package:flashcards/presentation/widgets/undo_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';

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

  void _undoSwipe() {
    if (_currentIndex == 0) return;
    _swiperCtrl.undo();
    setState(() => _currentIndex--);
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
                      if (newIdx != null)
                        setState(() => _currentIndex = newIdx);
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
      ),
    );
  }
}
