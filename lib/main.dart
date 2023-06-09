import 'package:flutter/material.dart';

import 'app/depedency_injector/di_container.dart';
import 'app/presentation/pages/pokemon_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiContainer.start();

  runApp(const MaterialApp(
    home: PokemonListPage(),
  ));
}
