import 'package:flashcards/presentation/extensions/context_extensions.dart';
import 'package:flashcards/presentation/screens/learning_screen/widgets/action_button_widget.dart';
import 'package:flashcards/presentation/screens/learning_screen/widgets/progress_lint_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/presentation/widgets/flashcard_widget.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentIndex = 0;

  void _dontKnow() {
    // TODO: логика «не знаю»
    _nextCard();
  }

  void _know() {
    // TODO: логика «знаю»
    _nextCard();
  }

  void _reveal() {
    // TODO: показать обратную сторону карточки
  }

  void _nextCard() {
    setState(() => currentIndex = (currentIndex + 1) % dummyFlashcards.length);
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final w = context.screenWidth;
    final padXS = context.paddingXS;
    final padM = context.paddingM;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey.withOpacity(0.2)),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        child: Column(
          children: [
            _progressLine(context),
            SizedBox(height: h * 0.12),
            SizedBox(
              height: h * 0.3,
              width: w * 0.9,
              child: _cardSwiper(context),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: padM, vertical: padXS),
              child: SizedBox(height: h * 0.28, child: _buttons()),
            ),
          ],
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
            ActionButtonWidget(icon: Icons.close, onTap: _dontKnow),
            ActionButtonWidget(icon: Icons.done, onTap: _know),
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
      cardsCount: dummyFlashcards.length,
      numberOfCardsDisplayed: 3,
      backCardOffset: const Offset(0, -30),
      padding: EdgeInsets.zero,
      isLoop: false,
      cardBuilder:
          (ctx, index, _, __) => FlashcardWidget(
            flashcard: dummyFlashcards[index],
            color: Theme.of(context).colorScheme.primary,
          ),
      onSwipe: (int oldIndex, int? newIndex, _) {
        if (newIndex != null) setState(() => currentIndex = newIndex);
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
