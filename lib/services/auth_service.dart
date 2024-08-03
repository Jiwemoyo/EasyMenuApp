// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://apieasymenu.onrender.com/api/auth';

  Future<bool> register(String username, String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    final responseData = json.decode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Registro exitoso: ${responseData['message']}');
      return true;
    } else {
      print('Error en el registro: ${responseData['message']}');
      return false;
    }
  } catch (e) {
    print('Error en la solicitud de registro: $e');
    return false;
  }
}

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print('Login exitoso: ${responseData['username']}');
      // Aquí puedes guardar el token y otros datos del usuario si lo deseas
      return true;
    } else {
      print('Error en el login: ${response.body}');
      return false;
    }
  }
}