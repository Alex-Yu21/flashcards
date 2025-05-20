import 'package:flashcards/domain/entities/card_category.dart';

class Flashcard {
  Flashcard({
    required this.id,
    required this.title,
    required this.transcription,
    this.audioPath,
    required this.example,
    required this.translation,
    required this.description,
    this.category = CardCategory.newWords,
  });

  final String id;
  final String title;
  final String transcription;
  final String? audioPath;
  final String description;
  final String translation;
  final String example;
  CardCategory category;
}
