import 'package:flutter/material.dart';

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
            children: const [
              Text(
                'Họ tên: Nguyễn Trung Nhân',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
                'Tuổi: 22',
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Text(
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
