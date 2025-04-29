class Flashcard {
  const Flashcard({
    required this.title,
    required this.transcription,
    this.audioPath,
    required this.hint,
    required this.translation,
    required this.description,
  });

  final String title;
  final String transcription;
  final String? audioPath;
  final String hint;
  final String translation;
  final String description;
}
