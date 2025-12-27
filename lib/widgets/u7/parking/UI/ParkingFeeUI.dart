import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common/Number.dart';
import 'package:flutter_application_1/widgets/u7/parking/api/ParkingAPI.dart';
import 'package:flutter_application_1/widgets/u7/parking/models/Parking.dart';
import 'package:intl/intl.dart';

class ParkingFeeScreen extends StatefulWidget {
  final Parking parking;

  const ParkingFeeScreen({super.key, required this.parking});

  @override
  State<ParkingFeeScreen> createState() => _ParkingFeeScreenState();
}

class _ParkingFeeScreenState extends State<ParkingFeeScreen> {
  Map<String, dynamic>? _feeDetails;

  @override
  void initState() {
    super.initState();
    _feeDetails = ParkingAPI.calculateFee(widget.parking);
  }

  @override
  Widget build(BuildContext context) {
    if (_feeDetails == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bangGia = BangGia.getGia(widget.parking.loaiXe);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tính Tiền Giữ Xe"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Thông tin xe",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Biển số:"),
                        Text(
                          widget.parking.bienSo,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Loại xe:"),
                        Text(
                          widget.parking.loaiXeText,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Giờ vào:"),
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(widget.parking.gioVao),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Giờ ra:"),
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm')
                              .format(widget.parking.gioRa!),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Bảng giá",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Giá theo giờ:"),
                        Text(
                          formatVNDPrice(bangGia.giaTheoGio),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Giá tối đa/ngày:"),
                        Text(
                          formatVNDPrice(bangGia.giaToiDa),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Phụ thu qua đêm (22h - 7h):"),
                        Text(
                          formatVNDPrice(bangGia.phuThuQuaDem),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 3,
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Chi tiết tính phí",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tổng thời gian:"),
                        Text(
                          "${_feeDetails!['tongThoiGian'].toStringAsFixed(1)} giờ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Số giờ tính:"),
                        Text(
                          "${_feeDetails!['soGio']} giờ",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Tiền giữ xe:"),
                        Text(
                          formatVNDPrice(_feeDetails!['tienGio']),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text("Phụ thu qua đêm:"),
                            if (_feeDetails!['isQuaDem'])
                              const SizedBox(width: 4),
                            if (_feeDetails!['isQuaDem'])
                              const Icon(
                                Icons.check_circle,
                                color: Colors.orange,
                                size: 16,
                              ),
                          ],
                        ),
                        Text(
                          formatVNDPrice(_feeDetails!['phuThuQuaDem']),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _feeDetails!['isQuaDem']
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "TỔNG TIỀN:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          formatVNDPrice(_feeDetails!['thanhTien']),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Xác nhận thanh toán"),
                    content: Text(
                      "Tổng tiền: ${formatVNDPrice(_feeDetails!['thanhTien'])}",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Hủy"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Xác nhận"),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.payment),
              label: const Text("THANH TOÁN"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}