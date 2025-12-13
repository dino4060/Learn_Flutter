import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý sản phẩm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      home: ProductManagementScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Product {
  String maSP;
  String tenSP;
  int soLuong;

  Product({required this.maSP, required this.tenSP, required this.soLuong});
}

class ProductManagementScreen extends StatefulWidget {
  @override
  _ProductManagementScreenState createState() =>
      _ProductManagementScreenState();
}

class _ProductManagementScreenState extends State<ProductManagementScreen> {
  final _maSPController = TextEditingController();
  final _tenSPController = TextEditingController();
  final _soLuongController = TextEditingController();

  List<Product> _products = [];
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    // Dữ liệu mẫu
    _products = [
      Product(maSP: 'x1', tenSP: 'Xoai', soLuong: 10),
      Product(maSP: 'm1', tenSP: 'Mit', soLuong: 5),
    ];
  }

  void _clearForm() {
    _maSPController.clear();
    _tenSPController.clear();
    _soLuongController.clear();
    setState(() {
      _selectedIndex = null;
    });
  }

  void _addProduct() {
    if (_maSPController.text.isEmpty ||
        _tenSPController.text.isEmpty ||
        _soLuongController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')));
      return;
    }

    setState(() {
      _products.add(
        Product(
          maSP: _maSPController.text,
          tenSP: _tenSPController.text,
          soLuong: int.tryParse(_soLuongController.text) ?? 0,
        ),
      );
    });

    _clearForm();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã thêm sản phẩm thành công')));
  }

  void _updateProduct() {
    if (_selectedIndex == null) return;

    if (_maSPController.text.isEmpty ||
        _tenSPController.text.isEmpty ||
        _soLuongController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')));
      return;
    }

    setState(() {
      _products[_selectedIndex!] = Product(
        maSP: _maSPController.text,
        tenSP: _tenSPController.text,
        soLuong: int.tryParse(_soLuongController.text) ?? 0,
      );
    });

    _clearForm();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã cập nhật sản phẩm thành công')));
  }

  void _deleteProduct() {
    if (_selectedIndex == null) return;

    setState(() {
      _products.removeAt(_selectedIndex!);
    });

    _clearForm();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã xóa sản phẩm thành công')));
  }

  void _selectProduct(int index) {
    setState(() {
      _selectedIndex = index;
      _maSPController.text = _products[index].maSP;
      _tenSPController.text = _products[index].tenSP;
      _soLuongController.text = _products[index].soLuong.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quản lý sản phẩm (SQLite)')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _maSPController,
                  decoration: InputDecoration(
                    labelText: 'Mã SP',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _tenSPController,
                  decoration: InputDecoration(
                    labelText: 'Tên SP',
                    border: UnderlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _soLuongController,
                  decoration: InputDecoration(
                    labelText: 'Số lượng',
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _addProduct,
                      icon: Icon(Icons.add),
                      label: Text('Thêm'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _selectedIndex != null ? _updateProduct : null,
                      icon: Icon(Icons.edit),
                      label: Text('Cập nhật'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: _selectedIndex != null ? _deleteProduct : null,
                      icon: Icon(Icons.delete),
                      label: Text('Xóa'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
          Expanded(
            child: _products.isEmpty
                ? Center(
                    child: Text(
                      'Chưa có sản phẩm nào',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      final isSelected = _selectedIndex == index;

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue[50]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          onTap: () => _selectProduct(index),
                          title: Text(
                            '${product.maSP} - ${product.tenSP}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text('Số lượng: ${product.soLuong}'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _maSPController.dispose();
    _tenSPController.dispose();
    _soLuongController.dispose();
    super.dispose();
  }
}
