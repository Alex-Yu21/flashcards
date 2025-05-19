import 'package:equatable/equatable.dart';
import 'package:flashcards/domain/entities/card_category.dart';

class StatisticsState extends Equatable {
  final Map<CardCategory, int> initialCounts;
  final Map<CardCategory, int> currentCounts;

  const StatisticsState({
    required this.initialCounts,
    required this.currentCounts,
  });

  @override
  List<Object?> get props => [initialCounts, currentCounts];
  StatisticsState copyWith({
    Map<CardCategory, int>? initialCounts,
    Map<CardCategory, int>? currentCounts,
  }) {
    return StatisticsState(
      initialCounts: initialCounts ?? this.initialCounts,
      currentCounts: currentCounts ?? this.currentCounts,
    );
  }

  Map<CardCategory, int> get deltas {
    final allKeys = {...initialCounts.keys, ...currentCounts.keys};
    final diffs = <CardCategory, int>{};

    for (var key in allKeys) {
      diffs[key] = (currentCounts[key] ?? 0) - (initialCounts[key] ?? 0);
    }
    return diffs;
  }
}
