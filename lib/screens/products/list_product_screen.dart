import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../models/productos.dart';

class ListProductScreen extends StatelessWidget {
  const ListProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: productService.products.length,
        itemBuilder: (context, index) {
          final product = productService.products[index];

          return GestureDetector(
            onTap: () {
              productService.selectProduct = product.copy();
              Navigator.pushNamed(context, 'edit_product');
            },
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        child: Image.network(
                          product.productImage,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: product.productState.toLowerCase() == 'activo'
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            product.productState,
                            style: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            product.productName,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '\$${product.productPrice}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectProduct = Listado(
            productId: 0,
            productName: '',
            productPrice: 0,
            productImage:
                'https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg',
            productState: 'Activo',
          );
          Navigator.pushNamed(context, 'edit_product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}





