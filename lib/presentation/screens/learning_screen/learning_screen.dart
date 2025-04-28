import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/presentation/extensions/context_extensions.dart';
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
            Padding(
              padding: EdgeInsets.all(context.paddingM),
              child: WordsProgress(learned: 4, total: dummyFlashcards.length),
            ),
            const SizedBox(height: 100),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CardSwiper(
                cardsCount: dummyFlashcards.length,
                numberOfCardsDisplayed: 3,
                backCardOffset: const Offset(0, -30),
                padding: EdgeInsets.zero,
                isLoop: false,
                cardBuilder:
                    (ctx, index, _, __) =>
                        FlashcardWidget(flashcard: dummyFlashcards[index]),
                onSwipe: (int oldIndex, int? newIndex, _) {
                  if (newIndex != null) setState(() => currentIndex = newIndex);
                  return true;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.paddingM),
              child: SizedBox(
                height: context.screenHeight * 0.28,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _RoundAction(icon: Icons.close, onTap: _dontKnow),
                        _RoundAction(icon: Icons.done, onTap: _know),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: _RoundAction(
                        onTap: _reveal,
                        icon: Icons.visibility_off_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundAction({required this.icon, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onPrimaryContainer;

    return Material(
      shape: const CircleBorder(),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
      elevation: 6,
      child: InkWell(
        highlightColor: AppColors.tertiary25,
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: 72,
          width: 72,
          child: Icon(icon, size: 38, color: color),
        ),
      ),
    );
  }
}

class WordsProgress extends StatelessWidget {
  const WordsProgress({super.key, required this.learned, required this.total});

  final int learned;
  final int total;

  @override
  Widget build(BuildContext context) {
    final double progress = learned / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('$total cards')),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
            ),
          ),
        ),
      ],
    );
  }
}
