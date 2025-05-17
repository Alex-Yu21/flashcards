import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/presentation/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class AnswerButtons extends StatelessWidget {
  const AnswerButtons({
    super.key,
    required this.onReveal,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  final VoidCallback onReveal;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButtonWidget(
              color: Theme.of(context).colorScheme.error,
              icon: Icons.close,
              onTap: onSwipeLeft,
            ),
            ActionButtonWidget(
              color: AppColors.yes2,
              icon: Icons.done,
              onTap: onSwipeRight,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: ActionButtonWidget(
            onTap: onReveal,
            icon: Icons.visibility_off_outlined,
          ),
        ),
      ],
    );
  }
}
