import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/product/UI/ProductListUI.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ProductListScreen(),
    );
  }
}
