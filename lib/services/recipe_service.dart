import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://apieasymenu.onrender.com/api';

  static Future<List<Map<String, dynamic>>> getRecipes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/recipes'));

      print('API Response Status Code: ${response.statusCode}');
      print('API Response Headers: ${response.headers}');
      print('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((recipe) {
          print('Recipe: $recipe');
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
}