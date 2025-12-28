import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/category_service.dart';
import '../../providers/providers.dart';

class EditCategoryScreen extends StatelessWidget {
  const EditCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);

    if (categoryService.selectCategory == null) {
      return const Scaffold(
        body: Center(
          child: Text('No se ha seleccionado una categoría'),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => CategoryFormProvider(categoryService.selectCategory!),
      child: _EditCategoryBody(categoryService: categoryService),
    );
  }
}

class _EditCategoryBody extends StatelessWidget {
  final CategoryService categoryService;

  const _EditCategoryBody({super.key, required this.categoryService});

  @override
  Widget build(BuildContext context) {
    final categoryForm = Provider.of<CategoryFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryForm.category.categoryName.isNotEmpty
            ? categoryForm.category.categoryName
            : 'Editar Categoría'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: categoryForm.formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: categoryForm.category.categoryName,
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => categoryForm.category.categoryName = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
               //initialValue: categoryForm.category.categoryDescription,
                //decoration: const InputDecoration(labelText: 'Descripción'),
                //onChanged: (value) =>
                  //  categoryForm.category.categoryDescription = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'delete',
            child: categoryService.isProcessing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.delete_forever),
            onPressed: categoryService.isProcessing
                ? null
                : () async {
                    await categoryService.deleteCategory(categoryForm.category);
                    Navigator.pop(context);
                  },
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'save',
            child: categoryService.isProcessing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.save),
            onPressed: categoryService.isProcessing
                ? null
                : () async {
                    if (!categoryForm.isValidForm()) return;
                    await categoryService.saveOrCreateCategory(categoryForm.category);
                    Navigator.pop(context);
                  },
          ),
        ],
      ),
    );
  }
}
