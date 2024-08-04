import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final Function(String, String) onLogin;
  final VoidCallback onNavigateToRegister;

  LoginScreen({required this.onLogin, required this.onNavigateToRegister});

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
                          Map<String, dynamic> result = await _authService.login(
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (result['success']) {
                            print('Login exitoso');
                            widget.onLogin(result['username'] ?? 'Usuario', result['userId']);
                          } else {
                            print('Error en el login');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error en el inicio de sesión. Por favor, intente de nuevo.')),
                            );
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
