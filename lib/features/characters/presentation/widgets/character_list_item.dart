import 'package:flutter/material.dart';
import 'package:rnm/features/characters/domain/entities/character.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;

  const CharacterListItem({super.key, required this.character, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(character.image),
      title: Text(character.name),
      subtitle: Text(character.type),
      onTap: onTap,
    );
  }
}
