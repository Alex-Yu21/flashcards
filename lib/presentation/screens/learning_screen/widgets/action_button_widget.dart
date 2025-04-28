import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ActionButtonWidget({
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onPrimaryContainer;

    return Material(
      shape: const CircleBorder(),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
      elevation: 6,
      child: InkWell(
        highlightColor: AppColors.tertiary40,
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
