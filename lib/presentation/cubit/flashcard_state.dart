import 'package:flashcards/domain/entities/flashcard.dart';

abstract class FlashcardState {}

class FlashcardInitial extends FlashcardState {}

class FlashcardsLoaded extends FlashcardState {
  final List<Flashcard> flashcards;

  FlashcardsLoaded(this.flashcards);
}

class FlashcardFinished extends FlashcardState {}
