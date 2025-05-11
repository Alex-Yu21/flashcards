import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.label,
    required this.count,
    required this.caption,
    required this.onTap,
  });

  final String label;
  final int count;
  final String caption;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final padS = context.paddingS;
    final padXS = context.paddingXS;
    final cs = Theme.of(context).colorScheme;

    return SizedBox(
      height: h * 0.12 < 88 ? 88 : h * 0.12,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 6,
        color: cs.primaryContainer,
        child: Padding(
          padding: EdgeInsets.all(padS),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: context.bodyStyle.copyWith(
                      color: cs.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$count',
                    style: context.bodyStyle.copyWith(
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              SizedBox(height: padXS),
              Text(
                caption,
                style: context.captionStyle.copyWith(
                  color: cs.onPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
