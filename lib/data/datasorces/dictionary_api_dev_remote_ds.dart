import 'dart:convert';

import 'package:flashcards/data/dtos/dictionary_api_dev_word_dto.dart';
import 'package:http/http.dart' as http;

class DictionaryApiDevRemoteDS {
  DictionaryApiDevRemoteDS(this._client);
  final http.Client _client;
  static const _base = 'https://api.dictionaryapi.dev/api/v2/entries';

  Future<List<DictionaryApiDevWordDto>> fetch(String lang, String word) async {
    final res = await _client.get(Uri.parse('$_base/$lang/$word'));
    if (res.statusCode != 200) return [];
    final list = jsonDecode(res.body) as List;
    return list.map((j) => DictionaryApiDevWordDto.fromJson(j)).toList();
  }
}
