import '../../../core/response.dart';

abstract class PokemonDataSourceAbstract{
  Future <DataSourceResponse> getPokemons();

}