import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.selectProduct == null) {
      return const Scaffold(
        body: Center(
          child: Text('No se ha seleccionado un producto'),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectProduct!),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;

  const _ProductScreenBody({
    super.key,
    required this.productService,
  });

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(productForm.product.productName.isNotEmpty
            ? productForm.product.productName
            : 'Editar Producto'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                productForm.product.productImage.isNotEmpty
                    ? productForm.product.productImage
                    : 'https://abravidro.org.br/wp-content/uploads/2015/04/sem-imagem4.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 100, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FormProduct(),
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
            child: productService.isProcessing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.delete_forever),
            onPressed: productService.isProcessing
                ? null
                : () async {
                    if (!productForm.isValidForm()) return;
                    await productService.deleteProduct(productForm.product);
                    Navigator.pop(context);
                  },
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            heroTag: 'save',
            child: productService.isProcessing
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.save),
            onPressed: productService.isProcessing
                ? null
                : () async {
                    if (!productForm.isValidForm()) return;
                    await productService.editOrCreateProducts(productForm.product);
                    Navigator.pop(context);
                  },
          ),
        ],
      ),
    );
  }
}









