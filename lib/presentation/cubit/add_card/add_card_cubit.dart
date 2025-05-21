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

    final next = prev.copyWithField(id, value).copyWith(showErrors: false);

    final errs = {
      FieldId.word: _req(next.word),
      FieldId.translation: _req(next.translation),
    };

    emit(next.withValidation(errs));
  }

  Future<void> save() async {
    final current =
        state is AddCardEditing
            ? state as AddCardEditing
            : const AddCardEditing.empty();
    final errs = {
      FieldId.word: _req(current.word),
      FieldId.translation: _req(current.translation),
    };
    final valid = errs.values.every((e) => e == null);

    if (!valid) {
      emit(current.copyWith(errors: errs, showErrors: true, canSubmit: false));
      return;
    }

    final card = Flashcard(
      id: _uuid.v4(),
      title: current.word.trim(),
      transcription: current.transcription.trim(),
      translation: current.translation.trim(),
      description: current.description.trim(),
      example: current.example.trim(),
      audioPath: null,
      category: CardCategory.newWords,
    );

    await _repo.saveFlashcard(card);
    _flashcardCubit.addFlashcard(card);

    emit(const AddCardInitial());
  }

  String? _req(String v) => v.trim().isEmpty ? 'empty field' : null;
}
