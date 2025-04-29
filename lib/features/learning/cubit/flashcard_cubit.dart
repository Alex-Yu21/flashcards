import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flashcards/shared/domain/entities/card_category.dart';
import 'package:flashcards/shared/domain/entities/flashcard.dart';
import 'flashcard_state.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  FlashcardCubit() : super(FlashcardInitial());

  final List<Flashcard> _flashcards = [];

  void loadFlashcards(List<Flashcard> cards) {
    _flashcards
      ..clear()
      ..addAll(cards);
    emit(FlashcardLoaded(List.unmodifiable(_flashcards)));
  }

  void changeCategory(Flashcard card, CardCategory newCategory) {
    final index = _flashcards.indexOf(card);
    if (index == -1) return;

    _flashcards[index] = Flashcard(
      title: card.title,
      transcription: card.transcription,
      translation: card.translation,
      description: card.description,
      hint: card.hint,
      audioPath: card.audioPath,
      category: newCategory,
    );
    emit(FlashcardLoaded(List.unmodifiable(_flashcards)));
  }

  void promoteCard(Flashcard card) {
    changeCategory(card, card.category.promoteNext);

    if (_flashcards.isEmpty) {
      emit(FlashcardFinished());
    }
  }

  void regressCard(Flashcard card) {
    changeCategory(card, card.category.regressNext);
    if (_flashcards.isEmpty) {
      emit(FlashcardFinished());
    }
  }
}
