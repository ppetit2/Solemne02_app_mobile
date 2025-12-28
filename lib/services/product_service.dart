import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/productos.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = '143.198.118.203:8100';
  final String _user = 'test';
  final String _pass = 'test2023';

  List<Listado> products = [];
  Listado? selectProduct;
  bool isLoading = true;
  bool isProcessing = false; // Nuevo estado para guardar/eliminar

  ProductService() {
    loadProducts();
  }

  // Cargar productos desde la API
  Future loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.http(_baseUrl, 'ejemplos/product_list_rest/');
      String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
      final response = await http.get(url, headers: {'authorization': basicAuth});

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        final List<dynamic> productList = decodedData['Listado'] ?? [];
        products = productList.map((e) => Listado.fromJson(e)).toList();
      } else {
        products = [];
      }
    } catch (e) {
      print('Error cargando productos: $e');
      products = [];
    }

    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProducts(Listado product) async {
    isProcessing = true;
    notifyListeners();

    try {
      if (product.productId == 0) {
        await createProduct(product);
      } else {
        await updateProduct(product);
      }
    } catch (e) {
      print('Error guardando producto: $e');
    }

    isProcessing = false;
    notifyListeners();
  }

  Future updateProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_edit_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode(product.toJson()),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final index = products.indexWhere((p) => p.productId == product.productId);
    if (index != -1) products[index] = product;
  }

  Future createProduct(Listado product) async {
    final url = Uri.http(_baseUrl, 'ejemplos/product_add_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode(product.toJson()),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    products.add(product);
  }

  Future deleteProduct(Listado product) async {
    isProcessing = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, 'ejemplos/product_del_rest/');
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));

    await http.post(
      url,
      body: jsonEncode({"productid": product.productId}),
      headers: {
        'authorization': basicAuth,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    products.removeWhere((p) => p.productId == product.productId);
    isProcessing = false;
    notifyListeners();
  }
}






