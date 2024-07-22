// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildRecipeCard('Receta 1', 'Descripción de la receta 1'),
                _buildRecipeCard('Receta 2', 'Descripción de la receta 2'),
                _buildRecipeCard('Receta 3', 'Descripción de la receta 3'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(String title, String description) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
        subtitle: Text(description, style: Theme.of(context).textTheme.bodyMedium),
        onTap: () {
          // Navegar a la pantalla de detalles de la receta
        },
      ),
    );
  }
}