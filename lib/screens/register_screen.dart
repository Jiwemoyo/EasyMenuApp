import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/auth_service.dart';

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
                      'Registro',
                      style: pacificoTitleStyle.copyWith(
                        fontSize: 24,
                        color: GreenColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool success = await _authService.register(
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                          if (success) {
                            print('Registro exitoso');
                            // Aquí puedes navegar a la pantalla de login o mostrar un mensaje de éxito
                          } else {
                            print('Error en el registro');
                            // Aquí puedes mostrar un diálogo de error
                          }
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
        ),
      ),
    );
  }
}