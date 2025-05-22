import 'dart:async';

import 'package:flashcards/core/di.dart';
import 'package:flashcards/core/theme/app_theme.dart';
import 'package:flashcards/presentation/views/tabs/tabs_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await GoogleFonts.pendingFonts([]);

      runApp(const Di(child: FlashcardsApp()));
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
