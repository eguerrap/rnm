import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rnm/core/error/exceptions.dart';
import 'package:rnm/features/characters/data/datasources/character_remote_data_source.dart';
import 'package:rnm/features/characters/data/models/character_model.dart';
import 'package:rnm/features/characters/data/models/location_model.dart';

import 'character_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CharacterRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = CharacterRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getCharacters', () {
    const tPage = 1;
    final tCharacterList = [
      const CharacterModel(
        id: 1,
        name: 'Rick Sanchez',
        status: 'Alive',
        species: 'Human',
        type: '',
        gender: 'Male',
        origin: LocationModel(
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
        ),
        location: LocationModel(
          name: 'Earth',
          type: 'Planet',
          dimension: 'Dimension C-137',
        ),
        image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      ),
    ];

    test('debe retornar una lista de CharacterModel cuando el código de respuesta es 200 (éxito)', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(json.encode({'results': tCharacterList}), 200),
      );

      // Act
      final result = await dataSource.getCharacters(tPage);

      // Assert
      expect(result, equals(tCharacterList));
    });

    test('debe lanzar un ServerException cuando el código de respuesta no es 200', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Algo salió mal', 404),
      );

      // Act
      final call = dataSource.getCharacters;

      // Assert
      expect(() => call(tPage), throwsA(isA<ServerException>()));
    });
  });

  group('getCharacterDetail', () {
    const tId = 1;
    const tCharacter = CharacterModel(
      id: 1,
      name: 'Rick Sanchez',
      status: 'Alive',
      species: 'Human',
      type: '',
      gender: 'Male',
      origin: LocationModel(
        name: 'Earth',
        type: 'Planet',
        dimension: 'Dimension C-137',
      ),
      location: LocationModel(
        name: 'Earth',
        type: 'Planet',
        dimension: 'Dimension C-137',
      ),
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    );

    test('debe retornar un CharacterModel cuando el código de respuesta es 200 (éxito)', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response(json.encode(tCharacter), 200),
      );

      // Act
      final result = await dataSource.getCharacterDetail(tId);

      // Assert
      expect(result, equals(tCharacter));
    });

    test('debe lanzar un ServerException cuando el código de respuesta no es 200', () async {
      // Arrange
      when(mockHttpClient.get(any)).thenAnswer(
        (_) async => http.Response('Algo salió mal', 404),
      );

      // Act
      final call = dataSource.getCharacterDetail;

      // Assert
      expect(() => call(tId), throwsA(isA<ServerException>()));
    });
  });
}
