import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patriotic_pursuit/board_painter.dart';
import 'package:patriotic_pursuit/player.dart';
import 'package:patriotic_pursuit/questions.dart';
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

  final Tile middlePiece = Tile([...Questions.questions[0], ...Questions.questions[1], ...Questions.questions[2], ...Questions.questions[3],
    ...Questions.questions[4], ...Questions.questions[5]], const Offset(7, 0));
  final List<Tile> tiles = List.empty(growable: true);

  BoardScreen({super.key}) {
    // Make the board
    tiles.add(middlePiece);

    // Straights
    List<Tile> endTiles = List.empty(growable: true);
    for (int i = 0; i < 6; i++) {
      Tile previousTile = middlePiece;
      num radians = pi / 3 * i;
      Offset radialOffset = Offset(cos(radians), sin(radians));
      for (int j = 0; j < 5; j++) {
        Tile tile = Tile(Questions.questions[j], radialOffset * tileSpacing * (j as double) + radialOffset * initialSpacing + middlePiece.offset);
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
        Tile tile = Tile(Questions.questions[i % 6], radialOffset * tileSpacing * 5.2 + radialOffset * initialSpacing + middlePiece.offset);
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

  Future<int?> _getNumberOfPlayers() async {
    return showDialog<int>(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: const Text('Enter the number of players'),
          content: TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patriotic Pursuit'),
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                Center(
                  child: Image.asset('assets/images/board.png')
                ),
                CustomPaint(
                  size: constraints.biggest,
                  painter: BoardPainter(widget.tiles, _players),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _makePlayers(await _getNumberOfPlayers() ?? 0)
      ),
    );
  }
}
