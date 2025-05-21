import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/add_card/add_cart_state.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit(this._repo, this._flashcardCubit)
    : super(const AddCardInitial());

  final FlashcardRepository _repo;
  final FlashcardCubit _flashcardCubit;
  final _uuid = const Uuid();

  void onChanged(FieldId id, String value) {
    final prev =
        state is AddCardEditing
            ? state as AddCardEditing
            : const AddCardEditing.empty();

    final next = prev.copyWithField(id, value);

    final errs = {
      FieldId.word: _req(next.word),
      FieldId.translation: _req(next.translation),
    };

    emit(next.withValidation(errs));
  }

  Future<void> save() async {
    final s =
        state is AddCardEditing
            ? state as AddCardEditing
            : const AddCardEditing.empty();

    if (!s.canSubmit) {
      emit(s);
      return;
    }

    final card = Flashcard(
      id: _uuid.v4(),
      title: s.word.trim(),
      transcription: s.transcription.trim(),
      translation: s.translation.trim(),
      description: s.description.trim(),
      example: s.example.trim(),
      audioPath: null,
      category: CardCategory.newWords,
    );

    await _repo.saveFlashcard(card);
    _flashcardCubit.addFlashcard(card);

    emit(const AddCardInitial());
  }

  String? _req(String v) => v.trim().isEmpty ? 'empty field' : null;
}
