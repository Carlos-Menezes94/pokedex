import 'package:dio/dio.dart';

import '../../../core/response.dart';
import '../api/pokemon_endpoints.dart';
import 'pokemon_data_source_abstract.dart';

class PokemonDataSourceImpl implements PokemonDataSourceAbstract {
  @override
  Future<DataSourceResponse> getPokemons(
      {required int page,required int limit}) async {
    final dio = Dio();
    final response =
        await dio.get(PokemonEndpoints().getPokemon(), queryParameters: {
      'offset': (page - 1) * limit,
      'limit': limit,
    });

    if (response.data != null) {
      return DataSourceResponse(success: true, data: response.data);
    } else {
      return DataSourceResponse(success: false, data: response.data);
    }
  }

  @override
  Future<DataSourceResponse> getImagesPokemons(
      {required List<String> urlsImages}) async {
    final dio = Dio();
    final responses =
        await Future.wait(urlsImages.map((url) => dio.get(url)).toList());

    final successResponses =
        responses.where((response) => response.statusCode == 200).toList();
    if (successResponses.isNotEmpty) {
      final firstResponse = successResponses.first;
      return DataSourceResponse(success: true, data: firstResponse.data);
    } else {
      return DataSourceResponse(success: false, data: responses);
    }
  }
}
