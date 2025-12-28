import 'package:flutter/material.dart';
import '../models/categoria.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ListadoCategory category;

  CategoryFormProvider(this.category);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}

