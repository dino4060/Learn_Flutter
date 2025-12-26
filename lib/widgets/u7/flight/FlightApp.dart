import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/flight/ui/FlightSearchUI.dart';

class FlightApp extends StatelessWidget {
  const FlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const FlightSearchScreen(),
    );
  }
}
