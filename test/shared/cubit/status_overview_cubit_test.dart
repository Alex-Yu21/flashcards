import 'package:bloc_test/bloc_test.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusOverviewCubit', () {
    late StatusOverviewCubit cubit;

    setUp(() {
      cubit = StatusOverviewCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('should have initial state as StatusOverviewState.initial()', () {
      expect(cubit.state, StatusOverviewState.initial());
    });

    blocTest<StatusOverviewCubit, StatusOverviewState>(
      'should emit updated state when update is called',
      build: () => StatusOverviewCubit(),
      act:
          (cubit) =>
              cubit.update(newWords: 5, learning: 3, reviewing: 2, mastered: 1),
      expect:
          () => [
            const StatusOverviewState(
              newWords: StatusItem(from: 0, to: 5),
              learning: StatusItem(from: 0, to: 3),
              reviewing: StatusItem(from: 0, to: 2),
              mastered: StatusItem(from: 0, to: 1),
            ),
          ],
    );

    blocTest<StatusOverviewCubit, StatusOverviewState>(
      'should reset state to initial after reset() is called',
      build: () => StatusOverviewCubit(),
      act: (cubit) {
        cubit.update(newWords: 2, learning: 2, reviewing: 2, mastered: 2);
        cubit.reset();
      },
      expect:
          () => [
            const StatusOverviewState(
              newWords: StatusItem(from: 0, to: 2),
              learning: StatusItem(from: 0, to: 2),
              reviewing: StatusItem(from: 0, to: 2),
              mastered: StatusItem(from: 0, to: 2),
            ),
            StatusOverviewState.initial(),
          ],
    );
  });
}
