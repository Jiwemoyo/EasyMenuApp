// lib/main.dart
import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/profile_screen.dart';
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
  bool _isLoggedIn = false;
  String? _username;
  String? _userId;

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleLogin(String username, String userId) {
    setState(() {
      _isLoggedIn = true;
      _username = username;
      _userId = userId;
      _selectedIndex = 1; // Cambiar a la pantalla de perfil (índice 1)
    });
  }

  void _handleLogout() {
    setState(() {
      _isLoggedIn = false;
      _username = null;
      _userId = null;
      _selectedIndex = 0; // Volver a la pantalla de inicio
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      HomeScreen(),
      _isLoggedIn
          ? ProfileScreen(username: _username ?? '', userId: _userId ?? '')
          : LoginScreen(onLogin: _handleLogin, onNavigateToRegister: () => _navigateTo(2)),
      _isLoggedIn
          ? Container() // Placeholder para el botón "Salir"
          : RegisterScreen(onNavigateToLogin: () => _navigateTo(1)),
    ];

    return Scaffold(
      appBar: CustomAppBar(
        onButtonPressed: (index) {
          if (_isLoggedIn && index == 2) {
            _handleLogout();
          } else {
            _navigateTo(index);
          }
        },
        currentIndex: _selectedIndex,
        isLoggedIn: _isLoggedIn,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
    );
  }
}
