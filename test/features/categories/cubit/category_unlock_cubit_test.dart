import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/features/categories/cubit/unlock_category_cubit.dart';
import 'package:flashcards/shared/cubit/status_overview_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CategoryUnlockCubit', () {
    test('should have initial state as locked by default', () {
      final cubit = CategoryUnlockCubit();
      expect(cubit.state.isUnlocked, false);
      cubit.close();
    });

    test('should have initial state as unlocked if initiallyUnlocked=true', () {
      final cubit = CategoryUnlockCubit(initiallyUnlocked: true);
      expect(cubit.state.isUnlocked, true);
      cubit.close();
    });

    blocTest<CategoryUnlockCubit, UnlockState>(
      'should not unlock if count.from != 0',
      build: () => CategoryUnlockCubit(),
      act: (cubit) => cubit.unlock(const StatusItem(from: 1, to: 2)),
      expect: () => [],
    );

    blocTest<CategoryUnlockCubit, UnlockState>(
      'should not unlock if count.to <= 0',
      build: () => CategoryUnlockCubit(),
      act: (cubit) => cubit.unlock(const StatusItem(from: 0, to: 0)),
      expect: () => [],
    );

    blocTest<CategoryUnlockCubit, UnlockState>(
      'should unlock if count.from == 0 and count.to > 0 and was locked',
      build: () => CategoryUnlockCubit(),
      act: (cubit) => cubit.unlock(const StatusItem(from: 0, to: 2)),
      expect: () => [const UnlockState(isUnlocked: true)],
    );

    blocTest<CategoryUnlockCubit, UnlockState>(
      'should not emit if already unlocked',
      build: () => CategoryUnlockCubit(initiallyUnlocked: true),
      act: (cubit) => cubit.unlock(const StatusItem(from: 0, to: 2)),
      expect: () => [],
    );
  });
}
