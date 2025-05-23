import 'package:flashcards/data/datasorces/dictionary_api_dev_remote_ds.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/dictionary_repository.dart';
import 'package:uuid/uuid.dart';

class DictionaryApiDevRepo implements DictionaryRepository {
  DictionaryApiDevRepo(this._ds) : _uuid = const Uuid();
  final DictionaryApiDevRemoteDS _ds;
  final Uuid _uuid;

  @override
  Future<FlashcardEntity?> getWord(String lang, String word) async {
    final list = await _ds.fetch(lang, word);
    return list.isEmpty ? null : list.first.toEntity(_uuid.v4());
  }
}
