import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/parking/api/ParkingAPI.dart';
import 'package:flutter_application_1/widgets/u7/parking/models/Parking.dart';

class ParkingExitForm extends StatefulWidget {
  final Parking parking;
  final VoidCallback onSave;

  const ParkingExitForm({
    super.key,
    required this.parking,
    required this.onSave,
  });

  @override
  State<ParkingExitForm> createState() => _ParkingExitFormState();
}

class _ParkingExitFormState extends State<ParkingExitForm> {
  DateTime _gioRa = DateTime.now();

  void _submit() {
    if (_gioRa.isBefore(widget.parking.gioVao)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Giờ ra không thể trước giờ vào!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    ParkingAPI.recordExit(widget.parking.id, _gioRa);
    widget.onSave();
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _gioRa,
      firstDate: widget.parking.gioVao,
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_gioRa),
      );

      if (time != null) {
        setState(() {
          _gioRa = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "GHI NHẬN XE RA",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Biển số: ${widget.parking.bienSo}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Loại xe: ${widget.parking.loaiXeText}",
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: _selectDateTime,
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: "Giờ ra",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.exit_to_app),
              ),
              child: Text(
                "${_gioRa.day.toString().padLeft(2, '0')}/${_gioRa.month.toString().padLeft(2, '0')}/${_gioRa.year} ${_gioRa.hour.toString().padLeft(2, '0')}:${_gioRa.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text("LƯU THÔNG TIN"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
