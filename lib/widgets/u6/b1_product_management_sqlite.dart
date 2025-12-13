// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Quản lý sản phẩm',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 0,
//         ),
//       ),
//       home: ProductManagementScreen(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class Product {
//   int? id;
//   String maSP;
//   String tenSP;
//   int soLuong;

//   Product({
//     this.id,
//     required this.maSP,
//     required this.tenSP,
//     required this.soLuong,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'maSP': maSP,
//       'tenSP': tenSP,
//       'soLuong': soLuong,
//     };
//   }

//   factory Product.fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'],
//       maSP: map['maSP'],
//       tenSP: map['tenSP'],
//       soLuong: map['soLuong'],
//     );
//   }
// }

// class DatabaseHelper {
//   static final DatabaseHelper instance = DatabaseHelper._init();
//   static Database? _database;

//   DatabaseHelper._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('products.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE products (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         maSP TEXT NOT NULL,
//         tenSP TEXT NOT NULL,
//         soLuong INTEGER NOT NULL
//       )
//     ''');
//   }

//   Future<int> insertProduct(Product product) async {
//     final db = await database;
//     return await db.insert('products', product.toMap());
//   }

//   Future<List<Product>> getAllProducts() async {
//     final db = await database;
//     final result = await db.query('products', orderBy: 'id DESC');
//     return result.map((map) => Product.fromMap(map)).toList();
//   }

//   Future<int> updateProduct(Product product) async {
//     final db = await database;
//     return await db.update(
//       'products',
//       product.toMap(),
//       where: 'id = ?',
//       whereArgs: [product.id],
//     );
//   }

//   Future<int> deleteProduct(int id) async {
//     final db = await database;
//     return await db.delete(
//       'products',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }

// class ProductManagementScreen extends StatefulWidget {
//   @override
//   _ProductManagementScreenState createState() =>
//       _ProductManagementScreenState();
// }

// class _ProductManagementScreenState extends State<ProductManagementScreen> {
//   final _maSPController = TextEditingController();
//   final _tenSPController = TextEditingController();
//   final _soLuongController = TextEditingController();
//   final _dbHelper = DatabaseHelper.instance;

//   List<Product> _products = [];
//   Product? _selectedProduct;

//   @override
//   void initState() {
//     super.initState();
//     _loadProducts();
//   }

//   Future<void> _loadProducts() async {
//     final products = await _dbHelper.getAllProducts();
//     setState(() {
//       _products = products;
//     });
//   }

//   void _clearForm() {
//     _maSPController.clear();
//     _tenSPController.clear();
//     _soLuongController.clear();
//     setState(() {
//       _selectedProduct = null;
//     });
//   }

//   Future<void> _addProduct() async {
//     if (_maSPController.text.isEmpty ||
//         _tenSPController.text.isEmpty ||
//         _soLuongController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
//       );
//       return;
//     }

//     final product = Product(
//       maSP: _maSPController.text,
//       tenSP: _tenSPController.text,
//       soLuong: int.tryParse(_soLuongController.text) ?? 0,
//     );

//     await _dbHelper.insertProduct(product);
//     _clearForm();
//     await _loadProducts();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Đã thêm sản phẩm thành công')),
//     );
//   }

//   Future<void> _updateProduct() async {
//     if (_selectedProduct == null) return;

//     if (_maSPController.text.isEmpty ||
//         _tenSPController.text.isEmpty ||
//         _soLuongController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
//       );
//       return;
//     }

//     final product = Product(
//       id: _selectedProduct!.id,
//       maSP: _maSPController.text,
//       tenSP: _tenSPController.text,
//       soLuong: int.tryParse(_soLuongController.text) ?? 0,
//     );

//     await _dbHelper.updateProduct(product);
//     _clearForm();
//     await _loadProducts();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Đã cập nhật sản phẩm thành công')),
//     );
//   }

//   Future<void> _deleteProduct(int id) async {
//     await _dbHelper.deleteProduct(id);
//     _clearForm();
//     await _loadProducts();

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Đã xóa sản phẩm thành công')),
//     );
//   }

//   void _selectProduct(Product product) {
//     setState(() {
//       _selectedProduct = product;
//       _maSPController.text = product.maSP;
//       _tenSPController.text = product.tenSP;
//       _soLuongController.text = product.soLuong.toString();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quản lý sản phẩm (SQLite)'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _maSPController,
//                   decoration: InputDecoration(
//                     labelText: 'Mã SP',
//                     border: UnderlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _tenSPController,
//                   decoration: InputDecoration(
//                     labelText: 'Tên SP',
//                     border: UnderlineInputBorder(),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 TextField(
//                   controller: _soLuongController,
//                   decoration: InputDecoration(
//                     labelText: 'Số lượng',
//                     border: UnderlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton.icon(
//                       onPressed: _addProduct,
//                       icon: Icon(Icons.add),
//                       label: Text('Thêm'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[300],
//                         foregroundColor: Colors.black,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: _selectedProduct != null ? _updateProduct : null,
//                       icon: Icon(Icons.edit),
//                       label: Text('Cập nhật'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[300],
//                         foregroundColor: Colors.black,
//                       ),
//                     ),
//                     ElevatedButton.icon(
//                       onPressed: _selectedProduct != null
//                           ? () => _deleteProduct(_selectedProduct!.id!)
//                           : null,
//                       icon: Icon(Icons.delete),
//                       label: Text('Xóa'),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.grey[300],
//                         foregroundColor: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Divider(thickness: 1),
//           Expanded(
//             child: _products.isEmpty
//                 ? Center(
//                     child: Text(
//                       'Chưa có sản phẩm nào',
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                   )
//                 : ListView.builder(
//                     itemCount: _products.length,
//                     itemBuilder: (context, index) {
//                       final product = _products[index];
//                       final isSelected = _selectedProduct?.id == product.id;

//                       return Container(
//                         margin: EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: isSelected
//                               ? Colors.blue[50]
//                               : Colors.grey[100],
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(
//                             color: isSelected
//                                 ? Colors.blue
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                         ),
//                         child: ListTile(
//                           onTap: () => _selectProduct(product),
//                           title: Text(
//                             '${product.maSP} - ${product.tenSP}',
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           subtitle: Text('Số lượng: ${product.soLuong}'),
//                         ),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _maSPController.dispose();
//     _tenSPController.dispose();
//     _soLuongController.dispose();
//     super.dispose();
//   }
// }
