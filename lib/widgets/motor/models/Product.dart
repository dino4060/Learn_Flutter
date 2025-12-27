class Product {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;

  final String type;
  final DateTime goIn;
  final DateTime goOut;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,

    required this.type,
    required this.goIn,
    required this.goOut,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      imageUrl: json['imageUrl'],

      type: json['type'],
      goIn: json['goIn'],
      goOut: json['goOut'],
    );
  }

  // CopyWith để hỗ trợ việc cập nhật (Sửa)
  Product copyWith({
    String? name,
    double? price,
    int? quantity,
    String? imageUrl,

    String? type,
    DateTime? goIn,
    DateTime? goOut,
  }) {
    return Product(
      id: this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,

      type: type ?? this.type,
      goIn: goIn ?? this.goIn,
      goOut: goOut ?? this.goOut,
    );
  }
}
