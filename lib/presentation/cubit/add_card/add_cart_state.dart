enum FieldId { word, transcription, translation, description, example }

sealed class AddCardState {
  const AddCardState();
}

class AddCardInitial extends AddCardState {
  const AddCardInitial();
}

class AddCardEditing extends AddCardState {
  const AddCardEditing({
    required this.word,
    required this.transcription,
    required this.translation,
    required this.description,
    required this.example,
    required this.errors,
    required this.canSubmit,
  });

  const AddCardEditing.empty()
    : this(
        word: '',
        transcription: '',
        translation: '',
        description: '',
        example: '',
        errors: const {},
        canSubmit: false,
      );

  final String word;
  final String transcription;
  final String translation;
  final String description;
  final String example;
  final Map<FieldId, String?> errors;
  final bool canSubmit;

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
    }
  }

  AddCardEditing withValidation(Map<FieldId, String?> errs) =>
      copyWith(errors: errs, canSubmit: errs.values.every((e) => e == null));

  AddCardEditing copyWith({
    String? word,
    String? transcription,
    String? translation,
    String? description,
    String? example,
    Map<FieldId, String?>? errors,
    bool? canSubmit,
  }) => AddCardEditing(
    word: word ?? this.word,
    transcription: transcription ?? this.transcription,
    translation: translation ?? this.translation,
    description: description ?? this.description,
    example: example ?? this.example,
    errors: errors ?? this.errors,
    canSubmit: canSubmit ?? this.canSubmit,
  );
}
