import 'package:either_dart/either.dart';
import 'package:pokedex/app/data/repositories_impl/pokemon_repository_impl.dart';

import '../../../core/failure.dart';
import '../../data/models/pokemon_model.dart';

class GetPokemonsListUseCase {
  GetPokemonsListUseCase({required this.repository});
  final PokemonRepositoryImpl repository;

  Future<Either<Failure, PokemonModel>> getPokemonsList() async {
    return repository.getPokemonsList();
  }
}
