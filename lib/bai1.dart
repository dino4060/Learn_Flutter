import 'package:flutter/material.dart';

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
