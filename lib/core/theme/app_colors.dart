import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Construtor privado para evitar instanciação

  // Cores primárias - Azul marinho profundo
  static const Color primaryDark = Color(0xFF1A3A52);
  static const Color primaryContainer = Color(0xFF4A6A82);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainerLight = Color(0xFFCFE4FF);
  static const Color primaryDarkMode = Color(0xFF9DCAF8);
  static const Color onPrimaryDarkMode = Color(0xFF003351);

  // Cores secundárias - Bronze/Dourado discreto
  static const Color secondary = Color(0xFF8B7355);
  static const Color secondaryContainer = Color(0xFFD4C4B0);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF2C1F15);
  static const Color secondaryContainerDark = Color(0xFF6B5943);
  static const Color onSecondaryDark = Color(0xFF3E2F20);
  static const Color onSecondaryContainerDark = Color(0xFFF0DFCB);

  // Cores terciárias - Verde-acinzentado
  static const Color tertiary = Color(0xFF5B6B5D);
  static const Color tertiaryContainer = Color(0xFFD8E5D9);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onTertiaryContainer = Color(0xFF1A251B);
  static const Color tertiaryDarkMode = Color(0xFFBCCBBD);
  static const Color onTertiaryDarkMode = Color(0xFF283B2A);
  static const Color tertiaryContainerDark = Color(0xFF445246);

  // Cores de erro
  static const Color error = Color(0xFF8B3A3A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);
  static const Color errorDarkMode = Color(0xFFFFB4AB);
  static const Color onErrorDarkMode = Color(0xFF690005);
  static const Color errorContainerDark = Color(0xFF93000A);

  // Backgrounds e superfícies - Light
  static const Color surface = Color(0xFFFAFAFA);
  static const Color onSurface = Color(0xFF1C1B1F);
  static const Color surfaceContainerHighest = Color(0xFFE6E6E6);
  static const Color onSurfaceVariant = Color(0xFF45464F);

  // Backgrounds e superfícies - Dark
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color onSurfaceDark = Color(0xFFE6E1E5);
  static const Color surfaceContainerHighestDark = Color(0xFF36343B);
  static const Color onSurfaceVariantDark = Color(0xFFC7C5D0);
  
  // Bordas
  static const Color outline = Color(0xFF75767F);
  static const Color outlineVariant = Color(0xFFC5C6D0);
  static const Color outlineDark = Color(0xFF918F9A);
  static const Color outlineVariantDark = Color(0xFF45464F);

  // Inverse
  static const Color inverseSurface = Color(0xFF313033);
  static const Color onInverseSurface = Color(0xFFF4EFF4);
  static const Color inverseSurfaceDark = Color(0xFFE6E1E5);
  static const Color onInverseSurfaceDark = Color(0xFF313033);
}