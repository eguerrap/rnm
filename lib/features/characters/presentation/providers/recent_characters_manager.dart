import 'package:flutter/material.dart';
import 'package:rnm/features/characters/domain/entities/character.dart';

class RecentCharactersManager with ChangeNotifier {
  final List<Character> _recentCharacters = [];

  List<Character> get recentCharacters => List.unmodifiable(_recentCharacters);

  void addCharacter(Character character) {
    if (_recentCharacters.contains(character)) {
      _recentCharacters.remove(character);
    }
    _recentCharacters.insert(0, character);
    if (_recentCharacters.length > 5) {
      _recentCharacters.removeLast();
    }
    notifyListeners();
  }
}
