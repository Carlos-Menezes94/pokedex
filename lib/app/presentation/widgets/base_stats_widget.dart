import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/pokemon_controller.dart';

class BaseStatsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> baseStats;
  final Color colorProgress;

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
    required this.colorProgress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PokemonController controller = GetIt.I.get<PokemonController>();

    return Row(
      children: [
        Expanded(
          child: Column(
            children: baseStats.map((stat) {
              final statName = stat['name'] as String;
              final statValue = stat['value'] as int;
              controller.store.displayText.value =
                  statTexts[statName] ?? statName;
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${controller.store.displayText.value}:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: baseStats.map((stat) {
              final statName = stat['name'] as String;
              final statValue = stat['value'] as int;
              controller.store.displayText.value =
                  statTexts[statName] ?? statName;
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          color: colorProgress,
                          backgroundColor: colorProgress.withOpacity(0.3),
                          value: statValue / 300,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('$statValue'),
                    ],
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
