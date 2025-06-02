import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patriotic_pursuit/board_painter.dart';
import 'package:patriotic_pursuit/middle_tile.dart';
import 'package:patriotic_pursuit/offset_util.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BoardScreen(),
    );
  }
}

class BoardScreen extends StatefulWidget {
  static const double tileSpacing = 57.0;
  static const double initialSpacing = 105.0;

  final Tile middlePiece = MiddleTile(const Offset(7, 0));
  final List<Tile> tiles = List.empty(growable: true);

  BoardScreen({super.key}) {
    Queue<int> categoryIndexes = Queue.of([5, 1, 2, 4, 3, 0, 2, 3, 5, 4, 1, 3, 4, 0, 5, 2, 4, 5, 1, 0, 3, 5, 0, 2, 1, 4, 0, 1, 3, 2, -1, 3, -1, 2, 5, -1, 4, -1, 4, -1, 3, 0, -1, 5, -1, 5, -1, 4, 1, -1, 0, -1, 0, -1, 5, 2, -1, 1, -1, 1, -1, 0, 3, -1, 2, -1, 2, -1, 1, 4, -1, 3]);

    // Make the board
    tiles.add(middlePiece);

    // Straights
    List<Tile> endTiles = List.empty(growable: true);
    for (int i = 0; i < 6; i++) {
      Tile previousTile = middlePiece;
      num radians = pi / 3 * i;
      Offset radialOffset = Offset(cos(radians), sin(radians));
      for (int j = 0; j < 5; j++) {
        Tile tile = Tile(categoryIndexes.removeFirst(), radialOffset * tileSpacing * (j as double) + radialOffset * initialSpacing + middlePiece.offset);
        tile.addAdjacentTile(previousTile);
        previousTile = tile;
        tiles.add(tile);
      }
      endTiles.add(previousTile);
    }

    // Circle
    Tile? previousTile;
    for (int i = 0; i < 48; i++) {
      if (i % 8 != 7) {
        num radians = pi / 24 * (i + (i % 8 == 0 ? 0 : 0.5));
        Offset radialOffset = Offset(cos(radians), sin(radians));
        Tile tile = Tile(categoryIndexes.removeFirst(), radialOffset * tileSpacing * 5.2 + radialOffset * initialSpacing + middlePiece.offset);
        if (previousTile != null) {
          tile.addAdjacentTile(previousTile);
        }
        // Connect straights to the circle
        if (i % 8 == 0) {
          tile.addAdjacentTile(endTiles[i ~/ 8]);
        }
        tiles.add(tile);
        previousTile = tile;
      }
    }

    // Connect last tile from the circle to the first tile in the circle
    previousTile!.addAdjacentTile(tiles[31]);
  }

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  final List<Player> _players = List.empty(growable: true);
  int _activePlayerIndex = 0;
  int _moves = 0;
  Set<Tile> _legalMoves = HashSet();
  bool _allowPieceMovement = false;
  String? winningPlayer;

  Future<int?> _getNumberOfPlayers() async {
    return showDialog<int>(
      context: context,
      builder: (BuildContext buildContext) {
        TextEditingController controller = TextEditingController();

        return AlertDialog(
          title: const Text('Enter the number of players'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, int.parse(controller.text)),
              child: const Text('Submit')
            )
          ],
        );
      }
    );
  }

  void _makePlayers(int numberOfPlayers) {
    for (int i = 0; i < numberOfPlayers; i++) {
      _players.add(Player(widget.middlePiece));
    }
    setState(() {});
  }

  void _getLegalMoves() {
    if (_moves != 0) {
      Player activePlayer = _players[_activePlayerIndex];
      _depthFirstSearch(_legalMoves, activePlayer.currentTile, _moves);
      _allowPieceMovement = true;
      setState(() {});
    }
  }

  void _depthFirstSearch(Set<Tile> tiles, Tile tile, int depth) {
    if (depth != 0) {
      for (Tile adjacentTile in tile.adjacentTiles) {
        if (depth == 1) {
          tiles.add(adjacentTile);
        }
        _depthFirstSearch(tiles, adjacentTile, depth - 1);
      }
    }
  }

  void _movePlayer(TapUpDetails details, Size size) async {
    if (_allowPieceMovement) {
      Tile? closestTile;
      double closestDistance = 10.0;
      for (Tile tile in _legalMoves) {
        double distance = (OffsetUtil.getScaledOffset(tile.offset, size) -
            details.localPosition).distance;
        if (distance < closestDistance) {
          closestDistance = distance;
          closestTile = tile;
        }
      }

      if (closestTile != null) {
        Player activePlayer = _players[_activePlayerIndex];

        setState(() {
          activePlayer.currentTile = closestTile!;
          _legalMoves = HashSet();
          _moves = 0;
        });

        if (await closestTile.onLandedOn(context, activePlayer)) {
          _players.removeAt(_activePlayerIndex);
          _showPlayerWinDialog(activePlayer.color.toString());
          _activePlayerIndex %= (_players.length + 1);
        } else {
          _activePlayerIndex = (_activePlayerIndex + 1) % _players.length;
        }

        _allowPieceMovement = false;

        setState(() {});
      }
    }
  }

  void _showPlayerWinDialog(String winningColor) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) => AlertDialog(
        title: Text('$winningColor has won the game!'),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patriotic Pursuit'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              Center(
                child: Image.asset('assets/images/board.png')
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_moves',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 100
                    ),
                  ),
                ),
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) => GestureDetector(
                  onTapUp: (TapUpDetails tapUpDetails) => _movePlayer(tapUpDetails, constraints.biggest),
                  child: CustomPaint(
                    size: constraints.biggest,
                    painter: BoardPainter(_legalMoves, _players),
                  ),
                ),
              ),
              // Container(color: Colors.pink,),
            ],
          ),
        ),
      ),
      floatingActionButton: _players.isEmpty ? FloatingActionButton(
        onPressed: () async => _makePlayers(await _getNumberOfPlayers() ?? 0),
        child: const Icon(Icons.play_arrow),
      ) : FloatingActionButton(
        onPressed: () {
          if (_moves == 0) {
            setState(() {
              _moves = Random().nextInt(6) + 1;
            });
            _getLegalMoves();
          }
        },
        child: const Icon(Icons.numbers),
      ),
    );
  }
}
