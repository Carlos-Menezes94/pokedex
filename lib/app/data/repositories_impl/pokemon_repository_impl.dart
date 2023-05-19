
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
      {required int page,required int limit }) async {
    final dio = Dio();

    try {
      final response = await dataSource.getPokemons(limit: limit, page: page);

      if (response.success) {
        final data = response.data;
        final results = data['results'] as List<dynamic>;
        final pokemonUrls =
            results.map((result) => result['url'] as String).toList();

        final pokemonResponses = await Future.wait(
          pokemonUrls.map((url) => dio.get(url)).toList(),
        );

        final pokemons = <PokemonResult>[];

        for (final pokemonResponse in pokemonResponses) {
          if (pokemonResponse.statusCode == 200) {
            final pokemonData = pokemonResponse.data;
            final pokemonTypes = pokemonData['types'] as List<dynamic>;
            final pokemonStats = pokemonData['stats'] as List<dynamic>;

            final pokemonResult = PokemonResult(
              name: pokemonData['name'],
              imageUrl: pokemonData['sprites']['other']['official-artwork']
                  ['front_default'],
              types: pokemonTypes
                  .map((type) => type['type']['name'] as String)
                  .toList(),
              baseStats: pokemonStats
                  .map((stat) => {
                        'name': stat['stat']['name'],
                        'value': stat['base_stat'],
                      })
                  .toList(),
            );

            pokemons.add(pokemonResult);
          }
        }
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
