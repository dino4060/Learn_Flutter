import 'package:flutter/material.dart';

class TabMenuFeature extends StatelessWidget {
  const TabMenuFeature({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Dùng DefaultTabController để quản lý trạng thái của các tab
    return DefaultTabController(
      length: 3, // Tổng cộng 3 tab: Trang chủ, Nhân viên, Cài đặt
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tab Menu Demo'),
          centerTitle: true,
          // 2. Định nghĩa TabBar (các nút bấm)
          bottom: const TabBar(
            tabs: <Widget>[
              // Tab 1: Trang chủ
              Tab(icon: Icon(Icons.home), text: 'Trang chủ'),
              // Tab 2: Nhân viên (đang được chọn trong hình)
              Tab(icon: Icon(Icons.people), text: 'Nhân viên'),
              // Tab 3: Cài đặt
              Tab(icon: Icon(Icons.settings), text: 'Cài đặt'),
            ],
          ),
        ),
        // 3. Định nghĩa nội dung tương ứng với các tab
        body: const TabBarView(
          children: <Widget>[
            // Nội dung Tab 1 (Trang chủ)
            Center(
              child: Text('Màn hình Trang chủ', style: TextStyle(fontSize: 18)),
            ),
            // Nội dung Tab 2 (Nhân viên)
            Center(
              child: Text('Màn hình Nhân viên', style: TextStyle(fontSize: 18)),
            ),
            // Nội dung Tab 3 (Cài đặt)
            Center(
              child: Text('Màn hình Cài đặt', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài Tập Tab Menu',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Import và sử dụng TabMenuFeature làm trang home
      home: const TabMenuFeature(),
    );
  }
}
