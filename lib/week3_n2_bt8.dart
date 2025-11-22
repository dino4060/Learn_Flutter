import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuyển động điều khiển bằng cử chỉ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: GestureControlPage(),
    );
  }
}

class GestureControlPage extends StatefulWidget {
  @override
  _GestureControlPageState createState() => _GestureControlPageState();
}

class _GestureControlPageState extends State<GestureControlPage> {
  double _xPosition = 100.0;
  double _yPosition = 500.0;

  void _updatePosition(DragUpdateDetails details) {
    setState(() {
      // Cập nhật vị trí theo cử chỉ kéo
      _xPosition += details.delta.dx;
      _yPosition += details.delta.dy;

      // Giới hạn không cho box ra ngoài màn hình
      // Lấy kích thước màn hình
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      final boxSize = 60.0;

      // Giới hạn x
      if (_xPosition < 0) _xPosition = 0;
      if (_xPosition > screenWidth - boxSize) {
        _xPosition = screenWidth - boxSize;
      }

      // Giới hạn y (trừ đi AppBar height)
      final appBarHeight =
          AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
      if (_yPosition < 0) _yPosition = 0;
      if (_yPosition > screenHeight - appBarHeight - boxSize) {
        _yPosition = screenHeight - appBarHeight - boxSize;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyển động điều khiển bằng cử chỉ'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned(
            left: _xPosition,
            top: _yPosition,
            child: GestureDetector(
              onPanUpdate: _updatePosition,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
