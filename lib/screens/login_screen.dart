import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/auth_service.dart';

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
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Iniciar Sesión',
                      style: pacificoTitleStyle.copyWith(
                        fontSize: 24,
                        color: GreenColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await _authService.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success) {
                            print('Login exitoso');
                            // Aquí puedes navegar a la pantalla principal
                          } else {
                            print('Error en el login');
                            // Aquí puedes mostrar un diálogo de error
                          }
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
        ),
      ),
    );
  }
}