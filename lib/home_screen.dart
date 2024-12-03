import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'add_recipe_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> recipes = [];

  @override
  void initState() {
    super.initState();
    fetchRecipes();
  }

  Future<void> fetchRecipes() async {
    final data = await DBHelper().fetchRecipes();
    setState(() {
      recipes = data;
    });
  }

  Future<void> deleteRecipe(int id) async {
    await DBHelper().deleteRecipe(id);
    fetchRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Resep')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return ListTile(
            title: Text(recipe['name']),
            subtitle: Text('Waktu: ${recipe['preparation_time']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteRecipe(recipe['id']),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailScreen(recipe: recipe),
                ),
              ).then((_) => fetchRecipes());
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddRecipeScreen()),
          ).then((_) => fetchRecipes());
        },
      ),
    );
  }
}
