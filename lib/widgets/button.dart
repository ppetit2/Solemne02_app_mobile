import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String textButton;
  final String pathButton;

  const Button({
    super.key,
    required this.textButton,
    required this.pathButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, pathButton),
          child: Text(textButton),
        ),
      ),
    );
  }
}
