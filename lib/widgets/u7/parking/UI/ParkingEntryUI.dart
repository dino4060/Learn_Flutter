import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/u7/parking/api/ParkingAPI.dart';
import 'package:flutter_application_1/widgets/u7/parking/models/Parking.dart';

class ParkingEntryForm extends StatefulWidget {
  final VoidCallback onSave;

  const ParkingEntryForm({super.key, required this.onSave});

  @override
  State<ParkingEntryForm> createState() => _ParkingEntryFormState();
}

class _ParkingEntryFormState extends State<ParkingEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _bienSoController = TextEditingController();
  LoaiXe _loaiXe = LoaiXe.xeMay;
  DateTime _gioVao = DateTime.now();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ParkingAPI.addVehicleEntry(_bienSoController.text, _loaiXe, _gioVao);
      widget.onSave();
    }
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _gioVao,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_gioVao),
      );

      if (time != null) {
        setState(() {
          _gioVao = DateTime(
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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "GHI NHẬN XE VÀO",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bienSoController,
              decoration: const InputDecoration(
                labelText: "Biển số xe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.confirmation_number),
              ),
              textCapitalization: TextCapitalization.characters,
              validator: (v) => v!.isEmpty ? "Nhập biển số" : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<LoaiXe>(
              value: _loaiXe,
              decoration: const InputDecoration(
                labelText: "Loại xe",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_car),
              ),
              items: const [
                DropdownMenuItem(value: LoaiXe.xeMay, child: Text("Xe máy")),
                DropdownMenuItem(value: LoaiXe.oto, child: Text("Ô tô")),
              ],
              onChanged: (value) {
                setState(() {
                  _loaiXe = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: _selectDateTime,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: "Giờ vào",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
                child: Text(
                  "${_gioVao.day.toString().padLeft(2, '0')}/${_gioVao.month.toString().padLeft(2, '0')}/${_gioVao.year} ${_gioVao.hour.toString().padLeft(2, '0')}:${_gioVao.minute.toString().padLeft(2, '0')}",
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
      ),
    );
  }
}
