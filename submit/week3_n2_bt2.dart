import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Hoạt hình ngầm')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Implicit animation với AnimatedContainer
              AnimatedContainerExample(),
              SizedBox(height: 20),
              // Implicit animation với AnimatedOpacity
              AnimatedOpacityExample(),
              SizedBox(height: 20),
              // Implicit animation với AnimatedPadding
              AnimatedPaddingExample(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget thực hiện implicit animation với AnimatedContainer
class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isEnlarged = false;
  Color _color = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isEnlarged = !_isEnlarged;
          _color = _isEnlarged ? Colors.red : Colors.blue;
        });
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        width: _isEnlarged ? 200 : 100,
        height: _isEnlarged ? 200 : 100,
        color: _color,
        child: Center(
          child: Text(
            _isEnlarged ? 'Phóng to' : 'Bình thường',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Widget thực hiện implicit animation với AnimatedOpacity
class AnimatedOpacityExample extends StatefulWidget {
  @override
  _AnimatedOpacityExampleState createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  bool _isVisible = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isVisible = !_isVisible;
        });
      },
      child: AnimatedOpacity(
        duration: Duration(seconds: 1),
        opacity: _isVisible ? 1.0 : 0.0,
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Center(
            child: Text('Click để bật', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

// Widget thực hiện implicit animation với AnimatedPadding
class AnimatedPaddingExample extends StatefulWidget {
  @override
  _AnimatedPaddingExampleState createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  double _paddingValue = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _paddingValue = _paddingValue == 0 ? 20 : 0;
        });
      },
      child: AnimatedPadding(
        duration: Duration(seconds: 1),
        padding: EdgeInsets.all(_paddingValue),
        child: Container(
          width: 200,
          height: 200,
          color: Colors.blue,
          child: Center(
            child: Text(
              'Click vào để chuyển đổi',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
