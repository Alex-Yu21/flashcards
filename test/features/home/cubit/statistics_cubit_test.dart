import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/statistics_cubit.dart';
import 'package:flashcards/presentation/cubit/statistics_state.dart';
import 'package:flutter_test/flutter_test.dart';

final List<Flashcard> dummyFlashcards = [
  Flashcard(
    id: '1',
    title: 'cane',
    transcription: '[ˈka.ne]',
    audioPath: null,
    hint: 'животное',
    translation: 'собака',
    description: 'Il cane corre nel parco.',
    category: CardCategory.newWords,
  ),
  Flashcard(
    id: '2',
    title: 'gatto',
    transcription: '[ˈɡat.to]',
    audioPath: null,
    hint: 'животное',
    translation: 'кот',
    description: 'Il gatto dorme sul divano.',
    category: CardCategory.learning,
  ),
  Flashcard(
    id: '3',
    title: 'casa',
    transcription: '[ˈka.sa]',
    audioPath: null,
    hint: 'место, где ты живёшь',
    translation: 'дом',
    description: 'La mia casa è grande и luminosa.',
    category: CardCategory.newWords,
  ),
];

class FakeFlashcardRepository implements FlashcardRepository {
  @override
  Future<void> saveFlashcard(Flashcard card) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Flashcard>> fetchAllFlashcards() async {
    return dummyFlashcards;
  }
}

void main() {
  final expectedCounts = {CardCategory.newWords: 2, CardCategory.learning: 1};

  blocTest<StatisticsCubit, StatisticsState>(
    'should emit state with correct counts for dummyFlashcards',
    build: () => StatisticsCubit(FakeFlashcardRepository()),
    act: (cubit) => cubit.init(),
    expect:
        () => [
          StatisticsState(
            initialCounts: expectedCounts,
            currentCounts: expectedCounts,
          ),
        ],
  );
}
