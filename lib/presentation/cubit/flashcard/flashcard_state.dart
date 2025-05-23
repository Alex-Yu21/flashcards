import 'package:flashcards/domain/entities/flashcard_entity.dart';

abstract class FlashcardState {}

class FlashcardInitial extends FlashcardState {}

class FlashcardsLoaded extends FlashcardState {
  final List<FlashcardEntity> flashcards;

  FlashcardsLoaded(this.flashcards);
}

class FlashcardFinished extends FlashcardState {}
