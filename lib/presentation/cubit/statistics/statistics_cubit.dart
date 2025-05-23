import 'package:flashcards/domain/entities/card_category.dart';
import 'package:flashcards/domain/entities/flashcard_entity.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final FlashcardRepository _repo;

  StatisticsCubit(this._repo)
    : super(const StatisticsState(initialCounts: {}, currentCounts: {}));

  Future<void> init() => _load(initial: true);
  Future<void> refresh() => _load();

  Future<void> _load({bool initial = false}) async {
    final cards = await _repo.fetchAllFlashcards();
    final counts = _countByCategory(cards);

    emit(
      initial
          ? StatisticsState(initialCounts: counts, currentCounts: counts)
          : state.copyWith(currentCounts: counts),
    );
  }

  Map<CardCategory, int> _countByCategory(List<FlashcardEntity> cards) =>
      cards.fold(<CardCategory, int>{}, (m, c) {
        m[c.category] = (m[c.category] ?? 0) + 1;
        return m;
      });
}
