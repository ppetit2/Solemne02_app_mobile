import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/categoria.dart';
import 'package:provider/provider.dart';

import '../../services/category_service.dart';


class ListCategoryScreen extends StatelessWidget {
  const ListCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    if (categoryService.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado Categorías'),
      ),
      body: ListView.builder(
        itemCount: categoryService.categories.length,
        itemBuilder: (context, index) {
          final category = categoryService.categories[index];

          return ListTile(
            title: Text(category.categoryName),
            
            onTap: () {
              categoryService.selectCategory = category.copy();
              Navigator.pushNamed(context, 'edit_category');
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete_forever, color: Colors.red),
              onPressed: () async {
                await categoryService.deleteCategory(category);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          categoryService.selectCategory = ListadoCategory(
            categoryId: 0,
            categoryName: '', categoryState: '',
          );
          Navigator.pushNamed(context, 'edit_category');
        },
      ),
    );
  }
}
