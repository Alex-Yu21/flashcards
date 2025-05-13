import 'package:confetti/confetti.dart';
import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/shared/widgets/celebration_confetti_widget.dart';
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
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 3));
    _prevCount = widget.count;
  }

  @override
  void didUpdateWidget(covariant CategoryWidget oldWidget) async {
    super.didUpdateWidget(oldWidget);
    final bool isNewWords = widget.label == 'New words';

    Future.microtask(() {
      if (!isNewWords && _prevCount == 0 && widget.count > 0) {
        Future.delayed(const Duration(seconds: 1));
        _confettiCtrl.play();
      }
      _prevCount = widget.count;
    });
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
          if (widget.label != 'New words')
            CelebrationConfetti(
              controller: _confettiCtrl,
              alignment: Alignment.topRight,
            ),
        ],
      ),
    );
  }
}
