import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/menuButton.dart';
import '../services/services.dart'; // Asegúrate que AuthService esté aquí

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Obtenemos AuthService
              final authService = Provider.of<AuthService>(context, listen: false);
              // Cerramos sesión
              authService.logout();
              // Redirigimos al login reemplazando la ruta actual
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Título
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Menú principal',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),

            const SizedBox(height: 20),

            // Botones modernos
            MenuButton(
              title: 'Categorías',
              icon: Icons.category_outlined,
              route: 'list_category',
            ),
            MenuButton(
              title: 'Proveedores',
              icon: Icons.local_shipping_outlined,
              route: 'list_provider',
            ),
            MenuButton(
              title: 'Productos',
              icon: Icons.inventory_2_outlined,
              route: 'list_product',
            ),
          ],
        ),
      ),
    );
  }
}

