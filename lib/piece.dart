import 'package:patriotic_pursuit/tile.dart';

class Piece {
  final List<bool> _pies = List.filled(6, false);
  Tile _currentTile;

  Piece(this._currentTile);
}
