import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockState {
  final bool isUnlocked;
  const UnlockState({required this.isUnlocked});
}

class CategoryUnlockCubit extends Cubit<UnlockState> {
  CategoryUnlockCubit({bool initiallyUnlocked = false})
    : super(UnlockState(isUnlocked: initiallyUnlocked));

  void unlock(StatusItem count) {
    if (!state.isUnlocked && count.from == 0 && count.to > 0) {
      emit(const UnlockState(isUnlocked: true));
    }
  }
}
