import 'package:flutter/material.dart';

int rowLength = 10;
int columnLength = 15;
enum Direction{
  left,
  right,
  down, up,

}
enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T, 


}


const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Colors.orange,
  Tetromino.J: Colors.blue,
  Tetromino.I: Colors.pink,
  Tetromino.O: Colors.yellow,
  Tetromino.S: Colors.green,
  Tetromino.Z: Colors.red,
  Tetromino.T: Colors.purple,
};
