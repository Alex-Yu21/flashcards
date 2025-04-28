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
