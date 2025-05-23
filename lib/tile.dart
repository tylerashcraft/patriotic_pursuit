import 'dart:ui';

import 'package:patriotic_pursuit/question.dart';

class Tile {
  final List<Tile> adjacentTiles = List.empty(growable: true);
  final List<Question> _questions;
  Offset offset;

  Tile(this._questions, this.offset);

  void addAdjacentTile(Tile tile) {
    adjacentTiles.add(tile);
    tile.adjacentTiles.add(this);
  }
}
