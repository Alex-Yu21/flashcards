import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  final FlashcardRepository _repo;
  late List<FlashcardEntity> _cards;

  FlashcardCubit(this._repo) : super(FlashcardInitial());

  Future<void> init() async {
    _cards = await _repo.fetchAllFlashcards();
    emit(FlashcardsLoaded(List.unmodifiable(_cards)));
  }

  void promoteCard(FlashcardEntity card) =>
      _updateCategory(card, card.category.promoteNext);

  void regressCard(FlashcardEntity card) =>
      _updateCategory(card, card.category.regressNext);

  void _updateCategory(FlashcardEntity card, CardCategory newCat) {
    final idx = _cards.indexWhere((c) => c.id == card.id);
    if (idx == -1) return;

    final updated = card.copyWith(category: newCat);
    _cards[idx] = updated;

    _repo.saveFlashcard(updated);

    emit(
      _cards.isEmpty
          ? FlashcardFinished()
          : FlashcardsLoaded(List.unmodifiable(_cards)),
    );
  }

  void addFlashcard(FlashcardEntity card) async {
    await _repo.saveFlashcard(card);
    _cards.add(card);
    emit(FlashcardsLoaded(List.unmodifiable(_cards)));
  }
}

extension FlashcardCopy on FlashcardEntity {
  FlashcardEntity copyWith({CardCategory? category}) => FlashcardEntity(
    id: id,
    title: title,
    transcription: transcription,
    translation: translation,
    description: description,
    example: example,
    audioPath: audioPath,
    category: category ?? this.category,
  );
}
