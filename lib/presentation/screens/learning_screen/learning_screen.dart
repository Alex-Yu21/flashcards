import 'package:flashcards/core/theme/app_colors.dart';
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
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey.withOpacity(0.2)),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
        child: Column(
          children: [
            _progressLine(context),
            const SizedBox(height: 100),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: _cardSwiper(context),
            ),
            Padding(
              padding: EdgeInsets.all(context.paddingM),
              child: SizedBox(
                height: context.screenHeight * 0.28,
                child: _buttons(),
              ),
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
      child: ProgressLineWidget(learned: 4, total: dummyFlashcards.length),
    );
  }
}
