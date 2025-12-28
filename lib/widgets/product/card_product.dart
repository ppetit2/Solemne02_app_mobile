import 'package:flutter/material.dart';
import '../../models/productos.dart';
import '../widgets.dart';

class CardProduct extends StatelessWidget {
  final Listado product;
  const CardProduct({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 10),
        width: double.infinity,
        decoration: _cardDecorations(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            ImageProduct(url: product.productImage),
            DetailProduct(productName: product.productName),
            Positioned(
              top: 0,
              right: 0,
              child: PriceProduct(productPrice: product.productPrice),
            ),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _cardDecorations() => BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(25),
  boxShadow: const [
    BoxShadow(color: Colors.black, offset: Offset(0, 5), blurRadius: 10),
  ],
);