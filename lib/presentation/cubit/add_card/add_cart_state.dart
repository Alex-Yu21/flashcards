enum FieldId { word, transcription, translation, description, example }

sealed class AddCardState {
  const AddCardState();
}

class AddCardInitial extends AddCardState {
  const AddCardInitial();
}

class AddCardEditing extends AddCardState {
  const AddCardEditing({
    required this.id,
    required this.word,
    required this.transcription,
    required this.translation,
    required this.description,
    required this.example,
    required this.errors,
    required this.canSubmit,
    required this.showErrors,
  });

  factory AddCardEditing.empty(String id) => AddCardEditing(
    id: id,
    word: '',
    transcription: '',
    translation: '',
    description: '',
    example: '',
    errors: const {},
    canSubmit: false,
    showErrors: false,
  );

  final String id;
  final String word;
  final String transcription;
  final String translation;
  final String description;
  final String example;
  final Map<FieldId, String?> errors;
  final bool canSubmit;
  final bool showErrors;

  AddCardEditing copyWithField(FieldId id, String v) {
    switch (id) {
      case FieldId.word:
        return copyWith(word: v);
      case FieldId.transcription:
        return copyWith(transcription: v);
      case FieldId.translation:
        return copyWith(translation: v);
      case FieldId.description:
        return copyWith(description: v);
      case FieldId.example:
        return copyWith(example: v);
      // ignore: unreachable_switch_default
      default:
        throw UnsupportedError('Unknown field $id');
    }
  }

  AddCardEditing withValidation(Map<FieldId, String?> errs) =>
      copyWith(errors: errs, canSubmit: errs.values.every((e) => e == null));

  AddCardEditing copyWith({
    String? id,
    String? word,
    String? transcription,
    String? translation,
    String? description,
    String? example,
    Map<FieldId, String?>? errors,
    bool? canSubmit,
    bool? showErrors,
  }) => AddCardEditing(
    id: id ?? this.id,
    word: word ?? this.word,
    transcription: transcription ?? this.transcription,
    translation: translation ?? this.translation,
    description: description ?? this.description,
    example: example ?? this.example,
    errors: errors ?? this.errors,
    canSubmit: canSubmit ?? this.canSubmit,
    showErrors: showErrors ?? this.showErrors,
  );
}

class AddCardsEditing extends AddCardState {
  const AddCardsEditing(this.forms);

  final List<AddCardEditing> forms;

  AddCardsEditing copyWith(List<AddCardEditing> v) => AddCardsEditing(v);
}
