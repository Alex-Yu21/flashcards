class DictionaryApiDevDto {
  String? word;
  List<Phonetic>? phonetics;
  List<Meaning>? meanings;
  License? license;
  List<String>? sourceUrls;

  DictionaryApiDevDto({
    this.word,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory DictionaryApiDevDto.fromJson(Map<String, dynamic> json) {
    return DictionaryApiDevDto(
      word: json['word'],
      phonetics:
          (json['phonetics'] as List<dynamic>?)
              ?.map((e) => Phonetic.fromJson(e))
              .toList(),
      meanings:
          (json['meanings'] as List<dynamic>?)
              ?.map((e) => Meaning.fromJson(e))
              .toList(),
      license:
          json['license'] != null ? License.fromJson(json['license']) : null,
      sourceUrls: (json['sourceUrls'] as List<dynamic>?)?.cast<String>(),
    );
  }
}

class Phonetic {
  String? text;
  String? audio;

  Phonetic({this.text, this.audio});

  factory Phonetic.fromJson(Map<String, dynamic> json) {
    return Phonetic(text: json['text'], audio: json['audio']);
  }
}

class Meaning {
  String? partOfSpeech;
  List<Definition>? definitions;
  List<String>? synonyms;
  List<String>? antonyms;

  Meaning({this.partOfSpeech, this.definitions, this.synonyms, this.antonyms});

  factory Meaning.fromJson(Map<String, dynamic> json) {
    return Meaning(
      partOfSpeech: json['partOfSpeech'],
      definitions:
          (json['definitions'] as List<dynamic>?)
              ?.map((e) => Definition.fromJson(e))
              .toList(),
      synonyms: (json['synonyms'] as List<dynamic>?)?.cast<String>(),
      antonyms: (json['antonyms'] as List<dynamic>?)?.cast<String>(),
    );
  }
}

class Definition {
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;

  Definition({this.definition, this.synonyms, this.antonyms, this.example});

  factory Definition.fromJson(Map<String, dynamic> json) {
    return Definition(
      definition: json['definition'],
      example: json['example'],
      synonyms: (json['synonyms'] as List<dynamic>?)?.cast<String>(),
      antonyms: (json['antonyms'] as List<dynamic>?)?.cast<String>(),
    );
  }
}

class License {
  String? name;
  String? url;

  License({this.name, this.url});

  factory License.fromJson(Map<String, dynamic> json) {
    return License(name: json['name'], url: json['url']);
  }
}
