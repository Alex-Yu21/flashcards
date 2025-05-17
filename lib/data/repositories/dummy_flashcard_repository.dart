import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';

class DummyFlashcardRepository implements FlashcardRepository {
  final List<Flashcard> _data;
  DummyFlashcardRepository(this._data);

  @override
  Future<List<Flashcard>> fetchAllFlashcards() async => _data;

  @override
  Future<void> saveFlashcard(Flashcard card) async {
    final i = _data.indexWhere((c) => c.id == card.id);
    if (i != -1) _data[i] = card;
  }
}
