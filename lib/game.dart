import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/value.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  columnLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameover = false;
  int highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
    startGame();
  }

  Future<void> _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    final storedHighScore = prefs.getInt('highScore');
    if (storedHighScore != null) {
      highScore = storedHighScore;
    }
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = const Duration(milliseconds: 500); // Start with a slower speed
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        clearLines();
        checkLanding();
        if (gameover == true) {
          timer.cancel();
          _saveHighScore();
          showGameOverDialog();
        }

        
        currentPiece.movePiece(Direction.down);

        // Increase speed as the score increases
        if (currentScore > 5 && currentScore <= 10) {
          frameRate = const Duration(milliseconds: 400); // Slightly faster
          timer.cancel();
          gameLoop(frameRate); // Restart game loop with updated speed
        } else if (currentScore > 10 && currentScore <= 15) {
          frameRate = const Duration(milliseconds: 300); // Faster
          timer.cancel();
          gameLoop(frameRate);
        } else if (currentScore > 15) {
          frameRate = const Duration(milliseconds: 200); // Even faster
          timer.cancel();
          gameLoop(frameRate);
        }
      });
    });
  }

  void _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (currentScore > highScore) {
      highScore = currentScore;
      prefs.setInt('highScore', highScore);
    }
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          gameover ? 'Game Over' : 'New High Score!',
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          gameover
              ? 'Your score is $currentScore'
              : 'Congratulations! You beat the high score with $currentScore!',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              resetGame();
              Navigator.pop(context);
            },
            child: const Text('Play Again', style: TextStyle(color: Colors.blueAccent)),
          )
        ],
      ),
    );
  }

  void resetGame() {
    gameBoard = List.generate(
      columnLength,
      (i) => List.generate(
        rowLength,
        (j) => null,
      ),
    );

    gameover = false;
    currentScore = 0;

    createNewPiece();

    startGame();
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int column = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        column -= 1;
      } else if (direction == Direction.right) {
        column += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= columnLength ||
          column < 0 ||
          column >= rowLength ||
          (row >= 0 && gameBoard[row][column] != null)) {
        return true;
      }
    }
    return false;
  }

  void checkLanding() {
    if (checkCollision(Direction.down)) {
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int column = currentPiece.position[i] % rowLength;
        if (row >= 0 &&
            column >= 0 &&
            row < columnLength &&
            column < rowLength) {
          gameBoard[row][column] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
    if (isgameOver()) {
      gameover = true;
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void dropPiece() {
    while (!checkCollision(Direction.down)) {
      setState(() {
        currentPiece.movePiece(Direction.down);
      });
    }
    checkLanding();
  }

  void clearLines() {
    for (int row = columnLength - 1; row >= 0; row--) {
      bool rowisFull = true;
      for (int column = 0; column < rowLength; column++) {
        if (gameBoard[row][column] == null) {
          rowisFull = false;
          break;
        }
      }
      if (rowisFull) {
        for (int r = row; r > 0; r--) {
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        gameBoard[0] = List.generate(row, (index) => null);

        currentScore += 10; // Increase score by 10 for each line cleared
      }
    }
  }

  bool isgameOver() {
    for (int column = 0; column < rowLength; column++) {
      if (gameBoard[0][column] != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(height: 30),
          // Score and High Score
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $currentScore',
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  'High Score: $highScore',
                  style: const TextStyle(color: Colors.orangeAccent, fontSize: 20),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Game Board
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * columnLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: rowLength),
              itemBuilder: (context, index) {
                int row = (index / rowLength).floor();
                int column = index % rowLength;
                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    color: currentPiece.color,
                    borderColor: Colors.white,
                  );
                } else if (gameBoard[row][column] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][column];
                  return Pixel(
                    color: tetrominoColors[tetrominoType],
                    borderColor: Colors.white,
                  );
                } else {
                  return Pixel(
                    color: Colors.grey[900],
                    borderColor: Colors.grey[700],
                  );
                }
              },
            ),
          ),
          // Controls
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios, size: 32),
                ),
                // Rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right, size: 32),
                ),
                // Right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_forward_ios, size: 32),
                ),
                // Drop
                IconButton(
                  onPressed: dropPiece,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_downward, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
