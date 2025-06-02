import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/tile.dart';
import 'package:patriotic_pursuit/offset_util.dart';

class BoardPainter extends CustomPainter {
  final List<Player> _players;
  final Paint _legalMovePaint = Paint()..color = Colors.black;
  final Paint _playerMiddlePaint = Paint()..color = const Color(0x4D000000);
  final Set<Tile> _tiles;

  BoardPainter(this._tiles, this._players);

  @override
  void paint(Canvas canvas, Size size) {
    for (Player player in _players) {
      Offset offset = OffsetUtil.getScaledOffset(player.currentTile.offset, size);

      canvas.drawCircle(offset, 20, Paint()..color = Colors.black);
      canvas.drawCircle(offset, 18, Paint()..color = player.color);
      canvas.drawCircle(offset, 15, _playerMiddlePaint);

      for (int i = 0; i < player.pies.length; i++) {
        if (player.pies[i]) {
          canvas.drawArc(Rect.fromCenter(center: offset, width: 28, height: 28), pi / 3 * i, pi / 3, true, Paint()..color = Player.colors[i]);
        }
      }
    }

    for (Tile tile in _tiles) {
      canvas.drawCircle(OffsetUtil.getScaledOffset(tile.offset, size), 9, _legalMovePaint);
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return oldDelegate._players != _players || oldDelegate._tiles != _tiles;
  }
}
