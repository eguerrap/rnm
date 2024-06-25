import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnm/features/characters/presentation/providers/character_list_provider.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import 'package:rnm/shared/themes/app_theme.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final characterListProvider = Provider.of<CharacterListProvider>(context, listen: false);
    final recentCharactersManager = Provider.of<RecentCharactersManager>(context, listen: false);
    final TextEditingController filterController = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      color: AppTheme.primaryColor,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: filterController,
              decoration: InputDecoration(
                hintText: 'Filtro',
                hintStyle: TextStyle(fontSize: 14, color: AppTheme.accentColor.withOpacity(0.7)),
                prefixIcon: const Icon(Icons.search, color: AppTheme.iconColor),
                suffixIcon: filterController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: AppTheme.iconColor),
                        onPressed: () {
                          filterController.clear();
                          characterListProvider.clearFilter();
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.primaryColorLight,
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                characterListProvider.setFilter(value);
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.home, color: AppTheme.iconColor),
            onPressed: () {
              if (recentCharactersManager.recentCharacters.isNotEmpty) {
                characterListProvider.clearFilter();
                filterController.clear();
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                characterListProvider.clearFilter();
                filterController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
