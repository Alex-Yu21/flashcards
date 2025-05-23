import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_cubit.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_state.dart';
import 'package:flutter_test/flutter_test.dart';

final List<FlashcardEntity> dummyFlashcards = [
  FlashcardEntity(
    id: '1',
    title: 'cane',
    transcription: '[ˈka.ne]',
    audioPath: null,
    description: 'животное',
    translation: 'собака',
    example: 'Il cane corre nel parco.',
  ),
  FlashcardEntity(
    id: '2',
    title: 'gatto',
    transcription: '[ˈɡat.to]',
    audioPath: null,
    description: 'животное',
    translation: 'кот',
    example: 'Il gatto dorme sul divano.',
  ),
  FlashcardEntity(
    id: '3',
    title: 'casa',
    transcription: '[ˈka.sa]',
    audioPath: null,
    description: 'место, где ты живёшь',
    translation: 'дом',
    example: 'La mia casa è grande e luminosa.',
  ),
  FlashcardEntity(
    id: '4',
    title: 'libro',
    transcription: '[ˈli.bro]',
    audioPath: null,
    description: 'читаешь это',
    translation: 'книга',
    example: 'Sto leggendo un libro interessante.',
  ),
  FlashcardEntity(
    id: '5',
    title: 'amico',
    transcription: '[aˈmi.ko]',
    audioPath: null,
    description: 'человек, которому доверяешь',
    translation: 'друг',
    example: 'Il mio amico vive a Roma.',
  ),
  FlashcardEntity(
    id: '6',
    title: 'mela',
    transcription: '[ˈme.la]',
    audioPath: null,
    description: 'красный фрукт',
    translation: 'яблоко',
    example: 'Mangio una mela ogni giorno.',
  ),
  FlashcardEntity(
    id: '7',
    title: 'scuola',
    transcription: '[ˈskwo.la]',
    audioPath: null,
    description: 'место учёбы',
    translation: 'школа',
    example: 'I bambini vanno a scuola ogni mattina.',
  ),
  FlashcardEntity(
    id: '8',
    title: 'sole',
    transcription: '[ˈso.le]',
    audioPath: null,
    description: 'на небе днём',
    translation: 'солнце',
    example: 'Il sole splende alto nel cielo.',
  ),
  FlashcardEntity(
    id: '9',
    title: 'acqua',
    transcription: '[ˈak.kwa]',
    audioPath: null,
    description: 'пьёшь это',
    translation: 'вода',
    example: 'Bevo molta acqua durante il giorno.',
  ),
  FlashcardEntity(
    id: '10',
    title: 'tempo',
    transcription: '[ˈtɛm.po]',
    audioPath: null,
    description: 'идёт всегда',
    translation: 'время / погода (по контексту)',
    example: 'Non ho molto tempo libero.',
  ),
];

class FakeFlashcardRepository implements FlashcardRepository {
  @override
  Future<void> saveFlashcard(FlashcardEntity card) async {
    throw UnimplementedError();
  }

  @override
  Future<List<FlashcardEntity>> fetchAllFlashcards() async {
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
