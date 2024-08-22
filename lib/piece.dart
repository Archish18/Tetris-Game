import 'dart:ui';

import 'package:tetris/game.dart';
import 'package:tetris/value.dart';

class Piece {
  Tetromino type;
  Piece({required this.type});

  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [
          -35,
          -25,
          -15,
          -14,
        ];
        break;
      case Tetromino.J:
        position = [
          -35,
          -25,
          -15,
          -16,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -3,
          -2,
          -1,
        ];
        break;
      case Tetromino.O:
        position = [
          -35,
          -34,
          -25,
          -24,
        ];
        break;
      case Tetromino.S:
        position = [
          -35,
          -34,
          -25,
          -24,
        ];
        break;
      case Tetromino.Z:
        position = [
          -45,
          -44,
          -34,
          -33,
        ];
        break;
      case Tetromino.T:
        position = [
          -35,
          -25,
          -15,
          -24,
        ];
        break;
      default:
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  int rotationState = 1;
  void rotatePiece() {
    List<int> newPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
        }

        break;

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[1] - rowLength-1,
              position[1],
              position[1] -1,
              position[1] +  1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[1]  + 1,
              position[1],
              position[1] - 1,
              position[1] +rowLength+ 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
        }

        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2*rowLength ,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[1] + rowLength ,
              position[1],
              position[1] - rowLength,
              position[1] - 2*rowLength,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = 0;
            break;
            }
        }

        break;
      case Tetromino.O:
          
      break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[0] -rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength+1 ,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[1] ,
              position[1]+1,
              position[1] + rowLength-1,
              position[1] + rowLength ,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength+ 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
        }

        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[0] + rowLength-2,
              position[1],
              position[2] + rowLength-1,
              position[3]  + 1,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[0] - rowLength+2,
              position[1],
              position[2] - rowLength+1,
              position[3]  - 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[0] + rowLength-2,
              position[1],
              position[2] + rowLength-1,
              position[3]  + 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength+1,
              position[3] - 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = 0;
            break;

            }
        }

        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            newPosition = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength ,
            ];
            if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }
          case 1:
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength ,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 2:
            newPosition = [
              position[1] - rowLength,
              position[1]-1,
              position[1] ,
              position[1] + rowLength ,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = (rotationState + 1) % 4;
            break;

            }

          case 3:
            newPosition = [
              position[2] - rowLength ,
              position[2]-1,
              position[2] ,
              position[2] + 1,
            ];
             if(piecepositionISvalid(newPosition)){
                position = newPosition;
                rotationState = 0;
            break;

            }
        }

        break;
      default:
    }
  }

  bool positionISvalid(int position) {
    int row = (position / rowLength).floor();
    int column = position % rowLength;

    if (row < 0 || column < 0 || gameBoard[row][column] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecepositionISvalid(List<int> piecePosition) {
    bool firstoccupied = false;
    bool lastOccupied = false;

    for (int pos in piecePosition) {
      if (!positionISvalid(pos)) {
        return false;
      }

      int column = pos % rowLength;

      if (column == 0) {
        firstoccupied = true;
      }

      if (column == rowLength - 1) {
        lastOccupied = true;
      }
    }
    return !(firstoccupied && lastOccupied);
  }
}


