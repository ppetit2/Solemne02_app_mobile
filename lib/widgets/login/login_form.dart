import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import '../../providers/providers.dart';

class LoginForm extends StatelessWidget {
  final String textButton;
  final String pathButton;
  final int loginRegister;
  const LoginForm({
    super.key,
    required this.textButton,
    required this.pathButton,
    required this.loginRegister,
  });
  @override
  Widget build(BuildContext context) {
    final LoginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: LoginForm.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: 'Ingrese su correo',
              labelText: 'Email',
              prefixIcon: Icons.people,
            ),
            onChanged: (value) => LoginForm.email = value,
            validator: (value) {
              return (value != null && value.length > 4)
                  ? null
                  : 'El usuario no puede estar vacio o ser de menos de 4 caracters';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
              hinText: '***********',
              labelText: 'Password',
              prefixIcon: Icons.lock_open_outlined,
            ),
            onChanged: (value) => LoginForm.pasword = value,
            validator: (value) {
              return (value != null && value.length > 4)
                  ? null
                  : 'La contraseña no puede estar vacio o ser de menos de 4 caracters';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Colors.blueGrey,
            elevation: 0,
            //onPressed: () => Navigator.pushNamed(context, pathButton),
            onPressed: LoginForm.isloading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(
                      context,
                      listen: false,
                    );
                    if (!LoginForm.isValidForm()) return;
                    if (loginRegister == 1) {
                      final String? errorMessage = await authService.login(
                        LoginForm.email,
                        LoginForm.pasword,
                      );
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, pathButton);
                      } else {
                        print(errorMessage);
                      }
                    } else {
                      final String? errorMessage = await authService.createUser(
                        LoginForm.email,
                        LoginForm.pasword,
                      );
                      if (errorMessage == null) {
                        Navigator.pushNamed(context, pathButton);
                      } else {
                        print(errorMessage);
                      }
                    }
                    LoginForm.isloading = false;
                  },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
              child: Text(textButton, style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}