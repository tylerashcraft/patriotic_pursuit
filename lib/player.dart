import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/tile.dart';

class Player {
  static const List<Color> colors = [
    Colors.orange,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.green
  ];
  static int _numberOfPlayers = 0;
  final List<bool> pies = List.filled(6, false);
  Tile currentTile;
  Color color;
  int lastPieCollected = -1;

  Player(this.currentTile) :
      color = colors[_numberOfPlayers++];

  void addPie(int index) {
    pies[index] = true;
    lastPieCollected = index;
  }
}
