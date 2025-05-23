import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';

class DummyFlashcardRepository implements FlashcardRepository {
  final List<FlashcardEntity> _data;
  DummyFlashcardRepository(this._data);

  @override
  Future<List<FlashcardEntity>> fetchAllFlashcards() async => _data;

  @override
  Future<void> saveFlashcard(FlashcardEntity card) async {
    final i = _data.indexWhere((c) => c.id == card.id);
    if (i != -1) _data[i] = card;
  }
}
