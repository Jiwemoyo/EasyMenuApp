// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onNavigateToRegister;

  LoginScreen({required this.onNavigateToRegister});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Iniciar Sesión',
                  style: pacificoTitleStyle.copyWith(
                    fontSize: 24,
                    color: GreenColor,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: GreenColor),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su correo';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: GreenColor),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su contraseña';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Aquí puedes manejar el inicio de sesión del usuario
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: WhiteColor,
                    backgroundColor: GreenColor,
                  ),
                  child: Text('Iniciar Sesión'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: widget.onNavigateToRegister,
                  child: Text(
                    '¿No tienes una cuenta? Regístrate',
                    style: TextStyle(color: GreenColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}