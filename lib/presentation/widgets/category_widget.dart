import 'package:confetti/confetti.dart';
import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flashcards/presentation/cubit/unlock_category_cubit.dart';
import 'package:flashcards/presentation/widgets/celebration_confetti_widget.dart';
import 'package:flashcards/presentation/widgets/lock_widget.dart';
import 'package:flashcards/presentation/widgets/timed_count_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.label,
    required this.count,
    required this.caption,
    required this.onTap,
  });

  final String label;
  final StatusItem count;
  final String caption;
  final VoidCallback onTap;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with TickerProviderStateMixin {
  late final ConfettiController _confettiCtrl;
  late final AnimationController _lockController;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnim;

  bool _wasUnlocked = false;
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    _lockController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = Tween<double>(begin: 1.0, end: 0.0).animate(_fadeController);
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 3));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _animate = true);
    });
  }

  @override
  void dispose() {
    _confettiCtrl.dispose();
    _lockController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _triggerUnlockAnimation() {
    _lockController.forward().whenComplete(() => _fadeController.forward());
    Future.delayed(const Duration(seconds: 2), _confettiCtrl.play);
  }

  @override
  void didUpdateWidget(covariant CategoryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.label != 'New words') {
      context.read<CategoryUnlockCubit>().unlock(widget.count);
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = context.screenHeight;
    final padS = context.paddingS;
    final padXS = context.paddingXS;
    final cs = Theme.of(context).colorScheme;

    final unlockState = context.watch<CategoryUnlockCubit>().state;
    final isLocked = !unlockState.isUnlocked;

    if (widget.label == 'New words') {
      return SizedBox(
        height: h * 0.12 < 88 ? 88 : h * 0.12,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 6,
              color: cs.primaryContainer,
              child: InkWell(
                onTap: widget.onTap,
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
                          _StatItem(
                            item: widget.count,
                            shouldAnimate: _animate,
                          ),
                        ],
                      ),
                      SizedBox(height: padXS),
                      Text(
                        '- Add new words',
                        style: context.captionStyle.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return BlocListener<CategoryUnlockCubit, UnlockState>(
      listenWhen: (prev, curr) => !prev.isUnlocked && curr.isUnlocked,
      listener: (context, state) {
        if (!_wasUnlocked && state.isUnlocked) {
          _wasUnlocked = true;
          _triggerUnlockAnimation();
        }
      },
      child: SizedBox(
        height: h * 0.12 < 88 ? 88 : h * 0.12,
        child: Stack(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 6,
              color: cs.primaryContainer,
              child: InkWell(
                onTap: isLocked ? null : widget.onTap,
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
                          _buildRight(isLocked),
                        ],
                      ),
                      SizedBox(height: padXS),
                      Text(
                        _buildCaption(isLocked),
                        style: context.captionStyle.copyWith(
                          color: cs.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CelebrationConfetti(
              controller: _confettiCtrl,
              alignment: Alignment.topRight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRight(bool isLocked) {
    final cs = Theme.of(context).colorScheme;
    if (isLocked) {
      return Icon(Icons.lock, color: cs.onPrimaryContainer);
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        _StatItem(item: widget.count, shouldAnimate: _animate),
        FadeTransition(
          opacity: _fadeAnim,
          child: ShakingLock(
            controller: _lockController,
            shouldAnimate: _wasUnlocked,
          ),
        ),
      ],
    );
  }

  String _buildCaption(bool isLocked) {
    if (!isLocked) return widget.caption;
    return '- Keep learning to unlock';
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.item, required this.shouldAnimate});

  final StatusItem item;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    if (!shouldAnimate) {
      return Text('${item.to}');
    }
    return TimedCountUp(
      style: context.bodyStyle.copyWith(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontSize: context.paddingS,
      ),
      key: ValueKey(item.to),
      start: item.from,
      end: item.to,
      totalDuration: const Duration(seconds: 3),
    );
  }
}
