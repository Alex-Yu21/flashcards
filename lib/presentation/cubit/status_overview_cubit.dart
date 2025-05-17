import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusItem extends Equatable {
  final int from;
  final int to;

  const StatusItem({required this.from, required this.to});

  int get delta => to - from;

  StatusItem update(int next) => StatusItem(from: to, to: next);

  factory StatusItem.zero() => const StatusItem(from: 0, to: 0);

  @override
  List<Object?> get props => [from, to];
}

class StatusOverviewState extends Equatable {
  final StatusItem newWords;
  final StatusItem learning;
  final StatusItem reviewing;
  final StatusItem mastered;

  const StatusOverviewState({
    required this.newWords,
    required this.learning,
    required this.reviewing,
    required this.mastered,
  });

  factory StatusOverviewState.initial() => StatusOverviewState(
    newWords: StatusItem.zero(),
    learning: StatusItem.zero(),
    reviewing: StatusItem.zero(),
    mastered: StatusItem.zero(),
  );

  StatusOverviewState copyWith({
    StatusItem? newWords,
    StatusItem? learning,
    StatusItem? reviewing,
    StatusItem? mastered,
  }) => StatusOverviewState(
    newWords: newWords ?? this.newWords,
    learning: learning ?? this.learning,
    reviewing: reviewing ?? this.reviewing,
    mastered: mastered ?? this.mastered,
  );

  @override
  List<Object?> get props => [newWords, learning, reviewing, mastered];
}

class StatusOverviewCubit extends Cubit<StatusOverviewState> {
  StatusOverviewCubit() : super(StatusOverviewState.initial());

  void update({
    required int newWords,
    required int learning,
    required int reviewing,
    required int mastered,
  }) {
    emit(
      state.copyWith(
        newWords: state.newWords.update(newWords),
        learning: state.learning.update(learning),
        reviewing: state.reviewing.update(reviewing),
        mastered: state.mastered.update(mastered),
      ),
    );
  }

  void reset() => emit(StatusOverviewState.initial());
}
