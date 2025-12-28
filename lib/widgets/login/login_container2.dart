import 'package:flutter/material.dart';

import '../widgets.dart';

class LoginContainer2 extends StatelessWidget {
  const LoginContainer2({super.key});
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: sizeScreen.height * 0.4,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(107, 133, 220, 1),
            Color.fromRGBO(17, 31, 113, 1),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(top: 90, left: 30, child: Buble()),
          Positioned(top: -40, left: -30, child: Buble()),
          Positioned(top: -50, left: -20, child: Buble()),
          Positioned(top: 120, right: 20, child: Buble()),
          Positioned(top: 20, right: 80, child: Buble()),
          Positioned(top: -50, right: -20, child: Buble()),
        ],
      ),
    );
  }
}