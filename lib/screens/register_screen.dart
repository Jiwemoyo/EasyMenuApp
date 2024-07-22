// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onNavigateToLogin;

  RegisterScreen({required this.onNavigateToLogin});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
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
                  'Registro',
                  style: pacificoTitleStyle.copyWith(
                    fontSize: 24,
                    color: GreenColor,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
                    labelStyle: TextStyle(color: GreenColor),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre de usuario';
                    }
                    return null;
                  },
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
                      // Aquí puedes manejar el registro del usuario
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: WhiteColor,
                    backgroundColor: GreenColor,
                  ),
                  child: Text('Regístrate'),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: widget.onNavigateToLogin,
                  child: Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
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