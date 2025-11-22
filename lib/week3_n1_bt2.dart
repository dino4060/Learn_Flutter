import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimpleDialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _backgroundColor = Colors.white; // Màu nền mặc định

  // Hàm để hiển thị SimpleDialog
  void _showColorDialog(BuildContext context) async {
    String? selectedColor = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Chọn màu'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Đỏ');
              },
              child: Text('Đỏ'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Xanh');
              },
              child: Text('Xanh'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 'Vàng');
              },
              child: Text('Vàng'),
            ),
          ],
        );
      },
    );

    if (selectedColor != null) {
      // Thay đổi màu nền dựa trên lựa chọn
      setState(() {
        switch (selectedColor) {
          case 'Đỏ':
            _backgroundColor = Colors.red[100]!;
            break;
          case 'Xanh':
            _backgroundColor = Colors.blue[100]!;
            break;
          case 'Vàng':
            _backgroundColor = Colors.yellow[100]!;
            break;
        }
      });

      // Hiển thị thông báo chọn màu
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn đã chọn màu: $selectedColor')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bài tập 2: SimpleDialog')),
      body: Container(
        color: _backgroundColor, // Áp dụng màu nền đã chọn
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              _showColorDialog(context); // Hiển thị SimpleDialog
            },
            child: Text('Chọn màu', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple, // Màu nền nút
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bo góc nút
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
