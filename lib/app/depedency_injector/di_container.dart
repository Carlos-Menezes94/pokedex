import 'package:get_it/get_it.dart';
import '../data/datasources/pokemon_data_source_impl.dart';
import '../data/repositories_impl/pokemon_repository_impl.dart';
import '../domain/use_cases/get_pokemons_list_use_case.dart';
import '../presentation/controllers/pokemon_controller.dart';
import '../presentation/stores/pokemon_store.dart';

class DiContainer {
  static void start() {
    GetIt getIt = GetIt.instance;

    getIt.registerFactory(() => PokemonDataSourceImpl());
    getIt.registerFactory(() => PokemonRepositoryImpl(
          dataSource: GetIt.I.get<PokemonDataSourceImpl>(),
        ));
    getIt.registerFactory(() => GetPokemonsListUseCase(
        repository: GetIt.I.get<PokemonRepositoryImpl>()));

    getIt.registerFactory(
      () => PokemonController(),
    );

    getIt.registerSingleton(PokemonStore());
  }
}
