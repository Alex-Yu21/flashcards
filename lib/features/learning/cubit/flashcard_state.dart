import 'package:flashcards/shared/domain/entities/flashcard.dart';

abstract class FlashcardState {}

class FlashcardInitial extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final List<Flashcard> flashcards;

  FlashcardLoaded(this.flashcards);
}

class FlashcardFinished extends FlashcardState {}
