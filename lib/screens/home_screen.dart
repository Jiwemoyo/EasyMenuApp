// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(currentPage: 'Recetas'),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [WhiteColor, GreenColor.withOpacity(0.3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Text(
            'Pantalla de Recetas',
            style: pacificoTitleStyle.copyWith(color: GreenColor, fontSize: 32),
          ),
        ),
      ),
    );
  }
}