import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'https://apieasymenu.onrender.com/api/auth';
  static const String TOKEN_KEY = 'auth_token';

  Future<Map<String, dynamic>> register(String username, String email, String password) async {
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
        return {'success': true, 'message': responseData['message']};
      } else {
        print('Error en el registro: ${responseData['message']}');
        return {'success': false, 'message': responseData['message']};
      }
    } catch (e) {
      print('Error en la solicitud de registro: $e');
      return {'success': false, 'message': 'Error en la conexión'};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
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
        
        // Guardar el token
        if (responseData['token'] != null) {
          await _saveToken(responseData['token']);
        }
        
        return {
          'success': true,
          'username': responseData['username'] ?? email,
          'userId': responseData['userId'],
          'token': responseData['token'],
        };
      } else {
        print('Error en el login: ${response.body}');
        return {'success': false};
      }
    } catch (e) {
      print('Error en la solicitud de login: $e');
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Logout exitoso');
        await _removeToken();
        return {'success': true};
      } else {
        print('Error en el logout: ${response.body}');
        return {'success': false, 'message': 'Error en el logout'};
      }
    } catch (e) {
      print('Error en la solicitud de logout: $e');
      return {'success': false, 'message': 'Error en la conexión'};
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
  }

  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN_KEY);
  }
}
