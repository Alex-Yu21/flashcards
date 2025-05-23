import 'package:flashcards/domain/repositories/dictionary_repository.dart';
import 'package:flashcards/presentation/cubit/word_lookup/word_lookup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordLookupCubit extends Cubit<WordLookupState> {
  WordLookupCubit(this._repo) : super(WordLookupIdle());

  final DictionaryRepository _repo;

  Future<void> lookup(String word, {String lang = 'en'}) async {
    if (word.trim().isEmpty) return;
    emit(WordLookupLoading());
    try {
      final res = await _repo.getWord(lang, word.trim());
      emit(res == null ? WordLookupEmpty() : WordLookupReady(res));
    } catch (e) {
      emit(WordLookupError(e.toString()));
    }
  }

  void reset() => emit(WordLookupIdle());
}
