import 'package:flutter/material.dart';

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
            _buildInfoRow('Sở thích:', 'lập trình, du lịch, đọc sách'),
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
