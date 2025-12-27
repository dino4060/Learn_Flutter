import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common/Number.dart';
import 'package:flutter_application_1/widgets/u7/parking/api/ParkingAPI.dart';
import 'package:intl/intl.dart';

class ParkingStatsScreen extends StatefulWidget {
  const ParkingStatsScreen({super.key});

  @override
  State<ParkingStatsScreen> createState() => _ParkingStatsScreenState();
}

class _ParkingStatsScreenState extends State<ParkingStatsScreen> {
  bool _isMonthly = false;
  DateTime _selectedDate = DateTime.now();
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _stats = ParkingAPI.getStatistics(_selectedDate, _isMonthly);
    });
  }

  Future<void> _selectDate() async {
    if (_isMonthly) {
      final date = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year,
      );
      if (date != null) {
        setState(() {
          _selectedDate = DateTime(date.year, date.month, 1);
          _loadStats();
        });
      }
    } else {
      final date = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
      );
      if (date != null) {
        setState(() {
          _selectedDate = date;
          _loadStats();
        });
      }
    }
  }

  String get _dateText {
    if (_isMonthly) {
      return DateFormat('MM/yyyy').format(_selectedDate);
    } else {
      return DateFormat('dd/MM/yyyy').format(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thống Kê"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _stats == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: !_isMonthly,
                                onChanged: (value) {
                                  setState(() {
                                    _isMonthly = false;
                                    _loadStats();
                                  });
                                },
                              ),
                              const Text("Theo ngày"),
                              const SizedBox(width: 24),
                              Checkbox(
                                value: _isMonthly,
                                onChanged: (value) {
                                  setState(() {
                                    _isMonthly = true;
                                    _loadStats();
                                  });
                                },
                              ),
                              const Text("Theo tháng"),
                            ],
                          ),
                          const Divider(),
                          InkWell(
                            onTap: _selectDate,
                            child: InputDecorator(
                              decoration: const InputDecoration(
                                labelText: "Chọn thời gian",
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              child: Text(
                                _dateText,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
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
                            "Tổng quan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(
                                    Icons.local_parking,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${_stats!['tongXe']}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text("Tổng lượt"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.two_wheeler,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${_stats!['xeMay']}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text("Xe máy"),
                                ],
                              ),
                              Column(
                                children: [
                                  const Icon(
                                    Icons.directions_car,
                                    size: 40,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "${_stats!['oto']}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text("Ô tô"),
                                ],
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
                    color: Colors.green.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Doanh thu",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(height: 24),
                          Center(
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.monetization_on,
                                  size: 48,
                                  color: Colors.green,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  formatVNDPrice(_stats!['tongDoanhThu']),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                const Text("Tổng doanh thu"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_stats!['tongXe'] == 0) ...[
                    const SizedBox(height: 24),
                    const Center(
                      child: Text(
                        "Không có dữ liệu trong khoảng thời gian này",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
    );
  }
}