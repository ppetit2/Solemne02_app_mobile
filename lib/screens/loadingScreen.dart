import 'package:flutter/material.dart';

class Loadingscreen extends StatelessWidget {
  const Loadingscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Loadingscreen')),
      body: const Center(child: Text('Loadingscreen')),
    );
  }
}
