import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../widgets/recipe_card.dart';
import '../services/api_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Map<String, dynamic>>> _recipesFuture;

  @override
  void initState() {
    super.initState();
    _recipesFuture = ApiService.getRecipes();
  }

  String _buildImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return imagePath;
    }
    return 'https://apieasymenu.onrender.com$imagePath'; // Ajusta esta URL base según tu API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recetas'),
        backgroundColor: GreenColor,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay recetas disponibles'));
          } else {
            print('Recipe data: ${snapshot.data}');
            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _recipesFuture = ApiService.getRecipes();
                });
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final recipe = snapshot.data![index];
                  return RecipeCard(
                    imagePath: _buildImageUrl(recipe['image']?.toString()),
                    author: recipe['author']?['username']?.toString() ?? 'Desconocido',
                    likes: recipe['likesCount'] is int ? recipe['likesCount'] : 0,
                    onViewDetails: () {
                      _showRecipeDetails(recipe);
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void _showRecipeDetails(Map<String, dynamic> recipe) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                recipe['title'] ?? 'Sin título',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Autor: ${recipe['author']?['username'] ?? 'Desconocido'}'),
              SizedBox(height: 8),
              Text('Likes: ${recipe['likesCount'] ?? 0}'),
              SizedBox(height: 8),
              Text('Descripción: ${recipe['description'] ?? 'Sin descripción'}'),
            ],
          ),
        );
      },
    );
  }
}