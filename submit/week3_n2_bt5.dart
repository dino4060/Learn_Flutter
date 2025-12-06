import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tương tác ảnh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ImageInteractionPage(),
    );
  }
}

class ImageInteractionPage extends StatefulWidget {
  @override
  _ImageInteractionPageState createState() => _ImageInteractionPageState();
}

class _ImageInteractionPageState extends State<ImageInteractionPage> {
  bool _showImage = false;

  void _toggleImage() {
    setState(() {
      _showImage = !_showImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tương tác ảnh'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị ảnh nếu _showImage = true
            if (_showImage)
              Padding(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/iphone-air.webp',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),

            SizedBox(height: 20),

            // Nút Nhìn
            ElevatedButton(
              onPressed: _toggleImage,
              child: Text(
                _showImage ? 'Ẩn' : 'Nhìn',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
