import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/provider_service.dart';
import '../screens/screens.dart';

class AppRoutes {
  static const initialRoute = 'login';

  static Map<String, Widget Function(BuildContext)> routes = {
    'login': (_) => const LoginScreen(),
    'register': (_) => const RegisterScreen(),
    'home': (_) => const HomeScreen(),

    // Productos
    'list_product': (_) => const ListProductScreen(),
    'edit_product': (_) => const EditProductScreen(),

    // Proveedores
    'list_provider': (_) => const ListProviderScreen(),
    'edit_provider': (_) => const EditProviderScreen(),

    // Categorías
    'list_category': (_) => const ListCategoryScreen(),
    'edit_category': (_) => const EditCategoryScreen(),

    'error': (_) => const ErrorScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorScreen(),
    );
  }
}


