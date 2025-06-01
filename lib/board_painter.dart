import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/tile.dart';
import 'package:patriotic_pursuit/offset_util.dart';

class BoardPainter extends CustomPainter {
  final List<Player> _players;
  final Paint _legalMovePaint = Paint()..color = Colors.black;
  final Set<Tile> _tiles;

  BoardPainter(this._tiles, this._players);

  @override
  void paint(Canvas canvas, Size size) {
    for (Player player in _players) {
      canvas.drawCircle(OffsetUtil.getScaledOffset(player.currentTile.offset, size), 20, Paint()..color = Colors.black);
      canvas.drawCircle(OffsetUtil.getScaledOffset(player.currentTile.offset, size), 18, Paint()..color = player.color);
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
