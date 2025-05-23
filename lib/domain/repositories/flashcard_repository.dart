import 'package:flashcards/domain/entities/flashcard_entity.dart';

abstract class FlashcardRepository {
  Future<List<FlashcardEntity>> fetchAllFlashcards();
  Future<void> saveFlashcard(FlashcardEntity card);
}
