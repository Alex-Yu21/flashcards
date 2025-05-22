import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ProgressLineWidget extends StatelessWidget {
  const ProgressLineWidget({
    super.key,
    required this.learned,
    required this.total,
  });

  final int learned;
  final int total;

  @override
  Widget build(BuildContext context) {
    final double progress = learned / total;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.paddingM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('$total cards')),
          SizedBox(height: context.paddingXS),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: context.paddingXS,
              backgroundColor: Colors.grey.withAlpha((0.2 * 255).round()),
              valueColor: AlwaysStoppedAnimation(
                Theme.of(
                  context,
                ).colorScheme.primaryContainer.withAlpha((0.7 * 255).round()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// FIXME all cards in line
// TODO end window
