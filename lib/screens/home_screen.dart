// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/recipe_card.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {'image': 'assets/images/burritos.png', 'author': 'Chef John', 'likes': 120},
    {'image': 'assets/images/hamburguesa.png', 'author': 'Chef Maria', 'likes': 95},
    {'image': 'assets/images/pizza.png', 'author': 'Chef Alex', 'likes': 210},
    // Añade más recetas según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeCard(
            imagePath: recipe['image'],
            author: recipe['author'],
            likes: recipe['likes'],
            onViewDetails: () {
              print('Ver detalles de la receta ${index + 1}');
            },
          );
        },
      ),
    );
  }
}