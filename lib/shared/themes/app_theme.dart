// Definición del tema de la aplicación
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF00A9B7);
  static const Color accentColor = Colors.white;
  static const Color iconColor = Colors.white;
  static const Color primaryColorLight = Color.fromARGB(255, 57, 157, 166);

  // Detalles del personaje
  static const Color detailBackgroundColor = Color(0xFFE0F7FA);
  static const Color detailTitleColor = Color(0xFF00838F);
  static const Color detailSubtitleColor = Color(0xFF004D40);
  static const Color propertyNameColor = Color(0xFF00838F);
  static const Color propertyValueColor = Color(0xFF004D40);

  // HomeWidget
  static const Color homeBackgroundColor = Color(0xFFFDD835);
  static const Color homeTextColor = Colors.white;
  static const Color homeDetailBackgroundColor = Colors.white;
  static const Color homeDetailTitleColor = Color(0xFF00BCD4);
  static const Color homeDetailSubtitleColor = Colors.black;

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
      ),
      iconTheme: const IconThemeData(
        color: iconColor,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: detailTitleColor, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: detailSubtitleColor),
        bodyLarge: TextStyle(color: accentColor),
      ),
    );
  }
}
