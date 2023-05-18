
import 'package:rx_notifier/rx_notifier.dart';

import '../../../core/app_state.dart';
import '../../../core/store.dart';
import '../../data/models/pokemon_model.dart';

class PokemonStore extends Store {
  RxNotifier<AppState> state = RxNotifier<AppState>(AppState());

  RxNotifier<PokemonModel?> listPokemons = RxNotifier<PokemonModel?>(null);
}
