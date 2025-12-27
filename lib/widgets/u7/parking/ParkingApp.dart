import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/parking/UI/ParkingListUI.dart';

class ParkingApp extends StatelessWidget {
  const ParkingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ParkingListScreen(),
    );
  }
}
