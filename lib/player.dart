import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/tile.dart';

class Player {
  static const List<Color> _colors = [
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple
  ];
  static int _numberOfPlayers = 0;
  final List<bool> _pies = List.filled(6, false);
  Tile currentTile;
  Color color;

  Player(this.currentTile) :
      color = _colors[_numberOfPlayers++];
}
