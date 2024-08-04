import 'package:flutter/material.dart';
import '../services/recipe_service.dart';

class UpdateRecipeScreen extends StatefulWidget {
  final Map<String, dynamic> recipe;

  UpdateRecipeScreen({required this.recipe});

  @override
  _UpdateRecipeScreenState createState() => _UpdateRecipeScreenState();
}

class _UpdateRecipeScreenState extends State<UpdateRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _ingredientsController;
  late TextEditingController _stepsController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe['title']);
    _descriptionController = TextEditingController(text: widget.recipe['description']);
    _ingredientsController = TextEditingController(text: widget.recipe['ingredients'].join(', '));
    _stepsController = TextEditingController(text: widget.recipe['steps'].join('; '));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Actualizar Receta')),
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
                    await ApiService.updateRecipe(
                      widget.recipe['_id'],
                      {
                        'title': _titleController.text,
                        'description': _descriptionController.text,
                        'ingredients': _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
                        'steps': _stepsController.text.split(';').map((e) => e.trim()).toList(),
                      },
                    );
                    Navigator.pop(context, true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al actualizar la receta')),
                    );
                  }
                }
              },
              child: Text('Actualizar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}