import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Square',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSquarePage(),
    );
  }
}

class AnimatedSquarePage extends StatefulWidget {
  @override
  _AnimatedSquarePageState createState() => _AnimatedSquarePageState();
}

class _AnimatedSquarePageState extends State<AnimatedSquarePage> {
  Color _squareColor = Colors.green;
  final Random _random = Random();

  // Hàm tạo màu ngẫu nhiên
  Color _getRandomColor() {
    return Color.fromRGBO(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      1,
    );
  }

  // Hàm xử lý khi click
  void _changeColor() {
    setState(() {
      _squareColor = _getRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Square'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: GestureDetector(
          onTap: _changeColor,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: _squareColor,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}
