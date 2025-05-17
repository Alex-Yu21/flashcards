import 'package:confetti/confetti.dart';
import 'package:flashcards/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CelebrationConfetti extends StatelessWidget {
  const CelebrationConfetti({
    super.key,
    required this.controller,
    required this.alignment,
    this.minBlastForce = 8,
    this.maxBlastForce = 20,
    this.emissionFrequency = 0.02,
    this.numberOfParticles = 118,
    this.gravity = 0.45,
  });

  final ConfettiController controller;
  final Alignment alignment;

  final double minBlastForce;
  final double maxBlastForce;
  final double emissionFrequency;
  final int numberOfParticles;
  final double gravity;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConfettiWidget(
        createParticlePath: drawLeafHeart,
        minimumSize: const Size(12, 12),
        maximumSize: const Size(36, 36),
        confettiController: controller,
        colors: AppColors.confettiColors,
        blastDirectionality: BlastDirectionality.explosive,
        minBlastForce: minBlastForce,
        maxBlastForce: maxBlastForce,
        emissionFrequency: emissionFrequency,
        numberOfParticles: numberOfParticles,
        gravity: gravity,
      ),
    );
  }
}

Path drawLeafHeart(Size size) {
  final double w = size.width;
  final double h = size.height;
  final Path p = Path();

  p.moveTo(w * 0.5, h);
  p.lineTo(w * 0.47, h * 0.88);
  p.lineTo(w * 0.53, h * 0.88);
  p.lineTo(w * 0.5, h);
  p.moveTo(w * 0.5, h * 0.88);

  p.cubicTo(w * 0.10, h * 0.78, 0, h * 0.45, w * 0.25, h * 0.20);

  p.cubicTo(w * 0.40, h * 0.00, w * 0.60, h * 0.00, w * 0.75, h * 0.20);

  p.cubicTo(w, h * 0.45, w * 0.90, h * 0.78, w * 0.5, h * 0.88);

  p.close();
  return p;
}
