import 'package:flutter/material.dart';

import 'tetris/tetris_game.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: TetrisGame(),
  ));
}
