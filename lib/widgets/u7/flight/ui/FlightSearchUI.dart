import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/common/Number.dart';
import 'package:flutter_application_1/widgets/u7/flight/ui/BookingListUI.dart';
import 'package:flutter_application_1/widgets/u7/flight/ui/FlightDetailUI.dart';
import 'package:flutter_application_1/widgets/u7/flight/api/FlightAPI.dart';
import 'package:flutter_application_1/widgets/u7/flight/models/Flight.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  State<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  String _from = "Hà Nội";
  String _to = "TP. Hồ Chí Minh";
  List<Flight> _flights = [];
  bool _isLoading = false;
  final List<String> _cities = FlightAPI.getCities();

  @override
  void initState() {
    super.initState();
    _searchFlights();
  }

  void _searchFlights() async {
    setState(() {
      _isLoading = true;
    });
    final results = await FlightAPI.searchFlights(_from, _to);
    setState(() {
      _flights = results;
      _isLoading = false;
    });
  }

  void _swapCities() {
    setState(() {
      final temp = _from;
      _from = _to;
      _to = temp;
    });
    _searchFlights();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đặt Vé Máy Bay"),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: "Vé đã đặt",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const BookingListScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Expanded(
                //       child: DropdownButtonFormField<String>(
                //         value: _from,
                //         decoration: const InputDecoration(
                //           labelText: "Từ",
                //           border: OutlineInputBorder(),
                //           filled: true,
                //           fillColor: Colors.white,
                //         ),
                //         items: _cities
                //             .map(
                //               (city) => DropdownMenuItem(
                //                 value: city,
                //                 child: Text(city),
                //               ),
                //             )
                //             .toList(),
                //         onChanged: (value) {
                //           setState(() {
                //             _from = value!;
                //           });
                //         },
                //       ),
                //     ),
                //     IconButton(
                //       icon: const Icon(Icons.swap_horiz, size: 32),
                //       onPressed: _swapCities,
                //     ),
                //     Expanded(
                //       child: DropdownButtonFormField<String>(
                //         value: _to,
                //         decoration: const InputDecoration(
                //           labelText: "Đến",
                //           border: OutlineInputBorder(),
                //           filled: true,
                //           fillColor: Colors.white,
                //         ),
                //         items: _cities
                //             .map(
                //               (city) => DropdownMenuItem(
                //                 value: city,
                //                 child: Text(city),
                //               ),
                //             )
                //             .toList(),
                //         onChanged: (value) {
                //           setState(() {
                //             _to = value!;
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    // 1. Dùng Expanded nhưng thêm constraints cho Dropdown
                    Expanded(
                      flex: 4, // Chia tỉ lệ để cân đối hơn
                      child: DropdownButtonFormField<String>(
                        isExpanded:
                            true, // Quan trọng: Đảm bảo text không làm tràn dropdown
                        value: _from,
                        decoration: const InputDecoration(
                          labelText: "Từ",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ), // Giảm padding
                        ),
                        items: _cities
                            .map(
                              (city) => DropdownMenuItem(
                                value: city,
                                child: Text(
                                  city,
                                  style: const TextStyle(fontSize: 13),
                                ), // Giảm size chữ một chút
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _from = value!),
                      ),
                    ),

                    // 2. Giảm kích thước IconButton
                    IconButton(
                      padding:
                          EdgeInsets.zero, // Loại bỏ padding mặc định của nút
                      icon: const Icon(
                        Icons.swap_horiz,
                        size: 28,
                      ), // Giảm từ 32 xuống 28
                      onPressed: _swapCities,
                    ),

                    // 3. Dropdown bên phải
                    Expanded(
                      flex: 4,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _to,
                        decoration: const InputDecoration(
                          labelText: "Đến",
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                        ),
                        items: _cities
                            .map(
                              (city) => DropdownMenuItem(
                                value: city,
                                child: Text(
                                  city,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(() => _to = value!),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _searchFlights,
                  icon: const Icon(Icons.search),
                  label: const Text("Tìm chuyến bay"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _flights.isEmpty
                ? const Center(
                    child: Text(
                      "Không tìm thấy chuyến bay nào",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _flights.length,
                    itemBuilder: (context, index) {
                      final flight = _flights[index];
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    FlightDetailScreen(flight: flight),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      flight.airline,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      flight.flightNumber,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          flight.from,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          flight.time.split(' - ')[0],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.flight_takeoff,
                                      color: Colors.blue,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          flight.to,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          flight.time.split(' - ')[1],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(height: 24),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Giá vé:",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      formatVNDPrice(flight.price),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
