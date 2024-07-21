// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/constants.dart';
import 'utils/custom_route_transition.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Menu',
      theme: ThemeData(
        primaryColor: GreenColor,
        hintColor: WhiteColor,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return CustomRouteTransition(page: HomeScreen(), routeName: '/');
          case '/login':
            return CustomRouteTransition(page: LoginScreen(), routeName: '/login');
          case '/register':
            return CustomRouteTransition(page: RegisterScreen(), routeName: '/register');
          default:
            return null;
        }
      },
    );
  }
}