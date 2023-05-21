import 'package:dio/dio.dart';
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
  Future<Either<Failure, PokemonModel>> getPokemonsList(
      {required int page, required int limit}) async {
    final dio = Dio();

    try {
      final response = await dataSource.getPokemons(limit: limit, page: page);

      if (response.success) {
        final data = response.data;
        final results = data['results'] as List<dynamic>;
        final pokemonUrls =
            results.map((result) => result['url'] as String).toList();

        final List<Future<PokemonResult>> pokemonFutures = [];
        for (final url in pokemonUrls) {
          pokemonFutures.add(dataSource.getImagesPokemons(urlsImages: [url])
              .then((pokemonResponse) {
            if (pokemonResponse.success) {
              final pokemonData = pokemonResponse.data;
              return PokemonResult.fromJson(pokemonData);
            } else {
              throw CantGetPokemonFromPokeapiFailure();
            }
          }));
        }

        final pokemonResponses = await Future.wait(pokemonFutures);

        final pokemons = pokemonResponses.toList();
        final pokemonModel = PokemonModel(results: pokemons);

        return Right(pokemonModel);
      } else {
        return Left(CantGetPokemonFromPokeapiFailure());
      }
    } catch (error) {
      return Left(CantGetPokemonFromPokeapiFailure());
    }
  }
}
