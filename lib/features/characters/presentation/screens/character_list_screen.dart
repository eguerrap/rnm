import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rnm/features/characters/presentation/providers/character_list_provider.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import 'package:rnm/features/characters/presentation/widgets/character_list_item.dart';
import 'package:rnm/features/characters/presentation/widgets/recent_characters_list.dart';
import 'package:rnm/features/characters/presentation/widgets/bottom_bar.dart';

class CharacterListScreen extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rick y Morty'),
      ),
      body: Consumer2<CharacterListProvider, RecentCharactersManager>(
        builder: (context, provider, recentManager, child) {
          if (provider.isLoading && provider.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.characters.isEmpty) {
            return const Center(child: Text('No se encontraron personajes'));
          }

          return Column(
            children: [
              if (recentManager.recentCharacters.isNotEmpty)
                RecentCharactersList(
                  recentCharactersManager: recentManager,
                  onTap: (character) {
                    Navigator.pushNamed(
                      context,
                      '/characterDetail',
                      arguments: {
                        'characterId': character.id,
                        'recentCharactersManager': recentManager,
                      },
                    );
                  },
                ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!provider.isLoading &&
                        provider.hasMore &&
                        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                      provider.fetchCharacters();
                      return true;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    itemCount: provider.filteredCharacters.length + (provider.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= provider.filteredCharacters.length) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final character = provider.filteredCharacters[index];
                      return CharacterListItem(
                        character: character,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/characterDetail',
                            arguments: {
                              'characterId': character.id,
                              'recentCharactersManager': recentManager,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
    );
  }
}

class CharacterSearchDelegate extends SearchDelegate {
  final CharacterListProvider provider;

  CharacterSearchDelegate({required this.provider});

  @override
  String get searchFieldLabel => 'Buscar personajes';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          provider.setFilter(query);
          showSuggestions(context);
        },
      ),
      IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: () {
          query = '';
          provider.clearFilter();
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    provider.setFilter(query);
    return CharacterListScreen();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    provider.setFilter(query);
    return CharacterListScreen();
  }

  @override
  void showResults(BuildContext context) {
    provider.setFilter(query);
    super.showResults(context);
  }
}
