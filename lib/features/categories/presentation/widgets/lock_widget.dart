import 'package:flutter/material.dart';

class ShakingLock extends StatelessWidget {
  const ShakingLock({
    super.key,
    required this.controller,
    required this.shouldAnimate,
  });

  final AnimationController controller;
  final bool shouldAnimate;

  @override
  Widget build(BuildContext context) {
    final offsetAnim = controller.drive(
      TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
        TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
      ]),
    );
    return AnimatedBuilder(
      animation: offsetAnim,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(offsetAnim.value, 0),
          child: child,
        );
      },
      child: const Icon(Icons.lock),
    );
  }
}
