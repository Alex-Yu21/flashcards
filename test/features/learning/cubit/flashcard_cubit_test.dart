import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flashcards/features/learning/cubit/flashcard_cubit.dart';
import 'package:flashcards/features/learning/cubit/flashcard_state.dart';
import 'package:flashcards/shared/domain/entities/flashcard.dart';
import 'package:flashcards/shared/domain/entities/card_category.dart';

void main() {
  group('FlashcardCubit', () {
    blocTest<FlashcardCubit, FlashcardState>(
      'should leave DefaultCat as DefaultCat',
      build: () {
        final cubit =
            FlashcardCubit()..loadFlashcards([
              Flashcard(
                title: 'ciao',
                translation: 'привет',
                description: 'italian hello',
                transcription: '',
                hint: '',
                category: CardCategory.defaultCat,
              ),
            ]);
        return cubit;
      },
      act:
          (cubit) => cubit.promoteCard(
            (cubit.state as FlashcardLoaded).flashcards.first,
          ),
      expect:
          () => [
            isA<FlashcardLoaded>().having(
              (s) => (s as FlashcardLoaded).flashcards.first.category,
              'category',
              CardCategory.defaultCat,
            ),
          ],
    );

    blocTest<FlashcardCubit, FlashcardState>(
      'should promoteCard: NewWords ➜ Learning',
      build: () {
        final cubit =
            FlashcardCubit()..loadFlashcards([
              Flashcard(
                title: 'apple',
                translation: 'яблоко',
                description: 'fruit',
                transcription: '',
                hint: '',
                category: CardCategory.newWords,
              ),
            ]);
        return cubit;
      },
      act:
          (cubit) => cubit.promoteCard(
            (cubit.state as FlashcardLoaded).flashcards.first,
          ),
      expect:
          () => [
            isA<FlashcardLoaded>().having(
              (s) => (s as FlashcardLoaded).flashcards.first.category,
              'category',
              CardCategory.learning,
            ),
          ],
    );
  });
}
