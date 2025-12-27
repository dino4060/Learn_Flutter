import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/parking/UI/ParkingEntryUI.dart';
import 'package:flutter_application_1/widgets/u7/parking/UI/ParkingExitUI.dart';
import 'package:flutter_application_1/widgets/u7/parking/UI/ParkingFeeUI.dart';
import 'package:flutter_application_1/widgets/u7/parking/UI/ParkingStatsUI.dart';
import 'package:flutter_application_1/widgets/u7/parking/api/ParkingAPI.dart';
import 'package:flutter_application_1/widgets/u7/parking/models/Parking.dart';
import 'package:intl/intl.dart';

class ParkingListScreen extends StatefulWidget {
  const ParkingListScreen({super.key});

  @override
  State<ParkingListScreen> createState() => _ParkingListScreenState();
}

class _ParkingListScreenState extends State<ParkingListScreen> {
  List<Parking> _parkings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadParkings();
  }

  void _loadParkings() async {
    setState(() {
      _isLoading = true;
    });
    final data = await ParkingAPI.getParkings();
    setState(() {
      _parkings = data.reversed.toList();
      _isLoading = false;
    });
  }

  void _showEntryForm() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ParkingEntryForm(
        onSave: () {
          _loadParkings();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showExitForm(Parking parking) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ParkingExitForm(
        parking: parking,
        onSave: () {
          _loadParkings();
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showFeeCalculation(Parking parking) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ParkingFeeScreen(parking: parking)),
    ).then((_) => _loadParkings());
  }

  void _showStatistics() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ParkingStatsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản Lý Bãi Giữ Xe"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: "Thống kê",
            onPressed: _showStatistics,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _parkings.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_parking, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Chưa có xe nào trong bãi",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _parkings.length,
              itemBuilder: (context, index) {
                final parking = _parkings[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  parking.loaiXe == LoaiXe.xeMay
                                      ? Icons.two_wheeler
                                      : Icons.directions_car,
                                  size: 32,
                                  color: parking.loaiXe == LoaiXe.xeMay
                                      ? Colors.blue
                                      : Colors.green,
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      parking.bienSo,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      parking.loaiXeText,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: parking.isDaRa
                                    ? Colors.red.shade50
                                    : Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: parking.isDaRa
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                              child: Text(
                                parking.isDaRa ? "Đã ra" : "Đang gửi",
                                style: TextStyle(
                                  color: parking.isDaRa
                                      ? Colors.red
                                      : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Giờ vào",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat(
                                    'dd/MM HH:mm',
                                  ).format(parking.gioVao),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            if (parking.isDaRa)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    "Giờ ra",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat(
                                      'dd/MM HH:mm',
                                    ).format(parking.gioRa!),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            if (!parking.isDaRa)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _showExitForm(parking),
                                  icon: const Icon(Icons.exit_to_app),
                                  label: const Text("Ghi nhận ra"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange.shade50,
                                    foregroundColor: Colors.orange,
                                  ),
                                ),
                              ),
                            if (!parking.isDaRa) const SizedBox(width: 8),
                            if (parking.isDaRa)
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () => _showFeeCalculation(parking),
                                  icon: const Icon(Icons.calculate),
                                  label: const Text("Tính tiền"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue.shade50,
                                    foregroundColor: Colors.blue,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showEntryForm,
        icon: const Icon(Icons.add),
        label: const Text("Xe vào"),
      ),
    );
  }
}
