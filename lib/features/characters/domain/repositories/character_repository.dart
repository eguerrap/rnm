// Repositorio de personajes que define las operaciones a implementar
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/character.dart';

abstract class CharacterRepository {
  Future<Either<Failure, List<Character>>> getCharacters(int page);
  Future<Either<Failure, Character>> getCharacterDetail(int id);
}
