import '../../../core/response.dart';

abstract class PokemonDataSourceAbstract {
  Future<DataSourceResponse> getPokemons(
      {required int page, required int limit});

  Future<DataSourceResponse> getImagesPokemons(
      {required List<String> urlsImages});
}
