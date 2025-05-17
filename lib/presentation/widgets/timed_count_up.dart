import 'package:flutter/material.dart';

class TimedCountUp extends StatelessWidget {
  const TimedCountUp({
    super.key,
    required this.start,
    required this.end,
    this.totalDuration = const Duration(milliseconds: 800),
    this.style,
  });

  final int start;
  final int end;
  final Duration totalDuration;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: start, end: end),
      duration: totalDuration,
      builder: (_, value, __) => Text('$value', style: style),
    );
  }
}
