import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patriotic_pursuit/board_painter.dart';
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
  static const double tileSpacing = 65.0;

  final Tile middlePiece = Tile([...Questions.questions[0], ...Questions.questions[1], ...Questions.questions[2], ...Questions.questions[3],
    ...Questions.questions[4], ...Questions.questions[5]], const Offset(0, 0));
  final List<Tile> tiles = List.empty(growable: true);

  BoardScreen({super.key}) {
    tiles.add(middlePiece);

    // Straights
    List<Tile> endTiles = List.empty(growable: true);
    for (int i = 0; i < 6; i++) {
      Tile previousTile = middlePiece;
      num radians = pi / 3 * i;
      Offset offset = Offset(cos(radians), sin(radians)) * tileSpacing;
      for (int j = 0; j < 5; j++) {
        Tile tile = Tile(Questions.questions[j], offset * (j + 1));
        tile.addAdjacentTile(previousTile);
        previousTile = tile;
        tiles.add(tile);
      }
      endTiles.add(previousTile);
    }

    // Circle
    Tile? previousTile;
    for (int i = 0; i < 36; i++) {
      num radians = pi / 18 * i;
      Offset offset = Offset(cos(radians), sin(radians)) * tileSpacing * 6;
      Tile tile = Tile(Questions.questions[i % 6], offset);
      if (previousTile != null) {
        tile.addAdjacentTile(previousTile);
      }
      // Connect straights to the circle
      if (i % 6 == 0) {
        tile.addAdjacentTile(endTiles[i ~/ 6]);
      }
      tiles.add(tile);
      previousTile = tile;
    }

    // Connect last tile from the circle to the first tile in the circle
    previousTile!.addAdjacentTile(tiles[31]);
  }

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patriotic Pursuit'),
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: Image.asset('assets/images/board.png')
            ),
            CustomPaint(
              size: Size.infinite,
              painter: BoardPainter(widget.tiles),
            )
          ],
        ),
      )
    );
  }
}
