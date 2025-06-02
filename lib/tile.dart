import 'package:flutter/cupertino.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/questions.dart';

class Tile {
  final List<Tile> adjacentTiles = List.empty(growable: true);
  final int questionsIndex;
  Offset offset;

  Tile(this.questionsIndex, this.offset);

  void addAdjacentTile(Tile tile) {
    adjacentTiles.add(tile);
    tile.adjacentTiles.add(this);
  }

  @override
  String toString() {
    return '$offset';
  }

  Future<bool> onLandedOn(BuildContext context, Player player) async {
    if (questionsIndex == -1) {
      return false;
    }

    player.pies[questionsIndex] = (await Questions.getRandomQuestion(questionsIndex).showQuestion(context)) ?? false;
    return false;
  }
}
