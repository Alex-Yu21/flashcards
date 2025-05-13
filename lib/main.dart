import 'dart:async';

import 'package:flashcards/core/theme/app_theme.dart';
import 'package:flashcards/data/dummy_data.dart';
import 'package:flashcards/data/repositories/dummy_flashcard_repository.dart';
import 'package:flashcards/features/home/cubit/statistics_cubit.dart';
import 'package:flashcards/features/tabs/presentation/screens/tabs_screen.dart';
import 'package:flashcards/shared/domain/repositories/flashcard_repository.dart';
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
      home: const TabsScreen(),
    );
  }
}
