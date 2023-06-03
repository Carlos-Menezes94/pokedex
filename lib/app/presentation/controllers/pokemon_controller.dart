import '../../../core/app_state.dart';
import '../../../core/controller.dart';
import '../../data/models/pokemon_model.dart';
import '../../domain/use_cases/get_pokemons_list_use_case.dart';
import '../stores/pokemon_store.dart';

class PokemonController extends Controller {
  final PokemonStore store;
  final GetPokemonsListUseCase _getPokemonsListUseCase;

  PokemonController(
      {required this.store,
      required GetPokemonsListUseCase getPokemonsListUseCase})
      : _getPokemonsListUseCase = getPokemonsListUseCase;

  Future<void> getPokemonsList() async {
    store.state.value = AppState.loading();

    final response = await _getPokemonsListUseCase.getPokemonsList(
        page: store.page, limit: 15);

    response.fold(
      (failure) {
        store.state.value = AppState.error();
      },
      (dataPokedexForGetPokemons) {
        store.listPokemons1.value = dataPokedexForGetPokemons;
        store.listPokemonsView.value = store.listPokemons1.value;
        store.isLoadingPokeball = false;
        store.state.value = AppState.success();
      },
    );
  }

  Future<void> loadMorePokemons() async {
    store.page = (store.listPokemonsView.value.results.length ~/ 15) + 1;
    store.state.value = AppState.loading();
    final response = await _getPokemonsListUseCase.getPokemonsList(
        page: store.page, limit: 15);

    response.fold(
      (failure) {
        store.state.value = AppState.error();
      },
      (pokedexData) {
        store.listPokemons.value.results.addAll(pokedexData.results);
        store.listPokemonsView.value.results =
            store.listPokemonsView.value.results;
        store.isLoadingPokeball = false;
        store.state.value = AppState.success();
      },
    );
  }

  void searchPokemon() {
    store.state.value = AppState.loading();

    List<PokemonResult> testee = [];
    testee = store.listPokemons1.value.results;

    if (store.searchText.value.isNotEmpty) {
      final teste = store.listPokemonsView.value.results
          .where((pokemon) =>
              pokemon.name.contains(store.searchText.value.toLowerCase()))
          .toList();
      store.listPokemonsView.value.results = teste;
      store.state.value = AppState.success();
    } else {
      getPokemonsList();
      store.state.value = AppState.success();
    }
  }
}
