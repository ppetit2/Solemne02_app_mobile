import 'package:flutter/material.dart';
import '../models/categoria.dart';

class CardCategory extends StatelessWidget {
  final ListadoCategory category;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const CardCategory({
    super.key,
    required this.category,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      child: ListTile(
        title: Text(category.categoryName),
        
        onTap: onTap,
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
