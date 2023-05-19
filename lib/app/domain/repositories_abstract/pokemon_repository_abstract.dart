import 'package:either_dart/either.dart';

import '../../../core/failure.dart';
import '../../data/models/pokemon_model.dart';

abstract class PokemonRepositoryAbstract {
  Future<Either<Failure, PokemonModel>> getPokemonsList(
      {required int page, required int limit});
}
