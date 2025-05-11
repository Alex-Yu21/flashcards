import 'package:flashcards/shared/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    required this.isVisible,
    required this.height,
    required this.rightPadding,
    required this.topPadding,
    required this.bottomPadding,
    required this.buttonSize,
    required this.onUndo,
  });

  final bool isVisible;
  final double height;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;
  final double buttonSize;
  final VoidCallback onUndo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: rightPadding,
        top: topPadding,
        bottom: bottomPadding,
      ),
      child: SizedBox(
        height: height,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder:
              (child, anim) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(anim),
                child: FadeTransition(opacity: anim, child: child),
              ),
          child:
              isVisible
                  ? ActionButtonWidget(
                    key: const ValueKey('undo'),
                    size: buttonSize,
                    icon: Icons.undo,
                    onTap: onUndo,
                  )
                  : const SizedBox(key: ValueKey('empty'), width: 0, height: 0),
        ),
      ),
    );
  }
}
