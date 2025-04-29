import 'package:flashcards/shared/domain/entities/card_category.dart';

class Flashcard {
  Flashcard({
    required this.title,
    required this.transcription,
    this.audioPath,
    required this.hint,
    required this.translation,
    required this.description,
    this.category = CardCategory.newWords,
  });

  final String title;
  final String transcription;
  final String? audioPath;
  final String hint;
  final String translation;
  final String description;
  CardCategory category;
}
