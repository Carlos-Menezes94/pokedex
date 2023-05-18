import 'package:dio/dio.dart';

import '../../../core/response.dart';
import '../api/pokemon_endpoints.dart';
import 'pokemon_data_source_abstract.dart';

class PokemonDataSourceImpl implements PokemonDataSourceAbstract {
  @override
  Future<DataSourceResponse> getPokemons() async {
    final dio = Dio();

    final response = await dio.get(PokemonEndpoints().getPokemon());

    if (response.data != null) {
      return DataSourceResponse(success: true, data: response.data);
    } else {
      return DataSourceResponse(success: false, data: response.data);
    }
  }
}
