import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/proveedor.dart';

class ProviderService extends ChangeNotifier {
  final String _baseUrl = "http://143.198.118.203:8100";
  final String _user = "test";
  final String _pass = "test2023";

  List<Proveedor> providers = [];
  Proveedor? SelectProvider;
  bool isLoading = true;

  ProviderService() {
    loadProviders();
  }

  Map<String, String> get headers => {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$_user:$_pass'))}',
        'Content-Type': 'application/json',
      };

Future<void> loadProviders() async {
  isLoading = true;
  notifyListeners();

  final url = Uri.parse("$_baseUrl/ejemplos/provider_list_rest/");
  final response = await http.get(url, headers: headers);

  final decoded = jsonDecode(response.body);

  List list = [];

  if (decoded is Map<String, dynamic> &&
      decoded['Proveedores Listado'] is List) {
    list = decoded['Proveedores Listado'];
  }

  providers = list.map((e) => Proveedor.fromJson(e)).toList();

  isLoading = false;
  notifyListeners();
}
  Future<void> saveOrCreateProvider(Proveedor provider) async {
    provider.providerid == 0
        ? await createProvider(provider)
        : await updateProvider(provider);

    await loadProviders();
  }

  Future<void> createProvider(Proveedor provider) async {
    final url = Uri.parse("$_baseUrl/ejemplos/provider_add_rest/");
    await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        "provider_name": provider.providerName,
        "provider_last_name": provider.providerLastName,
        "provider_mail": provider.providerMail,
        "provider_state": "Activo",
      }),
    );
  }

  Future<void> updateProvider(Proveedor provider) async {
    final url = Uri.parse("$_baseUrl/ejemplos/provider_edit_rest/");
    await http.post(
      url,
      headers: headers,
      body: jsonEncode(provider.toJson()),
    );
  }

  Future<void> deleteProvider(Proveedor provider, BuildContext context) async {
    final url = Uri.parse("$_baseUrl/ejemplos/provider_del_rest/");
    await http.post(
      url,
      headers: headers,
      body: jsonEncode({"provider_id": provider.providerid}),
    );

    Navigator.pop(context);
    await loadProviders();
  }
}




