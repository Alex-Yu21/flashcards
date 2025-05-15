import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockState {
  final bool isUnlocked;
  const UnlockState({required this.isUnlocked});
}

class CategoryUnlockCubit extends Cubit<UnlockState> {
  CategoryUnlockCubit({bool initiallyUnlocked = false})
    : super(UnlockState(isUnlocked: initiallyUnlocked));

  void unlock() {
    if (!state.isUnlocked) emit(const UnlockState(isUnlocked: true));
  }
}
