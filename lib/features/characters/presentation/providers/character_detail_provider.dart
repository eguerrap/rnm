import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:rnm/features/characters/presentation/providers/recent_characters_manager.dart';
import '../../domain/entities/character.dart';
import '../../domain/usecases/get_character_detail.dart';

class CharacterDetailProvider with ChangeNotifier {
  final int characterId;
  final GetCharacterDetail getCharacterDetail;
  final RecentCharactersManager recentCharactersManager;
  Character? _character;
  bool _isLoading = false;

  CharacterDetailProvider({
    required this.characterId,
    required this.getCharacterDetail,
    required this.recentCharactersManager,
  });

  Character? get character => _character;
  bool get isLoading => _isLoading;

  Future<void> fetchCharacterDetail() async {
    _isLoading = true;
    _notifyListenersSafely();

    final result = await getCharacterDetail(characterId);

    result.fold(
      (failure) => _character = null,
      (character) {
        _character = character;
        recentCharactersManager.addCharacter(character);
      },
    );

    _isLoading = false;
    _notifyListenersSafely();
  }

  void _notifyListenersSafely() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
