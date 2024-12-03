import 'package:flutter/material.dart';
import 'add_recipe_screen.dart';
import 'db_helper.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailScreen({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Waktu: ${recipe['preparation_time']}'),
            SizedBox(height: 8),
            Text('Bahan-Bahan:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe['ingredients']),
            SizedBox(height: 8),
            Text('Langkah-Langkah:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(recipe['instructions']),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddRecipeScreen(recipe: recipe),
            ),
          ).then((_) => Navigator.pop(context));
        },
      ),
    );
  }
}
