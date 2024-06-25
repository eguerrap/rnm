// Caso de uso para obtener los personajes
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/character.dart';
import '../repositories/character_repository.dart';

class GetCharacters implements UseCase<List<Character>, int> {
  final CharacterRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Either<Failure, List<Character>>> call(int page) async {
    return await repository.getCharacters(page);
  }
}
