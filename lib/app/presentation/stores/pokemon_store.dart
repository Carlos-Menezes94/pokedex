import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../../core/app_state.dart';
import '../../../core/store.dart';
import '../../data/models/pokemon_model.dart';

class PokemonStore extends Store {
  RxNotifier<AppState> state = RxNotifier<AppState>(AppState());
  RxNotifier<String> idText = RxNotifier<String>("");

  ValueNotifier<PokemonModel> listPokemons =
      ValueNotifier<PokemonModel>(PokemonModel(results: []));
  int? id;
  String? imageUrl;
  List<String>? imageUrls;
  int page = 1;
  List<String>? typeColor;
  bool? isLoadingPokeball;
}
