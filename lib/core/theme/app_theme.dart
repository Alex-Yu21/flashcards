import 'package:flashcards_app/core/theme/app_colors_dark.dart';
import 'package:flashcards_app/core/theme/app_colors_ligth.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final TextTheme textTheme;

  const AppTheme(this.textTheme);

  ThemeData lightMediumContrast() {
    return _theme(AppColorsLight.mediumContrast);
  }

  ThemeData darkMediumContrast() {
    return _theme(AppColorsDark.mediumContrast);
  }

  ThemeData _theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );
}
