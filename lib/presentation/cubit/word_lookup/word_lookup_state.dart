import 'package:flashcards/domain/entities/flashcard_entity.dart';

sealed class WordLookupState {}

final class WordLookupIdle extends WordLookupState {}

final class WordLookupLoading extends WordLookupState {}

final class WordLookupEmpty extends WordLookupState {}

final class WordLookupError extends WordLookupState {
  WordLookupError(this.message);
  final String message;
}

final class WordLookupReady extends WordLookupState {
  WordLookupReady(this.entity);
  final FlashcardEntity entity;
}
