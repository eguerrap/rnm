import 'package:flutter/material.dart';
import 'package:rnm/features/characters/domain/entities/character.dart';
import 'package:rnm/features/characters/domain/repositories/character_repository.dart';

class CharacterListProvider with ChangeNotifier {
  final CharacterRepository repository;
  final List<Character> _characters = [];
  List<Character> _filteredCharacters = [];
  bool hasMore = true;
  int _page = 1;
  String _filter = '';
  bool _isLoading = false;

  CharacterListProvider({required this.repository}) {
    fetchCharacters();
  }

  List<Character> get characters => _characters;
  List<Character> get filteredCharacters => _filteredCharacters;
  bool get isLoading => _isLoading;

  void fetchCharacters() async {
    if (isLoading) return;

    _isLoading = true;
    notifyListeners();

    final result = await repository.getCharacters(_page);

    result.fold(
      (failure) {
        // Manejo de error
      },
      (newCharacters) {
        if (newCharacters.isEmpty) {
          hasMore = false;
        } else {
          _characters.addAll(newCharacters);
          _page++;
        }
        _applyFilter();
      },
    );

    _isLoading = false;
    notifyListeners();
  }

  void setFilter(String filter) {
     _isLoading = true;
    Future.delayed(Duration.zero, () => notifyListeners());

    if (filter.isEmpty) {
      _filteredCharacters = _characters;
    } else {
      _filteredCharacters = _characters
          .where((character) =>
              character.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }

    _isLoading = false;
    Future.delayed(Duration.zero, () => notifyListeners());
  }

  void clearFilter() {
    _filter = '';
    _applyFilter();
    _isLoading = false; 
    notifyListeners();
  }

  void _applyFilter() {
    if (_filter.isEmpty) {
      _filteredCharacters = _characters;
    } else {
      _filteredCharacters = _characters
          .where((character) =>
              character.name.toLowerCase().contains(_filter.toLowerCase()))
          .toList();
    }

    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}
