import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../core/app_state.dart';
import '../../../core/assset_loader.dart';
import '../../../core/color_for_type.dart';
import '../controllers/pokemon_controller.dart';
import 'details_pokemon_page.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({Key? key}) : super(key: key);

  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  PokemonController pokemonController = GetIt.I.get<PokemonController>();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pokemonController.store.isLoadingPokeball = true;
    pokemonController.getPokemonsList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pokemonController.loadMorePokemons();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PokemonController controller = GetIt.I.get<PokemonController>();

    return Scaffold(
      backgroundColor: Color(0xFFDC0A2D),
      body: ValueListenableBuilder<AppState>(
        valueListenable: controller.store.state,
        builder: (context, value, child) {
          if (pokemonController.store.isLoadingPokeball!) {
            return Center(
              child: SizedBox(
                child: Image.asset(AssetLoader.animationPokeball),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                ),
                SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Container(
                          color: Colors.transparent,
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            AssetLoader.imgPokeball,
                            color: Colors.white,
                          )),
                      SizedBox(width: 16),
                      Text(
                        'Pokédex',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: pokemonController.getPokemonsList,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: GridView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        itemCount:
                            controller.store.listPokemons.value.results.length +
                                1,
                        itemBuilder: (context, index) {
                          if (index <
                              controller
                                  .store.listPokemons.value.results.length) {
                            controller.store.idText.value =
                                (index + 1).toString().padLeft(3, '0');

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PokemonDetailsPage(
                                      index: index,
                                      color: ColorForType().getColorForType(
                                          controller.store.listPokemons.value
                                              .results[index].types.first),
                                      name: controller.store.listPokemons.value
                                          .results[index].name,
                                      imageUrl: controller.store.listPokemons
                                          .value.results[index].imageUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 4,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Image.network(
                                            controller.store.listPokemons.value
                                                .results[index].imageUrl,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            controller.store.listPokemons.value
                                                .results[index].name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          '#${controller.store.idText.value}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  if (value.isLoading()) {
                    // Indicador de progresso circular
                    return Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return Container();
                })
              ],
            ),
          );
        },
      ),
    );
  }
}
