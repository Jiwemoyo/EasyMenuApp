import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  File? _image;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.recipe['title']);
    _descriptionController = TextEditingController(text: widget.recipe['description']);
    _ingredientsController = TextEditingController(text: widget.recipe['ingredients'].join(', '));
    _stepsController = TextEditingController(text: widget.recipe['steps'].join('; '));
    _currentImageUrl = widget.recipe['image'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _currentImageUrl = null; // Clear the current image URL if a new image is selected
      });
    }
  }

  Future<void> _updateRecipe() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedRecipe = await ApiService.updateRecipe(
          widget.recipe['_id'],
          {
            'title': _titleController.text,
            'description': _descriptionController.text,
            'ingredients': _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
            'steps': _stepsController.text.split(';').map((e) => e.trim()).toList(),
            'author': widget.recipe['author'],
            'image': _image,
          },
        );
        Navigator.pop(context, updatedRecipe);
      } catch (e) {
        print('Error detallado al actualizar la receta: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar la receta: $e')),
        );
      }
    }
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera),
                  child: Text('Tomar Foto'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  child: Text('Seleccionar Imagen'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_image != null)
              Image.file(_image!, height: 200)
            else if (_currentImageUrl != null)
              Image.network(_currentImageUrl!, height: 200)
            else
              Text('No hay imagen seleccionada'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateRecipe,
              child: Text('Actualizar Receta'),
            ),
          ],
        ),
      ),
    );
  }
}