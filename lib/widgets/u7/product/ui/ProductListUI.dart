import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common/Number.dart';
import 'package:flutter_application_1/widgets/u7/product/UI/ProductFromUI.dart';
import 'package:flutter_application_1/widgets/u7/product/api/ProductAPI.dart';
import 'package:flutter_application_1/widgets/u7/product/models/Product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> _items = [];

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() async {
    final data = await ProductAPI.fetchProducts();
    setState(() {
      _items = data;
    });
  }

  // Hàm mở Form (Dùng chung cho Thêm & Sửa)
  void _showForm(Product? product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProductForm(
        product: product,
        onSave: () {
          _refreshList();
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản Lý Sản Phẩm"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _items.isEmpty
          ? const Center(child: Text("Danh sách trống"))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final prod = _items[index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      prod.imageUrl,
                      width: 40,
                      errorBuilder: (c, e, s) => const Icon(Icons.image),
                    ),
                    title: Text(
                      prod.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Giá: ${formatVNDPrice(prod.price)} - SL: ${prod.quantity}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showForm(prod),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ProductAPI.deleteProduct(prod.id);
                            _refreshList();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
