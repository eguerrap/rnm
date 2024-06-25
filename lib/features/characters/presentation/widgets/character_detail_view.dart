// Widget para mostrar el detalle de un personaje
import 'package:flutter/material.dart';
import '../../domain/entities/character.dart';

class CharacterDetailView extends StatelessWidget {
  final Character character;

  const CharacterDetailView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(character.image),
        Text(character.name),
        Text(character.status),
        Text(character.species),
        Text(character.type),
        Text(character.gender),
        Text('Origen: ${character.origin.name}'),
        Text('Ubicación: ${character.location.name}'),
      ],
    );
  }
}
