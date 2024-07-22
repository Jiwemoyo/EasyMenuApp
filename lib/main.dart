// lib/main.dart
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Social Network',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: WhiteColor,
        appBarTheme: AppBarTheme(
          color: GreenColor,
          iconTheme: IconThemeData(color: WhiteColor),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 24,
            color: WhiteColor,
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontFamily: 'Pacifico', fontSize: 24, color: WhiteColor),
          bodyLarge: TextStyle(fontFamily: 'Roboto-bold', fontSize: 16, color: Colors.black),
          bodyMedium: TextStyle(fontFamily: 'Roboto-bold', fontSize: 14, color: Colors.black),
        ),
      ),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}