import 'package:flutter/material.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import 'package:rnm/features/characters/domain/entities/character.dart';

class RecentCharactersList extends StatelessWidget {
  final RecentCharactersManager recentCharactersManager;
  final void Function(Character) onTap;

  const RecentCharactersList({super.key, 
    required this.recentCharactersManager,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recentCharactersManager.recentCharacters.length,
        itemBuilder: (context, index) {
          final character = recentCharactersManager.recentCharacters[index];
          return GestureDetector(
            onTap: () => onTap(character),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.network(
                      character.image,
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    character.name,
                    style: const TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
