// lib/main.dart
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'widgets/custom_app_bar.dart';

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
      home: MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    LoginScreen(),
    RegistroScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onButtonPressed: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
