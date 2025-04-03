import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black, // Global cursor color
    ),
    inputDecorationTheme: InputDecorationTheme(
      counterStyle: TextStyle(color: Colors.black),
      border: OutlineInputBorder(borderSide: BorderSide.none),
      hintStyle: TextStyle(
        fontSize: 24,
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
      ),
    ),
    // primarySwatch: ,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      primary: Color(0xffFFFAFA),
      onPrimary: Colors.black,
      seedColor: Colors.white, // Set primary color to white
      brightness: Brightness.light, // Ensures light mode
    ),
    useMaterial3: true,
    brightness: Brightness.light,
    // scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      // color: Colors.white,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedIconTheme: IconThemeData(
        size: 30,
        weight: 700,
        color: Colors.white,
      ),
      unselectedIconTheme: IconThemeData(
        size: 25,
        weight: 400,
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.white,
        disabledForegroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    
    textSelectionTheme: TextSelectionThemeData(
      
      cursorColor: Colors.white, // Global cursor color
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide.none),
      counterStyle: TextStyle(color: Colors.white),
      hintStyle: TextStyle(
        fontSize: 24,
        color: Colors.grey[600],
        fontWeight: FontWeight.bold,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      primary: Color(0xff2C2C2C),
      onPrimary: Colors.white,
      seedColor: Colors.white, // Set primary color to white
      brightness: Brightness.dark, // Ensures light mode
    ),
    useMaterial3: true,
    brightness: Brightness.dark,
    // primarySwatch: Colors.teal,
    // scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedIconTheme: IconThemeData(
        size: 30,
        weight: 700,
        color: Colors.white,
      ),
      unselectedIconTheme: IconThemeData(
        size: 25,
        weight: 400,
        color: Colors.white,
      ),
      selectedLabelStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: Colors.tealAccent,
        disabledForegroundColor: Colors.grey,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
