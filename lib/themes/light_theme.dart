import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData theme = ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light().copyWith(

      primary: Colors.white, 
      primaryContainer: const Color.fromRGBO(239, 239, 239, 1), 
      onPrimary: Colors.black,

      secondary: const Color.fromRGBO(255, 183, 77, 1), 
      secondaryContainer: const Color.fromRGBO(200,135,25,1),
      onSecondary: Colors.black,

      background: const Color.fromRGBO(239, 239, 239, 1),
    ),
  );

}

/*
    primary: const Color.fromRGBO(239, 239, 239, 1), 
      primaryContainer: const Color.fromRGBO(189, 189, 189, 1), 
      onPrimary: Colors.black,

      secondary: const Color.fromRGBO(255, 183, 77, 1), 
      secondaryContainer: const Color.fromRGBO(200,135,25,1),
      onSecondary: Colors.black,

      background: const Color.fromRGBO(255,233,125,1),
*/