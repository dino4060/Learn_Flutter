class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],
    );
  }

  // CopyWith để hỗ trợ việc cập nhật (Sửa)
  Product copyWith({
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,
  }) {
    return Product(
      id: this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
