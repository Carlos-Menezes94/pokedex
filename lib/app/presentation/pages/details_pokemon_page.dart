import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex/app/presentation/controllers/pokemon_controller.dart';

import '../../../core/color_for_type.dart';
import '../widgets/base_stats_widget.dart';

class PokemonDetailsPage extends StatelessWidget {
  final String name;
  final String imageUrl;
  final Color color;
  final int index;

  const PokemonDetailsPage({
    Key? key,
    required this.name,
    required this.index,
    required this.color,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonController controller = GetIt.I.get<PokemonController>();

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name.substring(0, 1).toUpperCase() + name.substring(1),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Text(
              '#${index + 1}',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                height: 40,
                width: 40,
                color: color,
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ClipRect(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Column(
                    children: [
                      SizedBox(height: 76),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: controller
                            .store.listPokemons.value.results[index].types
                            .map((type) {
                          final color = ColorForType().getColorForType(type);
                          return Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  type.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8), // Espaço entre os containers
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "About",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      SizedBox(height: 38),
                      Text(
                        "In battle, it flaps its wings at great speed to release highly toxic dust into the air.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Base Stats",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BaseStatsWidget(
                              colorProgress: color,
                              baseStats: controller.store.listPokemons.value
                                  .results[index].baseStats,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Transform.scale(
              scale: 0.6,
              child: SizedBox(
                height: 24,
                width: 24,
                child: Image.network(imageUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
