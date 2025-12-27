import 'package:flutter_application_1/widgets/motor/models/Product.dart';

class ProductAPI {
  static List<Product> mockData = [
    Product(
      id: 1,
      name: "Sữa tươi Vinamilk",
      price: 35000,
      quantity: 50,
      imageUrl: "https://picsum.photos/200?random=1",

      type: "OTo",
      goIn: new DateTime(2025, 12, 26, 5, 23, 10, 0, 0),
      goOut: new DateTime(2025, 12, 26, 15, 23, 10, 0, 0),
    ),
    Product(
      id: 2,
      name: "Bánh mì gối",
      price: 15000,
      quantity: 20,
      imageUrl: "https://picsum.photos/200?random=2",

      type: "XeMay",
      goIn: new DateTime(2025, 12, 26, 5, 23, 10, 0, 0),
      goOut: new DateTime(2025, 12, 26, 15, 23, 10, 0, 0),
    ),
  ];

  static Future<List<Product>> fetchProducts() async {
    // Đã bỏ delay để không cần hiệu ứng xoay
    return List.from(mockData);
  }

  static void addProduct(Product product) => mockData.add(product);

  static void updateProduct(Product product) {
    int index = mockData.indexWhere((p) => p.id == product.id);
    if (index != -1) mockData[index] = product;
  }

  static void deleteProduct(int id) => mockData.removeWhere((p) => p.id == id);
}
