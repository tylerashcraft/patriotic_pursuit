import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/tile.dart';

class BoardPainter extends CustomPainter {
  final List<Tile> tiles;
  final Paint drawingPaint = Paint()..color = Colors.blueAccent;

  BoardPainter(this.tiles);

  @override
  void paint(Canvas canvas, Size size) {
    Offset middle = Offset(size.width / 2, size.height / 2);

    for (Tile tile in tiles) {
      canvas.drawCircle(tile.offset + middle, 5, drawingPaint);
      for (Tile adjacentTile in tile.adjacentTiles) {
        canvas.drawLine(tile.offset + middle, adjacentTile.offset + middle, drawingPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
