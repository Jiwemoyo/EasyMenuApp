import 'package:flutter/material.dart';
import '../services/recipe_service.dart';

class CreateRecipeScreen extends StatefulWidget {
  final String userId;

  CreateRecipeScreen({required this.userId});

  @override
  _CreateRecipeScreenState createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Receta')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese una descripción';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredientes (separados por coma)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese los ingredientes';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _stepsController,
              decoration: InputDecoration(labelText: 'Pasos (separados por punto y coma)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese los pasos';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    await ApiService.createRecipe({
                      'title': _titleController.text,
                      'description': _descriptionController.text,
                      'ingredients': _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
                      'steps': _stepsController.text.split(';').map((e) => e.trim()).toList(),
                      'author': widget.userId,
                    });
                    Navigator.pop(context, true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al crear la receta')),
                    );
                  }
                }
              },
              child: Text('Crear Receta'),
            ),
          ],
        ),
      ),
    );
  }
}