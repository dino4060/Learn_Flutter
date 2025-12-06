import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuyển đổi tab',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabSwitchPage(),
    );
  }
}

class TabSwitchPage extends StatefulWidget {
  @override
  _TabSwitchPageState createState() => _TabSwitchPageState();
}

class _TabSwitchPageState extends State<TabSwitchPage> {
  int _currentIndex = 0;

  // Danh sách các màn hình cho mỗi tab
  final List<Widget> _screens = [HomeScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyển đổi tab'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hồ sơ'),
        ],
      ),
    );
  }
}

// Màn hình Trang chủ
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Màn hình chủ',
        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
      ),
    );
  }
}

// Màn hình Hồ sơ
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.account_circle, size: 80, color: Colors.grey[400]),
          SizedBox(height: 16),
          Text(
            'Thông tin hồ sơ',
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
