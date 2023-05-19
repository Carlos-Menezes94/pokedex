import 'package:flutter/material.dart';

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
    return Container(
      height: 200, // Defina a altura desejada aqui
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: baseStats.map((stat) {
                      final statName = stat['name'] as String;
                      final statValue = stat['value'] as int;
                      final displayText = statTexts[statName] ?? statName;
                      return Column(
                        children: [
                    
                          Row(
                            children: [
                              Text(
                                '$displayText:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: LinearProgressIndicator(
                                  color: colorProgress,
                                  value: statValue /
                                      300, // Normalizing value to be between 0 and 1
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
            ),
          ),
        ],
      ),
    );
  }
}
