import 'package:flutter/material.dart';
import '../models/proveedor.dart';

class ProviderFormProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Proveedor provider;

  ProviderFormProvider(this.provider);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

