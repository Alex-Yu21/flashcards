import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/add_card/add_cart_state.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit(this._repo, this._flashcardCubit)
    : _uuid = const Uuid(),
      super(AddCardsEditing([AddCardEditing.empty(const Uuid().v4())]));
  final FlashcardRepository _repo;
  final FlashcardCubit _flashcardCubit;
  final Uuid _uuid;

  void addForm() {
    final prevForms = _forms;
    emit(AddCardsEditing([...prevForms, AddCardEditing.empty(_uuid.v4())]));
  }

  void removeForm(String id) {
    final list = [..._forms]..removeWhere((e) => e.id == id);
    emit(
      list.isEmpty
          ? AddCardsEditing([AddCardEditing.empty(_uuid.v4())])
          : AddCardsEditing(list),
    );
  }

  void onChanged(FieldId id, String value, {int index = 0}) {
    final prevForms = _forms;

    AddCardEditing prev = prevForms[index];
    AddCardEditing next = prev
        .copyWithField(id, value)
        .copyWith(showErrors: false);

    final errs = <FieldId, String?>{
      FieldId.word: _req(next.word),
      FieldId.translation: _req(next.translation),
    };

    next = next.withValidation(errs);

    final newForms = [...prevForms]..[index] = next;
    emit(AddCardsEditing(newForms));
  }

  Future<void> save() async {
    final currentForms = _forms;

    final hasErrors = currentForms.any(
      (e) => _req(e.word) != null || _req(e.translation) != null,
    );

    if (hasErrors) {
      final highlighted = [
        for (final e in currentForms)
          e.copyWith(
            errors: {
              FieldId.word: _req(e.word),
              FieldId.translation: _req(e.translation),
            },
            showErrors: true,
            canSubmit: false,
          ),
      ];
      emit(AddCardsEditing(highlighted));
      return;
    }

    for (final e in currentForms) {
      final card = Flashcard(
        id: _uuid.v4(),
        title: e.word.trim(),
        transcription: e.transcription.trim(),
        translation: e.translation.trim(),
        description: e.description.trim(),
        example: e.example.trim(),
        audioPath: null,
        category: CardCategory.newWords,
      );
      await _repo.saveFlashcard(card);
      _flashcardCubit.addFlashcard(card);
    }

    emit(AddCardsEditing([AddCardEditing.empty(_uuid.v4())]));
  }

  List<AddCardEditing> get _forms =>
      state is AddCardsEditing
          ? (state as AddCardsEditing).forms
          : [AddCardEditing.empty(_uuid.v4())];

  String? _req(String v) => v.trim().isEmpty ? 'empty field' : null;
}
