import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/pokemon_controller.dart';

class BaseStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> baseStats;
  final Color colorIndicatorTypePokemon;

  final Map<String, String> statTexts = {
    'hp': 'HP',
    'attack': 'ATK',
    'defense': 'DEF',
    'special-attack': 'SATK',
    'special-defense': 'SDEF',
    'speed': 'SPD',
  };

  BaseStatsWidget({
    Key? key,
    required this.baseStats,
    required this.colorIndicatorTypePokemon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonController controller = GetIt.I.get<PokemonController>();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: baseStats.map((stat) {
              final statName = stat['name'] as String;
              controller.store.displayText.value =
                  statTexts[statName] ?? statName;
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${controller.store.displayText.value}:',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: colorIndicatorTypePokemon),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Container(
          width: 1,
          color: Colors.grey,
          margin: EdgeInsets.symmetric(horizontal: 11),
        ),
        Expanded(
          flex: 9,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: baseStats.map((stat) {
              final statName = stat['name'] as String;
              final statValue = stat['value'] as int;
              controller.store.displayText.value =
                  statTexts[statName] ?? statName;
              return Row(
                children: [
                  Text('$statValue'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: LinearProgressIndicator(
                        color: colorIndicatorTypePokemon,
                        backgroundColor:
                            colorIndicatorTypePokemon.withOpacity(0.3),
                        value: statValue / 300,
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
