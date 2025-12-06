import 'package:flutter/material.dart';

// Enum để định nghĩa các lựa chọn trong menu
// Việc dùng enum giúp code sạch và dễ quản lý hơn so với dùng String trực tiếp
enum MenuItem { docDuLieu, luuDuLieu, thoat }

class PopupMenuFeature extends StatelessWidget {
  const PopupMenuFeature({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Popup'),
        actions: <Widget>[
          // Widget PopupMenuButton
          PopupMenuButton<MenuItem>(
            // Khi một mục menu được chọn
            onSelected: (MenuItem result) {
              String message;
              switch (result) {
                case MenuItem.docDuLieu:
                  message = 'Đọc dữ liệu';
                  break;
                case MenuItem.luuDuLieu:
                  message = 'Lưu dữ liệu';
                  break;
                case MenuItem.thoat:
                  message = 'Thoát';
                  break;
              }

              // Hiển thị SnackBar với thông báo đã chọn
              // SnackBar hiển thị thông báo ở cuối màn hình (giống như trong ảnh)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Chọn: $message'),
                  duration: const Duration(
                    seconds: 2,
                  ), // Tùy chọn thời gian hiển thị
                ),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
              // Các mục menu tương ứng với Enum đã định nghĩa
              const PopupMenuItem<MenuItem>(
                value: MenuItem.docDuLieu,
                child: Text('Đọc dữ liệu'),
              ),
              const PopupMenuItem<MenuItem>(
                value: MenuItem.luuDuLieu,
                child: Text('Lưu dữ liệu'),
              ),
              const PopupMenuItem<MenuItem>(
                value: MenuItem.thoat,
                child: Text('Thoát'),
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text('Nội dung chính ở đây', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài Tập Menu Popup',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Dùng Material 3
        useMaterial3: true,
      ),
      // Import và sử dụng PopupMenuFeature ở đây
      home: const PopupMenuFeature(),
    );
  }
}
