import 'package:flashcards/core/extensions/context_extensions.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flutter/material.dart';

class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    super.key,
    required this.flashcard,
    this.isTurned = false,
    this.color,
    this.textColor,
  });

  final FlashcardEntity flashcard;
  final bool isTurned;
  final Color? color;
  final Color? textColor;

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final sw = context.screenWidth;
    final sh = context.screenHeight;
    final cardColor = color ?? Theme.of(context).colorScheme.primaryContainer;
    final txColor =
        textColor ?? Theme.of(context).colorScheme.onPrimaryContainer;

    final hp = sw * 0.05;
    final vp = sh * 0.02;
    final iconSize = sw * 0.05;

    Widget buildFront() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _capitalize(flashcard.title),
                style: context.headerStyle.copyWith(color: txColor),
              ),
            ),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: Icon(Icons.edit, color: txColor),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              flashcard.transcription?.toLowerCase() ?? '',
              style: context.captionStyle.copyWith(color: txColor),
            ),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: Icon(Icons.volume_up, color: txColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          flashcard.description?.toLowerCase() ?? '',
          style: context.bodyStyle.copyWith(color: txColor),
        ),
      ],
    );

    Widget buildBack() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _capitalize(flashcard.translation),
                style: context.headerStyle.copyWith(color: txColor),
              ),
            ),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: Icon(Icons.edit, color: txColor),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          flashcard.example?.toLowerCase() ?? '',
          style: context.bodyStyle.copyWith(color: txColor),
        ),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: context.captionSize, color: txColor),
          ),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Learn more'),
              Icon(Icons.chevron_right, size: iconSize * 0.8),
            ],
          ),
        ),
      ],
    );

    return Card(
      color: cardColor,
      margin: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hp, vertical: vp),
        child: isTurned ? buildBack() : buildFront(),
      ),
    );
  }
}

// TODO VoidCallback? onEdit, VoidCallback? onPlayAudio, VoidCallback? onLearnMore
// TODO Row _buildHeader(String text, VoidCallback? onEdit)
