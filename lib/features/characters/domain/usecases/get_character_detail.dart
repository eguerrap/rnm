// Caso de uso para obtener los detalles de un personaje
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacterDetail implements UseCase<Character, int> {
  final CharacterRepository repository;

  GetCharacterDetail(this.repository);

  @override
  Future<Either<Failure, Character>> call(int id) async {
    return await repository.getCharacterDetail(id);
  }
}
