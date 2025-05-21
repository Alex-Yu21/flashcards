import 'dart:async';

import 'package:flashcards/core/theme/app_theme.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/data/repositories/dummy_flashcard_repository.dart';
import 'package:flashcards/domain/repositories/flashcard_repository.dart';
import 'package:flashcards/presentation/cubit/flashcard/flashcard_cubit.dart';
import 'package:flashcards/presentation/cubit/statistics/statistics_cubit.dart';
import 'package:flashcards/presentation/cubit/status_overview_cubit.dart';
import 'package:flashcards/presentation/cubit/unlock_category_cubit.dart';
import 'package:flashcards/presentation/views/tabs/tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GoogleFonts.pendingFonts([]);

      final repo = DummyFlashcardRepository(dummyFlashcards);

      runApp(
        MultiRepositoryProvider(
          providers: [
            RepositoryProvider<FlashcardRepository>.value(value: repo),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => StatisticsCubit(repo)..init()),
              BlocProvider(create: (_) => StatusOverviewCubit()),
              BlocProvider(create: (_) => CategoryUnlockCubit()),
              BlocProvider(create: (_) => FlashcardCubit(repo)..init()),
            ],
            child: const FlashcardsApp(),
          ),
        ),
      );
    },
    (error, stack) {
      debugPrint('‼ Caught unhandled error: $error');
      debugPrint('$stack');
      FlutterError.reportError(
        FlutterErrorDetails(exception: error, stack: stack),
      );
    },
  );
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = GoogleFonts.mulishTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'Just flashcards',
      theme: AppTheme(textTheme).lightMediumContrast(),
      darkTheme: AppTheme(textTheme).darkMediumContrast(),
      themeMode: ThemeMode.system,
      home: const TabView(),
    );
  }
}
