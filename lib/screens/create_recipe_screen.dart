import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
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
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

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
            if (_image != null) ...[
              SizedBox(height: 20),
              Image.file(_image!, height: 200),
            ],
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
                      'image': _image,
                    });
                    Navigator.pop(context, true);
                  } catch (e) {
                    print('Error detallado al crear la receta: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al crear la receta: $e')),
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
