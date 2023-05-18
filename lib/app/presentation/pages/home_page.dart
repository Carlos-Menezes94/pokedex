import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../core/app_state.dart';
import '../controllers/pokemon_controller.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  PokemonController controller = GetIt.I.get<PokemonController>();

  @override
  void initState() {
    super.initState();
    controller.getPokemonsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: ValueListenableBuilder<AppState>(
        valueListenable: controller.store.state,
        builder: (context, value, _) {
          if (value.hasSuccess()) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: controller.store.listPokemons.value!.results.length,
              itemBuilder: (context, index) {
                String name =
                    controller.store.listPokemons.value!.results[index].name;
                String url =
                    controller.store.listPokemons.value!.results[index].url;

                int id = int.parse(url.split('/').reversed.toList()[1]);

                String imageUrl =
                    'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

                return Card(
                  child: Column(
                    children: [
                      Image.network(imageUrl),
                      Text(name),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
