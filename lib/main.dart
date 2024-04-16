import 'package:flutter/material.dart';
import 'package:expense/widgets/expense.dart';
//import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.amber);
var kDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark, seedColor: Colors.deepPurple);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
  //DeviceOrientation.portraitUp,
  //]).then((fn) {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kDarkColorScheme,
      cardTheme: const CardTheme().copyWith(
        color: kDarkColorScheme.secondaryContainer,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: kDarkColorScheme.primaryContainer,
      )),
    ),
    theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        )),
        textTheme: ThemeData().textTheme.copyWith(
            titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer))),
    themeMode: ThemeMode.system,
    home: const ExpensePage(),
  ));
  // });
}
