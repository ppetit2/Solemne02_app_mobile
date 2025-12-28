import 'package:flutter/material.dart';

class PriceProduct extends StatelessWidget {
  final int productPrice;
  const PriceProduct({super.key, required this.productPrice});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: _boxDecoration(),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$$productPrice',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Color.fromARGB(255, 57, 57, 224),
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
    );
  }
}
