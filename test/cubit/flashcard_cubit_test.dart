import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _MemoryRepo implements FlashcardRepository {
  final List<Flashcard> _store;
  _MemoryRepo(this._store);

  @override
  Future<List<Flashcard>> fetchAllFlashcards() async => _store;

  @override
  Future<void> saveFlashcard(Flashcard card) async {
    final i = _store.indexWhere((c) => c.id == card.id);
    if (i != -1) _store[i] = card;
  }
}

void main() {
  group('FlashcardCubit', () {
    blocTest<FlashcardCubit, FlashcardState>(
      'leave DefaultCat as DefaultCat',
      build: () {
        final repo = _MemoryRepo([
          Flashcard(
            id: '1',
            title: 'ciao',
            translation: 'привет',
            description: 'italian hello',
            transcription: '',
            hint: '',
            category: CardCategory.defaultCat,
          ),
        ]);
        return FlashcardCubit(repo);
      },
      act: (cubit) async {
        await cubit.init();
        final card = (cubit.state as FlashcardsLoaded).flashcards.first;
        cubit.promoteCard(card);
      },
      expect:
          () => [
            isA<FlashcardsLoaded>(),
            isA<FlashcardsLoaded>().having(
              (s) => (s).flashcards.first.category,
              'category',
              CardCategory.defaultCat,
            ),
          ],
    );

    blocTest<FlashcardCubit, FlashcardState>(
      'promoteCard: NewWords ➜ Learning',
      build: () {
        final repo = _MemoryRepo([
          Flashcard(
            id: '2',
            title: 'apple',
            translation: 'яблоко',
            description: 'fruit',
            transcription: '',
            hint: '',
            category: CardCategory.newWords,
          ),
        ]);
        return FlashcardCubit(repo);
      },
      act: (cubit) async {
        await cubit.init();
        final card = (cubit.state as FlashcardsLoaded).flashcards.first;
        cubit.promoteCard(card);
      },
      expect:
          () => [
            isA<FlashcardsLoaded>(),
            isA<FlashcardsLoaded>().having(
              (s) => (s).flashcards.first.category,
              'category',
              CardCategory.learning,
            ),
          ],
    );
  });
}
