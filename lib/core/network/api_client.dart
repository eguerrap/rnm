import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../features/characters/data/models/character_model.dart';
import '../error/exceptions.dart';

class ApiClient {
  final http.Client client;

  ApiClient(this.client);

  Future<List<CharacterModel>> getCharacters(int page) async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
    );

    if (response.statusCode == 200) {
      final List characters = json.decode(response.body)['results'];
      return characters.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw ServerException(); // Asegúrate de que ServerException esté correctamente definida
    }
  }
}
