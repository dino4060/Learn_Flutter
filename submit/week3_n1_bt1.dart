import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlertDialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // Hàm để hiển thị AlertDialog
  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.purple[50],
          title: Text('Xác nhận', style: TextStyle(color: Colors.purple[700])),
          content: Text(
            'Bạn có chắc chắn muốn xóa không?',
            style: TextStyle(color: Colors.purple[500]),
          ),
          actions: <Widget>[
            // Nút Hủy
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Hủy', style: TextStyle(color: Colors.purple[700])),
            ),
            // Nút Xóa (chỉ đóng dialog)
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
              },
              child: Text('Xóa', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bài tập 1: AlertDialog')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showConfirmDialog(context); // Hiển thị AlertDialog
          },
          child: Text('Xóa', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Màu nền nút
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bo góc nút
            ),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
