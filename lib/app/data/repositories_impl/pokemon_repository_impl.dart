
import 'package:either_dart/either.dart';

import '../../../core/failure.dart';
import '../../domain/failures/cant_get_pokemon_pokeapi_failure.dart';
import '../../domain/repositories_abstract/pokemon_repository_abstract.dart';
import '../datasources/pokemon_data_source_impl.dart';
import '../models/pokemon_model.dart';

class PokemonRepositoryImpl implements PokemonRepositoryAbstract {
  PokemonRepositoryImpl({required this.dataSource});
  final PokemonDataSourceImpl dataSource;

  @override
  Future<Either<Failure, PokemonModel>> getPokemonsList() async {
    try {
      final response = await dataSource.getPokemons();

      if (response.success) {
        return Right(PokemonModel.fromJson(response.data));
      } else {
        return Left(CantGetPokemonFromPokeapiFailure());
      }
    } catch (e) {
      return Left(CantGetPokemonFromPokeapiFailure());
    }
  }
}
