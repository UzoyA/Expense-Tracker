
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(876, 87, 645, 567)
);



void main() {
  runApp(
     MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
       colorScheme: kColorScheme,
        cardTheme: CardTheme().copyWith(
          color: Color.fromARGB(255, 200, 200, 204),
          margin: const EdgeInsets.symmetric(
            horizontal: 10, 
            vertical: 8
          ),
        ),
      ),
      theme: ThemeData().copyWith( 
         scaffoldBackgroundColor: 
          Color.fromARGB(255, 237, 237, 237),
          colorScheme: const ColorScheme(
            brightness: Brightness.light, 
            primary: Color.fromARGB(255, 6, 71, 95), 
            onPrimary: Colors.blueAccent,
            secondary: Colors.cyanAccent, 
            onSecondary: Colors.black, 
            error: Colors.red, 
            onError: Colors.white, 
            surface: Colors.white, 
            onSurface: Colors.black,
          ),
        cardTheme: CardTheme().copyWith(
          color: Color.fromARGB(255, 166, 176, 183),
          margin: const EdgeInsets.symmetric(
            horizontal: 10, 
            vertical: 8
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 165, 165, 174),
          ),
        ),
      ),
      //themeMode: ThemeMode.system,
      home: const Expenses(),
      
    ),
  );
}



