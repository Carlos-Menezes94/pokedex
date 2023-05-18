
import '../../../core/app_state.dart';
import '../../../core/controller.dart';
import '../../domain/use_cases/get_pokemons_list_use_case.dart';
import '../stores/pokemon_store.dart';

class PokemonController extends Controller {
  final PokemonStore store;
  final GetPokemonsListUseCase getPokemonsListUseCase;

  PokemonController(
      {required this.store, required this.getPokemonsListUseCase});

  Future<void> getPokemonsList() async {
    store.state.value = AppState.loading();

    final response = await getPokemonsListUseCase.getPokemonsList();

    response.fold((failure) {
      store.state.value = AppState.error();
    }, (userAccountModel) {
      store.listPokemons.value = userAccountModel;
      store.state.value = AppState.success();
    });
  }
}
