import 'package:flutter/material.dart';

// ------------------------------------------------
// 1. MÔ HÌNH DỮ LIỆU (Data Models)
// ------------------------------------------------

// Model cho món ăn trong Menu
class MenuItem {
  final int id;
  final String name;
  final double price;
  final bool isIceAvailable;
  final bool isHotAvailable;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.isIceAvailable,
    required this.isHotAvailable,
  });
}

// Model cho Món đã gọi (Bao gồm tùy chọn Nóng/Lạnh)
class OrderedItem {
  final MenuItem item;
  final bool isHot; // true = Nóng, false = Lạnh

  OrderedItem({required this.item, required this.isHot});

  // Tên món đầy đủ (có Nóng/Lạnh)
  String get displayName => '${item.name} (${isHot ? 'Nóng' : 'Lạnh'})';
  double get price => item.price;
}

// ------------------------------------------------
// 2. LOGIC KINH DOANH (Business Logic & Data)
// ------------------------------------------------

// Dữ liệu Menu giả lập
final List<MenuItem> mockMenuItems = [
  MenuItem(
    id: 1,
    name: 'Espresso',
    price: 2.50,
    isIceAvailable: false,
    isHotAvailable: true,
  ),
  MenuItem(
    id: 2,
    name: 'Latte',
    price: 3.50,
    isIceAvailable: true,
    isHotAvailable: true,
  ),
  MenuItem(
    id: 3,
    name: 'Trà Đào',
    price: 3.00,
    isIceAvailable: true,
    isHotAvailable: false,
  ),
  MenuItem(
    id: 4,
    name: 'Nước Cam',
    price: 4.00,
    isIceAvailable: true,
    isHotAvailable: false,
  ),
  MenuItem(
    id: 5,
    name: 'Socola',
    price: 3.75,
    isIceAvailable: true,
    isHotAvailable: true,
  ),
];

// ------------------------------------------------
// 3. GIAO DIỆN NGƯỜI DÙNG (UI - Flutter)
// ------------------------------------------------

class CafePOSApp extends StatelessWidget {
  const CafePOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POS Cafe Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const POSScreen(),
    );
  }
}

class POSScreen extends StatefulWidget {
  const POSScreen({super.key});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  // Trạng thái (State) quản lý các chức năng
  List<OrderedItem> _currentOrder = [];
  String _searchQuery = '';
  String _filterType = 'all'; // 'all', 'hot', 'ice'

  // Chức năng 3: Tính tổng tiền
  double get _totalPrice {
    return _currentOrder.fold(0.0, (sum, item) => sum + item.price);
  }

  // Lọc và Tìm kiếm Menu
  List<MenuItem> get _filteredMenu {
    List<MenuItem> result = mockMenuItems;

    // Chức năng 4: Tìm theo từ khóa
    if (_searchQuery.isNotEmpty) {
      result = result
          .where(
            (item) =>
                item.name.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }

    // Chức năng 5: Lọc hot/ice
    if (_filterType == 'hot') {
      result = result.where((item) => item.isHotAvailable).toList();
    } else if (_filterType == 'ice') {
      result = result.where((item) => item.isIceAvailable).toList();
    }

    return result;
  }

  // Chức năng 2: Gọi món (Thêm vào Order)
  void _addToOrder(MenuItem item, bool isHot) {
    if (isHot && !item.isHotAvailable) {
      _showErrorDialog('Món này không có phiên bản Nóng.');
      return;
    }
    if (!isHot && !item.isIceAvailable) {
      _showErrorDialog('Món này không có phiên bản Lạnh.');
      return;
    }

    setState(() {
      _currentOrder.add(OrderedItem(item: item, isHot: isHot));
    });
  }

  // Xử lý thanh toán (Checkout)
  void _checkout() {
    if (_currentOrder.isEmpty) {
      _showErrorDialog('Giỏ hàng trống! Vui lòng gọi món.');
      return;
    }

    // Thực hiện logic thanh toán (ví dụ: hiển thị thông báo)
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thanh Toán Thành Công! 💵'),
        content: Text(
          'Tổng cộng: \$${_totalPrice.toStringAsFixed(2)}\nHóa đơn đã được tạo và giỏ hàng đã được làm trống.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Đóng'),
          ),
        ],
      ),
    );

    // Reset giỏ hàng
    setState(() {
      _currentOrder.clear();
    });
  }

  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('☕ POS Quán Cà Phê Demo')),
      body: Row(
        children: [
          // Phần 1: Menu và Điều khiển
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildSearchAndFilter(),
                // Chức năng 1: Hiển thị menu hệ thống
                Expanded(child: _buildMenuItemList()),
              ],
            ),
          ),
          // Phần 2: Hóa đơn (Order)
          Expanded(flex: 1, child: _buildOrderSummary()),
        ],
      ),
    );
  }

  // Widget tìm kiếm và lọc
  Widget _buildSearchAndFilter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Tìm kiếm món ăn',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFilterButton('Tất cả', 'all'),
              _buildFilterButton('Nóng 🔥', 'hot'),
              _buildFilterButton('Lạnh 🧊', 'ice'),
            ],
          ),
        ],
      ),
    );
  }

  // Widget nút lọc
  Widget _buildFilterButton(String text, String type) {
    return ChoiceChip(
      label: Text(text),
      selected: _filterType == type,
      onSelected: (selected) {
        setState(() {
          _filterType = selected ? type : 'all';
        });
      },
      selectedColor: Colors.brown.shade200,
    );
  }

  // Widget hiển thị danh sách Menu
  Widget _buildMenuItemList() {
    return ListView.builder(
      itemCount: _filteredMenu.length,
      itemBuilder: (context, index) {
        final item = _filteredMenu[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(
              item.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Giá: \$${item.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (item.isHotAvailable)
                  _buildOptionButton(item, true, 'Nóng 🔥'),
                if (item.isIceAvailable)
                  _buildOptionButton(item, false, 'Lạnh 🧊'),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget nút chọn Nóng/Lạnh
  Widget _buildOptionButton(MenuItem item, bool isHot, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isHot ? Colors.red.shade100 : Colors.blue.shade100,
          foregroundColor: Colors.black,
        ),
        onPressed: () => _addToOrder(item, isHot),
        child: Text(label),
      ),
    );
  }

  // Widget tóm tắt Hóa đơn
  Widget _buildOrderSummary() {
    return Container(
      color: Colors.brown.shade50,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '🧾 Hóa Đơn Hiện Tại',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          // Danh sách các món đã gọi
          Expanded(
            child: _currentOrder.isEmpty
                ? const Center(child: Text('Chưa có món nào được gọi.'))
                : ListView.builder(
                    itemCount: _currentOrder.length,
                    itemBuilder: (context, index) {
                      final orderedItem = _currentOrder[index];
                      return ListTile(
                        title: Text(orderedItem.displayName),
                        trailing: Text(
                          '\$${orderedItem.price.toStringAsFixed(2)}',
                        ),
                      );
                    },
                  ),
          ),
          const Divider(thickness: 2),
          // Chức năng 3: Hiển thị tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TỔNG CỘNG:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${_totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Nút Thanh toán
          ElevatedButton.icon(
            onPressed: _checkout,
            icon: const Icon(Icons.payment),
            label: const Text('THANH TOÁN (Checkout)'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
              backgroundColor: Colors.brown,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
