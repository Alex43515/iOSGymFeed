import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class TetrisGame extends StatefulWidget {
  const TetrisGame({super.key});

  @override
  State<TetrisGame> createState() => _TetrisGameState();
}

class _TetrisGameState extends State<TetrisGame> {
  static const int rows = 20;
  static const int cols = 10;
  static const Duration tickRate = Duration(milliseconds: 500);

  late List<List<int>> board;
  Timer? _timer;
  Piece? _current;
  final Random _rand = Random();

  @override
  void initState() {
    super.initState();
    _resetBoard();
    _spawnPiece();
    _timer = Timer.periodic(tickRate, (_) => _tick());
  }

  void _resetBoard() {
    board = List.generate(rows, (_) => List.filled(cols, 0));
  }

  void _spawnPiece() {
    _current = Piece.random(_rand, cols ~/ 2, 0);
  }

  bool _isValidPosition(Piece piece) {
    for (final p in piece.cells) {
      final x = piece.x + p.dx;
      final y = piece.y + p.dy;
      if (x < 0 || x >= cols || y < 0 || y >= rows) return false;
      if (board[y][x] != 0) return false;
    }
    return true;
  }

  void _placePiece(Piece piece) {
    for (final p in piece.cells) {
      final x = piece.x + p.dx;
      final y = piece.y + p.dy;
      if (y >= 0 && y < rows && x >= 0 && x < cols) {
        board[y][x] = piece.type;
      }
    }
  }

  void _removeLines() {
    board.removeWhere((row) => row.every((c) => c != 0));
    while (board.length < rows) {
      board.insert(0, List.filled(cols, 0));
    }
  }

  void _tick() {
    setState(() {
      if (_current == null) return;
      final moved = _current!.copyWith(y: _current!.y + 1);
      if (_isValidPosition(moved)) {
        _current = moved;
      } else {
        _placePiece(_current!);
        _removeLines();
        _spawnPiece();
        if (!_isValidPosition(_current!)) {
          _resetBoard();
        }
      }
    });
  }

  void _move(int dx) {
    setState(() {
      if (_current == null) return;
      final moved = _current!.copyWith(x: _current!.x + dx);
      if (_isValidPosition(moved)) {
        _current = moved;
      }
    });
  }

  void _rotate() {
    setState(() {
      if (_current == null) return;
      final rotated = _current!.rotate();
      if (_isValidPosition(rotated)) {
        _current = rotated;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: cols / rows,
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  border: Border.all(color: Colors.white),
                ),
                child: Stack(
                  children: [
                    for (int y = 0; y < rows; y++)
                      for (int x = 0; x < cols; x++)
                        if (board[y][x] != 0)
                          _buildBlock(x, y, board[y][x]),
                    if (_current != null)
                      for (final p in _current!.cells)
                        _buildBlock(_current!.x + p.dx, _current!.y + p.dy, _current!.type,
                            ghost: !_isValidPosition(_current!)),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => _move(-1),
                icon: const Icon(Icons.arrow_left, color: Colors.white),
              ),
              IconButton(
                onPressed: _rotate,
                icon: const Icon(Icons.rotate_right, color: Colors.white),
              ),
              IconButton(
                onPressed: () => _move(1),
                icon: const Icon(Icons.arrow_right, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBlock(int x, int y, int type, {bool ghost = false}) {
    final colors = [
      Colors.transparent,
      Colors.cyan,
      Colors.blue,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.purple,
      Colors.red,
    ];
    return Positioned(
      left: x * (MediaQuery.of(context).size.width - 40) / cols,
      top: y * (MediaQuery.of(context).size.width - 40) / cols,
      width: (MediaQuery.of(context).size.width - 40) / cols,
      height: (MediaQuery.of(context).size.width - 40) / cols,
      child: Container(
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: ghost ? colors[type].withOpacity(0.3) : colors[type],
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class Piece {
  final int type;
  final int x;
  final int y;
  final int rotation;

  Piece(this.type, this.x, this.y, this.rotation);

  List<Point<int>> get cells {
    final shape = _shapes[type]![rotation % _shapes[type]!.length];
    return shape.map((p) => Point(p[0], p[1])).toList();
  }

  Piece copyWith({int? x, int? y, int? rotation}) {
    return Piece(type, x ?? this.x, y ?? this.y, rotation ?? this.rotation);
  }

  Piece rotate() => copyWith(rotation: rotation + 1);

  static Piece random(Random rand, int x, int y) {
    final type = 1 + rand.nextInt(7);
    return Piece(type, x, y, 0);
  }

  static final Map<int, List<List<List<int>>>> _shapes = {
    1: [
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [0, 2]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [2, 0]
      ],
    ],
    2: [
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [1, -1]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [-1, -1]
      ],
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [-1, 1]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [1, 1]
      ],
    ],
    3: [
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [-1, -1]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [-1, 1]
      ],
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [1, 1]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [1, -1]
      ],
    ],
    4: [
      [
        [0, 0],
        [0, 1],
        [1, 0],
        [1, 1]
      ],
    ],
    5: [
      [
        [0, 0],
        [0, 1],
        [1, -1],
        [1, 0]
      ],
      [
        [-1, 0],
        [0, 0],
        [0, 1],
        [1, 1]
      ],
    ],
    6: [
      [
        [0, 0],
        [0, 1],
        [-1, 1],
        [1, 0]
      ],
      [
        [0, 0],
        [-1, 0],
        [0, 1],
        [1, 1]
      ],
    ],
    7: [
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [1, 0]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [0, 1]
      ],
      [
        [0, -1],
        [0, 0],
        [0, 1],
        [-1, 0]
      ],
      [
        [-1, 0],
        [0, 0],
        [1, 0],
        [0, -1]
      ],
    ],
  };
}

