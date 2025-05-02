import 'package:flashcards/shared/domain/entities/flashcard.dart';

abstract class FlashcardRepository {
  Future<List<Flashcard>> fetchAllFlashcards();
  Future<void> saveFlashcard(Flashcard card);
}
