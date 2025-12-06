import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truyền dữ liệu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Screen1(),
    );
  }
}

// Màn hình 1
class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _navigateToScreen2() {
    // Kiểm tra dữ liệu trước khi chuyển
    if (_idController.text.isEmpty || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')));
      return;
    }

    // Chuyển sang màn hình 2 và truyền dữ liệu
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screen2(
          studentId: _idController.text,
          studentName: _nameController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Màn hình 1'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField Mã sinh viên
            Text(
              'Mã sinh viên',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                hintText: 'Nhập mã sinh viên',
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),

            SizedBox(height: 20),

            // TextField Họ tên
            Text(
              'Họ tên',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Nhập họ và tên',
                hintStyle: TextStyle(color: Colors.grey[400]),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple[200]!),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.purple),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Nút Thực hiện
            Center(
              child: ElevatedButton(
                onPressed: _navigateToScreen2,
                child: Text(
                  'Thực hiện',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.purple, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình 2
class Screen2 extends StatelessWidget {
  final String studentId;
  final String studentName;

  // Constructor nhận dữ liệu từ màn hình 1
  Screen2({required this.studentId, required this.studentName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Màn hình 2'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hiển thị thông tin nhận được
            Text(
              'Mã SV: $studentId',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Text(
              'Họ tên: $studentName',
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 40),

            // Nút Trở về
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Trở về',
                style: TextStyle(color: Colors.purple, fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.purple, width: 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
