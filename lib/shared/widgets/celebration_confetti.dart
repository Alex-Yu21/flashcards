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
    this.numberOfParticles = 18,
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
