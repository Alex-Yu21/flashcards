import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  final FlashcardRepository _repo;
  late List<Flashcard> _cards;

  FlashcardCubit(this._repo) : super(FlashcardInitial());

  Future<void> init() async {
    _cards = await _repo.fetchAllFlashcards();
    emit(FlashcardsLoaded(List.unmodifiable(_cards)));
  }

  void promoteCard(Flashcard card) =>
      _updateCategory(card, card.category.promoteNext);

  void regressCard(Flashcard card) =>
      _updateCategory(card, card.category.regressNext);

  void _updateCategory(Flashcard card, CardCategory newCat) {
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
}

extension FlashcardCopy on Flashcard {
  Flashcard copyWith({CardCategory? category}) => Flashcard(
    id: id,
    title: title,
    transcription: transcription,
    translation: translation,
    description: description,
    hint: hint,
    audioPath: audioPath,
    category: category ?? this.category,
  );
}
