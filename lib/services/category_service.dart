import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/categoria.dart';

class CategoryService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<ListadoCategory> categories = [];
  ListadoCategory? selectCategory;
  bool isLoading = true;
  bool isProcessing = false;

  CategoryService() {
    loadCategories();
  }

  Future loadCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.http(_baseUrl, 'ejemplos/category_list_rest/');
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
      final response = await http.get(url, headers: {'authorization': basicAuth});

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        final List<dynamic> categoryList = decodedData['Listado Categorias'] ?? [];
        categories = categoryList.map((e) => ListadoCategory.fromMap(e)).toList();
      } else {
        categories = [];
      }
    } catch (e) {
      print('Error cargando categorías: $e');
      categories = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future saveOrCreateCategory(ListadoCategory category) async {
    isProcessing = true;
    notifyListeners();

    if (category.categoryId == 0) {
      await createCategory(category);
    } else {
      await updateCategory(category);
    }

    isProcessing = false;
    await loadCategories();
    notifyListeners();
  }

  Future updateCategory(ListadoCategory category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode(category.toMap()),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final index = categories.indexWhere((c) => c.categoryId == category.categoryId);
    if (index != -1) categories[index] = category;
  }

  Future createCategory(ListadoCategory category) async {
    final url = Uri.http(_baseUrl, 'ejemplos/category_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode(category.toMap()),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    categories.add(category);
  }

  Future deleteCategory(ListadoCategory category) async {
    isProcessing = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/category_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode({"category_id": category.categoryId}),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    categories.removeWhere((c) => c.categoryId == category.categoryId);
    isProcessing = false;
    notifyListeners();
  }
}

