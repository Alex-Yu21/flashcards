import 'dart:convert';

import 'package:flashcards/data/dtos/dictionary_api_dev_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'DictionaryApiDevDto shoud correctly parse an DictionaryApiDev response',
    () {
      final jsonString = ''' [
    {
        "word": "cotter",
        "phonetics": [],
        "meanings": [
            {
                "partOfSpeech": "noun",
                "definitions": [
                    {
                        "definition": "A pin or wedge inserted through a slot to hold machine parts together.",
                        "synonyms": [],
                        "antonyms": []
                    },
                    {
                        "definition": "A cotter pin.",
                        "synonyms": [],
                        "antonyms": []
                    }
                ],
                "synonyms": [],
                "antonyms": []
            },
            {
                "partOfSpeech": "verb",
                "definitions": [
                    {
                        "definition": "To fasten with a cotter.",
                        "synonyms": [],
                        "antonyms": []
                    }
                ],
                "synonyms": [],
                "antonyms": []
            }
        ],
        "license": {
            "name": "CC BY-SA 3.0",
            "url": "https://creativecommons.org/licenses/by-sa/3.0"
        },
        "sourceUrls": [
            "https://en.wiktionary.org/wiki/cotter"
        ]
    },
    {
        "word": "cotter",
        "phonetics": [],
        "meanings": [
            {
                "partOfSpeech": "noun",
                "definitions": [
                    {
                        "definition": "A peasant who performed labour in exchange for the right to live in a cottage.",
                        "synonyms": [],
                        "antonyms": []
                    }
                ],
                "synonyms": [
                    "coscet",
                    "cottager"
                ],
                "antonyms": []
            }
        ],
        "license": {
            "name": "CC BY-SA 3.0",
            "url": "https://creativecommons.org/licenses/by-sa/3.0"
        },
        "sourceUrls": [
            "https://en.wiktionary.org/wiki/cotter"
        ]
    }
]
''';
      final List<dynamic> data = jsonDecode(jsonString);
      final dto = DictionaryApiDevDto.fromJson(data[0]);

      expect(dto.word, 'cotter');
      expect(dto.meanings?.first.partOfSpeech, 'noun');
      expect(
        dto.meanings?.first.definitions?.first.definition,
        "A pin or wedge inserted through a slot to hold machine parts together.",
      );
    },
  );
}
