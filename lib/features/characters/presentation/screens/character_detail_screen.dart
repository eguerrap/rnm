import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnm/shared/themes/app_theme.dart';
import '../providers/character_detail_provider.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        title: const Text('Detalle del Personaje', style: TextStyle(color: AppTheme.accentColor)),
        iconTheme: const IconThemeData(color: AppTheme.accentColor),
      ),
      body: Consumer<CharacterDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.character == null) {
            return const Center(child: Text('No se encontraron detalles del personaje'));
          } else {
            final character = provider.character!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      character.image,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    character.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8.0),
                  _buildDetailItem(context, 'Estado', character.status),
                  _buildDetailItem(context, 'Especie', character.species),
                  _buildDetailItem(context, 'Tipo', character.type.isEmpty ? 'N/A' : character.type),
                  _buildDetailItem(context, 'Género', character.gender),
                  const SizedBox(height: 16.0),
                  Text('Origen', style: Theme.of(context).textTheme.titleLarge),
                  _buildDetailItem(context, 'Nombre', character.origin.name),
                  _buildDetailItem(context, 'Tipo', character.origin.type),
                  _buildDetailItem(context, 'Dimensión', character.origin.dimension),
                  const SizedBox(height: 16.0),
                  Text('Ubicación', style: Theme.of(context).textTheme.titleLarge),
                  _buildDetailItem(context, 'Nombre', character.location.name),
                  _buildDetailItem(context, 'Tipo', character.location.type),
                  _buildDetailItem(context, 'Dimensión', character.location.dimension),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.propertyNameColor,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.propertyValueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
