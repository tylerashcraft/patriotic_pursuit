import 'package:flutter/cupertino.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/questions.dart';
import 'package:patriotic_pursuit/tile.dart';

class MiddleTile extends Tile {
  MiddleTile(Offset offset) :
      super(-1, offset);

  @override
  Future<bool> onLandedOn(BuildContext context, Player player) async {
    return _playerHasAllPies(player.pies) && (await Questions.getRandomQuestion(player.lastPieCollected).showQuestion(context) ?? false);
  }

  bool _playerHasAllPies(List<bool> pies) {
    for (bool pie in pies) {
      if (pie == false) {
        return false;
      }
    }

    return true;
  }
}
