import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';

class DictionaryApiDevWordDto {
  DictionaryApiDevWordDto({
    required this.word,
    this.phonetic,
    required this.phonetics,
    required this.meanings,
  });

  final String word;
  final String? phonetic;
  final List<PhoneticsDto> phonetics;
  final List<MeaningDto> meanings;

  factory DictionaryApiDevWordDto.fromJson(Map<String, dynamic> j) {
    return DictionaryApiDevWordDto(
      word: j['word'] as String,
      phonetic: j['phonetic'] as String?,
      phonetics:
          (j['phonetics'] as List<dynamic>? ?? [])
              .map((e) => PhoneticsDto.fromJson(e))
              .toList(),
      meanings:
          (j['meanings'] as List<dynamic>? ?? [])
              .map((e) => MeaningDto.fromJson(e))
              .toList(),
    );
  }

  FlashcardEntity toEntity(String id) {
    final firstPhon = phonetics.firstWhere(
      (p) => p.audio != null || p.text != null,
      orElse: () => phonetics.isNotEmpty ? phonetics.first : PhoneticsDto(),
    );

    final firstDef =
        meanings.isNotEmpty && meanings.first.definitions.isNotEmpty
            ? meanings.first.definitions.first
            : DefinitionDto();

    return FlashcardEntity(
      id: id,
      title: word,
      translation: '',
      transcription: firstPhon.text ?? phonetic,
      audioPath: firstPhon.audio,
      example: firstDef.example,
      description: firstDef.definition ?? '',
      category: CardCategory.newWords,
    );
  }
}

class PhoneticsDto {
  final String? text;
  final String? audio;
  PhoneticsDto({this.text, this.audio});

  factory PhoneticsDto.fromJson(Map<String, dynamic> j) =>
      PhoneticsDto(text: j['text'] as String?, audio: j['audio'] as String?);
}

class MeaningDto {
  final String? partOfSpeech;
  final List<DefinitionDto> definitions;
  MeaningDto({this.partOfSpeech, required this.definitions});

  factory MeaningDto.fromJson(Map<String, dynamic> j) => MeaningDto(
    partOfSpeech: j['partOfSpeech'] as String?,
    definitions:
        (j['definitions'] as List<dynamic>? ?? [])
            .map((e) => DefinitionDto.fromJson(e))
            .toList(),
  );
}

class DefinitionDto {
  final String? definition;
  final String? example;
  DefinitionDto({this.definition, this.example});

  factory DefinitionDto.fromJson(Map<String, dynamic> j) => DefinitionDto(
    definition: j['definition'] as String?,
    example: j['example'] as String?,
  );
}
