import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  ProfileScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido,',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              username,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: GreenColor),
            ),
          ],
        ),
      ),
    );
  }
}