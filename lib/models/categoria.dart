import 'dart:convert';

class Category {
  Category({required this.listado});

  List<ListadoCategory> listado;

  factory Category.fromJson(String str) =>
      Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        listado: List<ListadoCategory>.from(
            json["Listado Categorias"].map((x) => ListadoCategory.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "Listado Categorias": List<dynamic>.from(listado.map((x) => x.toMap())),
      };
}

class ListadoCategory {
  ListadoCategory({
    required this.categoryId,
    required this.categoryName,
    required this.categoryState,
  });

  int categoryId;
  String categoryName;
  String categoryState;

  factory ListadoCategory.fromMap(Map<String, dynamic> json) =>
      ListadoCategory(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryState: json["category_state"],
      );

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_state": categoryState,
      };

  ListadoCategory copy() => ListadoCategory(
        categoryId: categoryId,
        categoryName: categoryName,
        categoryState: categoryState,
      );
}

