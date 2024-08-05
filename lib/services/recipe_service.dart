import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'auth_service.dart';

class ApiService {
  static const String baseUrl = 'https://apieasymenu.onrender.com/api';

  static Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/recipes'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((recipe) {
          return recipe as Map<String, dynamic>;
        }).toList();
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipes: $e');
      throw Exception('Failed to load recipes');
    }
  }

  static Future<List<Map<String, dynamic>>> getUserRecipes(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/recipes/user/$userId'));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((recipe) {
          return recipe as Map<String, dynamic>;
        }).toList();
      } else {
        throw Exception('Failed to load user recipes: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching user recipes: $e');
      throw Exception('Failed to load user recipes');
    }
  }

  static Future<Map<String, dynamic>> createRecipe(Map<String, dynamic> recipeData) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/recipes'));
      
      // Obtener el token de autenticación
      String? token = await AuthService.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      
      request.fields['title'] = recipeData['title'];
      request.fields['description'] = recipeData['description'];
      request.fields['ingredients'] = json.encode(recipeData['ingredients']);
      request.fields['steps'] = json.encode(recipeData['steps']);
      request.fields['author'] = recipeData['author'];

      if (recipeData['image'] != null) {
        var file = await http.MultipartFile.fromPath(
          'image',
          recipeData['image'].path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create recipe: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error creating recipe: $e');
      throw Exception('Failed to create recipe: $e');
    }
  }

  static Future<Map<String, dynamic>> updateRecipe(String recipeId, Map<String, dynamic> recipeData) async {
    try {
      var request = http.MultipartRequest('PUT', Uri.parse('$baseUrl/recipes/$recipeId'));

      // Obtener el token de autenticación
      String? token = await AuthService.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      request.fields['title'] = recipeData['title'];
      request.fields['description'] = recipeData['description'];
      request.fields['ingredients'] = json.encode(recipeData['ingredients']);
      request.fields['steps'] = json.encode(recipeData['steps']);
      request.fields['author'] = recipeData['author'];

      if (recipeData['image'] != null) {
        var file = await http.MultipartFile.fromPath(
          'image',
          recipeData['image'].path,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to update recipe: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error updating recipe: $e');
      throw Exception('Failed to update recipe: $e');
    }
  }

  static Future<void> deleteRecipe(String recipeId) async {
    try {
      // Obtener el token de autenticación
      String? token = await AuthService.getToken();
      final response = await http.delete(
        Uri.parse('$baseUrl/recipes/$recipeId'),
        headers: token != null ? {'Authorization': 'Bearer $token'} : null,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete recipe: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      print('Error deleting recipe: $e');
      throw Exception('Failed to delete recipe: $e');
    }
  }
}
