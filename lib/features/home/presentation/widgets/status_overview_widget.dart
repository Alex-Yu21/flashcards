import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flashcards/features/home/cubit/status_overview_cubit.dart';
import 'package:flashcards/shared/widgets/timed_count_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusOverviewWidget extends StatelessWidget {
  const StatusOverviewWidget({super.key});

  static const _animDuration = Duration(milliseconds: 800);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatusOverviewCubit, StatusOverviewState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _StatItem(
                  color: AppColors.tertiary70,
                  label: 'New Words',
                  item: state.newWords,
                ),
              ),
              Expanded(
                child: _StatItem(
                  color: AppColors.tertiary60,
                  label: 'Learning',
                  item: state.learning,
                ),
              ),
              Expanded(
                child: _StatItem(
                  color: AppColors.tertiary50,
                  label: 'Reviewing',
                  item: state.reviewing,
                ),
              ),
              Expanded(
                child: _StatItem(
                  color: AppColors.tertiary40,
                  label: 'Mastered',
                  item: state.mastered,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.color,
    required this.label,
    required this.item,
  });

  final Color color;
  final String label;
  final StatusItem item;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.bodyStyle.copyWith(fontWeight: FontWeight.w300);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(height: 4),
        Text(label, style: context.captionStyle.copyWith(color: Colors.grey)),
        const SizedBox(height: 8),

        item.delta == 0
            ? TimedCountUp(
              start: item.from,
              end: item.to,
              totalDuration: StatusOverviewWidget._animDuration,
              style: textStyle,
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TimedCountUp(
                  start: item.from,
                  end: item.to,
                  totalDuration: StatusOverviewWidget._animDuration,
                  style: textStyle,
                ),
                const SizedBox(width: 2),
                Text(
                  item.delta > 0 ? '+${item.delta}' : '${item.delta}',
                  style: context.captionStyle.copyWith(
                    color:
                        item.delta > 0
                            ? const Color.fromARGB(255, 98, 156, 33)
                            : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
