import 'package:flutter/material.dart';

class LightTheme { 
  static const Color _primary = Colors.white;
  static const Color _primaryContainer = Color.fromRGBO(239, 239, 239, 1);
  static const Color _onPrimary = Colors.black;

  static const Color _secondary = Color.fromRGBO(105, 187, 202, 1); 
  static const Color _secondaryContainer = Color.fromRGBO(25, 162, 200, 1);
  static const Color _onSecondary = Colors.white;

  static const Color _background = Color.fromRGBO(239, 239, 239, 1);

  static final ThemeData theme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(

      primary: _primary, 
      primaryContainer: _primaryContainer, 
      onPrimary: _onPrimary,

      secondary: _secondary, 
      secondaryContainer: _secondaryContainer,
      onSecondary: _onSecondary,

      background: _background,
    ),

    inputDecorationTheme: InputDecorationTheme(
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
        borderSide: const BorderSide(color: Colors.red),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
        borderSide: const BorderSide(color: _secondary,)
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
        borderSide: const BorderSide(color: _onPrimary),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), 
        borderSide: const BorderSide(color: _onPrimary),
      ),
      

      floatingLabelStyle: const TextStyle(color: _secondary),
      errorStyle: const TextStyle(color: Colors.red),
      prefixIconColor: _secondary,
    ),

    appBarTheme: const AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: _secondary)
    ),

    textSelectionTheme: TextSelectionThemeData(
      cursorColor: _secondary,
      selectionColor: _secondary.withOpacity(0.15),
      selectionHandleColor: _secondary,
    ),
  );

}