import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/providers.dart';
import 'package:flutter_application_1/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginAreaForm extends StatelessWidget {
  final String textTitle;
  final String textFinalButton;
  final String path;
  final String textButton;
  final String pathButton;
  final int loginRegister;
  const LoginAreaForm({
    super.key,
    required this.textTitle,
    required this.textFinalButton,
    required this.path,
    required this.textButton,
    required this.pathButton,
    required this.loginRegister,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 150),
          CardContainer(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text(
                  textTitle,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 30),
                ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(),
                  child: LoginForm(
                    textButton: textButton,
                    pathButton: pathButton,
                    loginRegister: loginRegister,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, path),
                  child: Text(textFinalButton),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}