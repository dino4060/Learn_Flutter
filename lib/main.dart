import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Bài Tập',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  // Danh sách các trang
  final List<Widget> _pages = [
    const Bai1Page(),
    const Bai2Page(),
    const Bai3Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Bài Tập Flutter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.looks_one), label: 'Bài 1'),
          BottomNavigationBarItem(icon: Icon(Icons.looks_two), label: 'Bài 2'),
          BottomNavigationBarItem(icon: Icon(Icons.looks_3), label: 'Bài 3'),
        ],
      ),
    );
  }
}

// ==================== BÀI 1 ====================
class Bai1Page extends StatelessWidget {
  const Bai1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Text(
          'Xin chào Flutter!',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

// ==================== BÀI 2 ====================
class Bai2Page extends StatelessWidget {
  const Bai2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Thông tin cá nhân',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Họ tên:', 'Nguyễn Trung Nhân'),
            const SizedBox(height: 15),
            _buildInfoRow('MSSV:', '21110266'),
            const SizedBox(height: 15),
            _buildInfoRow('Lớp:', 'CLST1A'),
            const SizedBox(height: 15),
            _buildInfoRow('Trường:', 'Đại học Sư Phạm Kỹ Thuật TPHCM'),
            const SizedBox(height: 15),
            _buildInfoRow('Sở thích:', 'Lập trình, du lịch, đọc sách'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
        children: [
          TextSpan(
            text: label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' $value'),
        ],
      ),
    );
  }
}

// ==================== BÀI 3 ====================
class Bai3Page extends StatelessWidget {
  const Bai3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Họ tên: Nguyễn Trung Nhân',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Tuổi: 22',
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text(
                'Nghề nghiệp: Sinh viên công nghệ thông tin',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
