import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/dictionary_repository.dart';

class MultiSourceDictionaryRepo implements DictionaryRepository {
  MultiSourceDictionaryRepo(this._sources);
  final List<DictionaryRepository> _sources;

  @override
  Future<FlashcardEntity?> getWord(String lang, String word) async {
    for (final s in _sources) {
      try {
        final entity = await s.getWord(lang, word);
        if (entity != null) return entity;
      } catch (_) {
        // TODO log errors
      }
    }
    return null;
  }
}
