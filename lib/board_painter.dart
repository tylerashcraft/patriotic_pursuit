import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/tile.dart';

class BoardPainter extends CustomPainter {
  final List<Tile> _tiles;
  final List<Player> _players;
  final Paint _legalMovePaint = Paint()..color = Colors.blueAccent;

  BoardPainter(this._tiles, this._players);

  @override
  void paint(Canvas canvas, Size size) {
    Offset middle = Offset(size.width / 2, size.height / 2);

    for (Tile tile in _tiles) {
      canvas.drawCircle(_getScaledOffset(tile.offset, size) + middle, 5, _legalMovePaint);

      for (Tile adjacentTile in tile.adjacentTiles) {
        canvas.drawLine(_getScaledOffset(tile.offset, size) + middle, _getScaledOffset(adjacentTile.offset, size) + middle, _legalMovePaint);
      }
    }

    for (Player player in _players) {
      canvas.drawCircle(_getScaledOffset(player.currentTile.offset, size) + middle, 10, Paint()..color = player.color);
    }
  }

  Offset _getScaledOffset(Offset offset, Size size) {
    return Offset(offset.dx * size.width / 1728, offset.dy * size.height / 936);
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return true;
  }
}
