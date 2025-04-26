import 'package:flashcards/core/theme/app_theme.dart';
import 'package:flashcards/presentation/screens/home_screen.dart';
import 'package:flashcards/presentation/screens/learning_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlashcardsApp());
}

class FlashcardsApp extends StatelessWidget {
  const FlashcardsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme();
    return MaterialApp(
      title: 'Just flashcards',
      theme: AppTheme(textTheme).lightMediumContrast(),
      darkTheme: AppTheme(textTheme).darkMediumContrast(),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
