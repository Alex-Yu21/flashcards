import 'package:flashcards/features/home/cubit/status_overview_cubit.dart';
import 'package:flashcards/features/home/presentation/widgets/status_overview_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StatusOverviewWidget', () {
    testWidgets('shoul displays all labels and counters', (tester) async {
      final cubit =
          StatusOverviewCubit()
            ..update(newWords: 5, learning: 3, reviewing: 7, mastered: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: cubit,
              child: const StatusOverviewWidget(),
            ),
          ),
        ),
      );

      await tester.pump(const Duration(seconds: 1));

      expect(find.text('New Words'), findsOneWidget);
      expect(find.text('Learning'), findsOneWidget);
      expect(find.text('Reviewing'), findsOneWidget);
      expect(find.text('Mastered'), findsOneWidget);

      expect(find.text('5'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
      expect(find.text('7'), findsOneWidget);
      expect(find.text('2'), findsOneWidget);

      expect(find.byIcon(Icons.circle), findsNWidgets(4));
    });
  });
}
