import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/proveedor.dart';
import '../../services/provider_service.dart';

class ListProviderScreen extends StatelessWidget {
  const ListProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proveedores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              providerService.SelectProvider = Proveedor(
                providerid: 0,
                providerName: '',
                providerLastName: '',
                providerMail: '',
                providerState: 'Activo',
              );
              Navigator.pushNamed(context, 'edit_provider');
            },
          )
        ],
      ),
      body: providerService.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: providerService.providers.length,
              itemBuilder: (context, index) {
                final proveedor = providerService.providers[index];

                return Card(
                  child: ListTile(
                    title: Text(
                      '${proveedor.providerName} ${proveedor.providerLastName}',
                    ),
                    subtitle: Text(proveedor.providerMail),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        providerService.SelectProvider = proveedor.copy();
                        Navigator.pushNamed(context, 'edit_provider');
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}


