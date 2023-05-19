import '../../../core/response.dart';

abstract class PokemonDataSourceAbstract {
  Future<DataSourceResponse> getPokemons(
      {required int page, required int limit});
}
