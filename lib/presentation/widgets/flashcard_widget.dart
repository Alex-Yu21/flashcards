import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flutter/material.dart';

class FlashcardWidget extends StatelessWidget {
  const FlashcardWidget({
    super.key,
    required this.flashcard,
    this.isTurned = false,
  });

  final Flashcard flashcard;
  final bool isTurned;

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    final hp = sw * 0.05;
    final vp = sh * 0.02;
    final titleSize = sw * 0.09;
    final bodySize = sw * 0.045;
    final iconSize = sw * 0.05;

    Widget buildFront() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                _capitalize(flashcard.title),
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(flashcard.transcription, style: TextStyle(fontSize: bodySize)),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: const Icon(Icons.volume_up),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(flashcard.hint, style: TextStyle(fontSize: bodySize)),
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
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              iconSize: iconSize,
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(flashcard.description, style: TextStyle(fontSize: bodySize)),
        const Spacer(),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            textStyle: TextStyle(fontSize: bodySize),
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
