import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rnm/core/error/exceptions.dart';
import '../models/character_model.dart';

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getCharacters(int page);
  Future<CharacterModel> getCharacterDetail(int id); 
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CharacterModel>> getCharacters(int page) async {
    final response = await client.get(
      Uri.parse('https://rickandmortyapi.com/api/character?page=$page'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((data) => CharacterModel.fromJson(data)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CharacterModel> getCharacterDetail(int id) async {
    final response = await client.get(Uri.parse('https://rickandmortyapi.com/api/character/$id'));

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return CharacterModel.fromJson(jsonMap);
    } else {
      throw ServerException();
    }
  }
}
