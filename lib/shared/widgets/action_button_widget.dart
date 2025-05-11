import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final double? size;

  const ActionButtonWidget({
    super.key,
    this.size,
    this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).colorScheme.onPrimaryContainer;
    double finalSize = size ?? context.screenWidth * 0.18;
    return Material(
      shape: const CircleBorder(),
      color:
          color ??
          Theme.of(
            context,
          ).colorScheme.primaryContainer.withAlpha((0.7 * 255).round()),
      elevation: 6,
      child: InkWell(
        highlightColor: AppColors.tertiary40,
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          height: finalSize,
          width: finalSize,
          child: Icon(icon, size: finalSize / 2, color: iconColor),
        ),
      ),
    );
  }
}
