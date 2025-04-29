import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/features/learning/cubit/flashcard_cubit.dart';
import 'package:flashcards/features/learning/presentation/widgets/action_button_widget.dart';
import 'package:flashcards/features/learning/presentation/widgets/progress_lint_widget.dart';
import 'package:flashcards/shared/domain/entities/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flashcards/shared/widgets/flashcard_widget.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key, required this.flashcards});

  final List<Flashcard> flashcards;

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentIndex = 0;
  late final FlashcardCubit _cubit;
  final _swiperCtrl = CardSwiperController();
  late final List<FlipCardController> _flipCtrls;

  @override
  void initState() {
    super.initState();
    _cubit = FlashcardCubit()..loadFlashcards(widget.flashcards);
    _flipCtrls = List.generate(
      widget.flashcards.length,
      (_) => FlipCardController(),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void _reveal() => _flipCtrls[currentIndex].flipcard();

  void _processAnswer(CardSwiperDirection dir) {
    final card = widget.flashcards[currentIndex];
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

  CardSwiper _cardSwiper(BuildContext context) => CardSwiper(
    controller: _swiperCtrl,
    cardsCount: widget.flashcards.length,
    numberOfCardsDisplayed: 3,
    allowedSwipeDirection: const AllowedSwipeDirection.symmetric(
      horizontal: true,
    ),
    backCardOffset: const Offset(0, -30),
    padding: EdgeInsets.zero,
    isLoop: false,
    cardBuilder:
        (ctx, index, _, __) => FlipCard(
          rotateSide: RotateSide.right,
          animationDuration: const Duration(milliseconds: 400),
          onTapFlipping: false,
          axis: FlipAxis.vertical,
          controller: _flipCtrls[index],
          frontWidget: FlashcardWidget(
            flashcard: widget.flashcards[index],
            color: Theme.of(context).colorScheme.primary,
          ),
          backWidget: FlashcardWidget(
            flashcard: widget.flashcards[index],
            isTurned: true,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
    onSwipe: (oldIndex, newIndex, dir) {
      _processAnswer(dir);
      if (newIndex != null) setState(() => currentIndex = newIndex);
      return true;
    },
  );

  Padding _progressLine(BuildContext context) => Padding(
    padding: EdgeInsets.all(context.paddingM),
    child: ProgressLineWidget(
      learned: currentIndex,
      total: widget.flashcards.length,
    ),
  );
}
