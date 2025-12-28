import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../services/provider_service.dart';

class EditProviderScreen extends StatelessWidget {
  const EditProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final providerService = Provider.of<ProviderService>(context);

    if (providerService.SelectProvider == null) {
      return const Scaffold(
        body: Center(
          child: Text('No se ha seleccionado un proveedor'),
        ),
      );
    }

    return ChangeNotifierProvider(
      create: (_) => ProviderFormProvider(providerService.SelectProvider!),
      child: _ProviderScreenBody(providerService: providerService),
    );
  }
}

class _ProviderScreenBody extends StatelessWidget {
  final ProviderService providerService;

  const _ProviderScreenBody({
    required this.providerService,
  });

  @override
  Widget build(BuildContext context) {
    final providerForm = Provider.of<ProviderFormProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Proveedor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: providerForm.formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: providerForm.provider.providerName,
                decoration: const InputDecoration(labelText: 'Nombre'),
                onChanged: (value) => providerForm.provider.providerName = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                initialValue: providerForm.provider.providerLastName,
                decoration: const InputDecoration(labelText: 'Apellido'),
                onChanged: (value) => providerForm.provider.providerLastName = value,
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo obligatorio' : null,
              ),
              TextFormField(
                initialValue: providerForm.provider.providerMail,
                decoration: const InputDecoration(labelText: 'Correo'),
                onChanged: (value) => providerForm.provider.providerMail = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Botón eliminar
          FloatingActionButton(
            heroTag: 'delete',
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete_forever),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Confirmar eliminación'),
                  content: const Text('¿Seguro que deseas eliminar este proveedor?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              );

              if (confirm != true) return;
                await providerService.deleteProvider(providerForm.provider, context);

              // Volver al listado
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(width: 20),
          // Botón guardar
          FloatingActionButton(
            heroTag: 'save',
            backgroundColor: Colors.green,
            child: const Icon(Icons.save),
            onPressed: () async {
              if (!providerForm.isValidForm()) return;

              await providerService.saveOrCreateProvider(providerForm.provider);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Proveedor guardado correctamente')),
              );

              // Volver al listado
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

