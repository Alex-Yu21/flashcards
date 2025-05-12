import 'package:confetti/confetti.dart';
import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
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
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  late final ConfettiController _confettiCtrl;
  late int _prevCount;

  @override
  void initState() {
    super.initState();
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 1));
    _prevCount = widget.count;
  }

  @override
  void didUpdateWidget(covariant CategoryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool isNewWords = widget.label == 'New words';

    if (!isNewWords && _prevCount == 0 && widget.count > 0) {
      _confettiCtrl.play();
    }
    _prevCount = widget.count;
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final padS = context.paddingS;
    final padXS = context.paddingXS;
    final cs = Theme.of(context).colorScheme;

    final bool locked = widget.count == 0;
    final bool newWords = widget.label == 'New words';

    Widget buildRight() {
      if (!locked) {
        return Text(
          '${widget.count}',
          style: context.bodyStyle.copyWith(color: cs.onPrimaryContainer),
        );
      }
      if (newWords) {
        return Text(
          '0',
          style: context.bodyStyle.copyWith(color: cs.onPrimaryContainer),
        );
      }
      return const Icon(Icons.lock);
    }

    String buildCaption() {
      if (!locked) return widget.caption;
      return newWords ? '- Add new words' : '- Keep learning to unlock';
    }

    return SizedBox(
      height: h * 0.12 < 88 ? 88 : h * 0.12,
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            elevation: 6,
            color: cs.primaryContainer,
            child: InkWell(
              onTap: locked ? null : widget.onTap,
              child: Padding(
                padding: EdgeInsets.all(padS),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.label,
                          style: context.bodyStyle.copyWith(
                            color: cs.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        buildRight(),
                      ],
                    ),
                    SizedBox(height: padXS),
                    Text(
                      buildCaption(),
                      style: context.captionStyle.copyWith(
                        color: cs.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: ConfettiWidget(
              colors: AppColors.confettiColors,
              confettiController: _confettiCtrl,
              blastDirectionality: BlastDirectionality.explosive,
              minBlastForce: 8,
              maxBlastForce: 20,
              emissionFrequency: 0.02,
              numberOfParticles: 18,
              gravity: 0.45,

              // minimumSize: Size(padXS * 0.6, padXS * 0.6),
              // maximumSize: Size(padXS * 1.2, padXS * 1.2),
            ),
          ),
        ],
      ),
    );
  }
}
