import 'package:flutter/material.dart';
import 'db_helper.dart';

class AddRecipeScreen extends StatefulWidget {
  final Map<String, dynamic>? recipe;

  AddRecipeScreen({this.recipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      nameController.text = widget.recipe!['name'];
      timeController.text = widget.recipe!['preparation_time'];
      ingredientsController.text = widget.recipe!['ingredients'];
      instructionsController.text = widget.recipe!['instructions'];
    }
  }

  Future<void> saveRecipe() async {
    final recipe = {
      'name': nameController.text,
      'preparation_time': timeController.text,
      'ingredients': ingredientsController.text,
      'instructions': instructionsController.text,
    };

    if (widget.recipe == null) {
      await DBHelper().insertRecipe(recipe);
    } else {
      await DBHelper().updateRecipe(widget.recipe!['id'], recipe);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah/Edit Resep')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nama Resep'),
              ),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Waktu Persiapan'),
              ),
              TextFormField(
                controller: ingredientsController,
                decoration: InputDecoration(labelText: 'Bahan-Bahan'),
                maxLines: 3,
              ),
              TextFormField(
                controller: instructionsController,
                decoration: InputDecoration(labelText: 'Langkah-Langkah'),
                maxLines: 3,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: saveRecipe,
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
