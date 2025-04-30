import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StatusOverviewWidget extends StatelessWidget {
  const StatusOverviewWidget({
    super.key,
    this.newWords = 0,
    this.learning = 0,
    this.reviewing = 0,
    this.mastered = 0,
  });

  final int newWords;
  final int learning;
  final int reviewing;
  final int mastered;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildStatItem(
              context,
              AppColors.tertiary70,
              'New Words',
              newWords,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              context,
              AppColors.tertiary60,
              'Learning',
              learning,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              context,
              AppColors.tertiary50,
              'Reviewing',
              reviewing,
            ),
          ),
          Expanded(
            child: _buildStatItem(
              context,
              AppColors.tertiary40,
              'Mastered',
              mastered,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    Color color,
    String label,
    int count,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(height: 4),
        Text(label, style: context.captionStyle.copyWith(color: Colors.grey)),
        const SizedBox(height: 8),
        Text(
          '$count',
          style: context.bodyStyle.copyWith(fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
