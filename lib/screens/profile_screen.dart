import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';
import 'create_recipe_screen.dart';
import 'update_recipe_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;
  final String userId;

  ProfileScreen({required this.username, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<List<Map<String, dynamic>>> _userRecipesFuture;

  @override
  void initState() {
    super.initState();
    _loadUserRecipes();
  }

  void _loadUserRecipes() {
    _userRecipesFuture = ApiService.getUserRecipes(widget.userId);
  }

  String _buildImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return '';
    }
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return imagePath;
    }
    return 'https://apieasymenu.onrender.com$imagePath';
  }

  void _deleteRecipe(String recipeId) async {
    try {
      await ApiService.deleteRecipe(recipeId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Receta eliminada con éxito')),
      );
      setState(() {
        _loadUserRecipes();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar la receta')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateRecipeScreen(userId: widget.userId)),
              );
              if (result == true) {
                setState(() {
                  _loadUserRecipes();
                });
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido,',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.username,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: GreenColor),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'UserID: ${widget.userId}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mis Recetas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: _userRecipesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No has creado ninguna receta aún'));
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final recipe = snapshot.data![index];
                      return RecipeCard(
                        imagePath: _buildImageUrl(recipe['image']?.toString()),
                        title: recipe['title']?.toString() ?? 'Sin título',
                        author: widget.username,
                        likes: recipe['likesCount'] is int ? recipe['likesCount'] : 0,
                        onViewDetails: () {
                          // Implementar la visualización de detalles de la receta
                        },
                        onDelete: () => _deleteRecipe(recipe['_id']),
                        onUpdate: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateRecipeScreen(recipe: recipe),
                            ),
                          );
                          if (result == true) {
                            setState(() {
                              _loadUserRecipes();
                            });
                          }
                        },
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
