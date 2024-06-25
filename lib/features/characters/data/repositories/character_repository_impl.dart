import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/character.dart';
import '../../domain/repositories/character_repository.dart';
import '../datasources/character_remote_data_source.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterRemoteDataSource remoteDataSource;

  CharacterRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Character>>> getCharacters(int page) async {
    try {
      final remoteCharacters = await remoteDataSource.getCharacters(page);
      return Right(remoteCharacters);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Character>> getCharacterDetail(int id) async {
    try {
      final remoteCharacter = await remoteDataSource.getCharacterDetail(id);
      return Right(remoteCharacter);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
