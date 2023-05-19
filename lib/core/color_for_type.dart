import 'package:flutter/material.dart';

class ColorForType {
  Color getColorForType(String type) {
    switch (type) {
      case 'normal':
        return Colors.grey;
      case 'fire':
        return Colors.orange;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow;
      case 'ice':
        return Colors.lightBlue;
      case 'fighting':
        return Colors.red;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'flying':
        return Colors.lightBlue;
      case 'psychic':
        return Colors.pink;
      case 'bug':
        return Colors.lightGreen;
      case 'rock':
        return Colors.brown;
      case 'ghost':
        return Colors.deepPurple;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.black;
      case 'steel':
        return Colors.grey;
      case 'fairy':
        return Colors.pink;
      default:
        return Colors.grey;
    }
  }
}
