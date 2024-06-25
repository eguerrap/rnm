import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import 'package:rnm/shared/themes/app_theme.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final recentCharactersManager = Provider.of<RecentCharactersManager>(context);

    return Scaffold(
      backgroundColor: AppTheme.homeBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.homeBackgroundColor,
        title: const Text('Inicio', style: TextStyle(color: AppTheme.homeTextColor)),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: recentCharactersManager.recentCharacters.isEmpty
            ? const Text('No hay personajes visitados recientemente', style: TextStyle(color: AppTheme.homeTextColor))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppTheme.homeDetailBackgroundColor,
                        width: 4.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        recentCharactersManager.recentCharacters.first.image,
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    recentCharactersManager.recentCharacters.first.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.homeTextColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.homeBackgroundColor,
                      foregroundColor: AppTheme.homeTextColor,
                      side: const BorderSide(color: AppTheme.homeTextColor, width: 1.0),
                    ),
                    onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/characterList',
                      (Route<dynamic> route) => false,
                    );
                  },
                    child: const Text('Ir a la lista de personajes', style: TextStyle(color: AppTheme.homeTextColor)),
                  ),
                ],
              ),
      ),
    );
  }

}
