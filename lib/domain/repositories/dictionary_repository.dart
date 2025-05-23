import 'package:flashcards/domain/entities/flashcard_entity.dart';

abstract class DictionaryRepository {
  Future<FlashcardEntity?> getWord(String lang, String word);
}
