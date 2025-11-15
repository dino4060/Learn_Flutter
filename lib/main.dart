import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trang Chủ")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CitizenPage()),
                );
              },
              child: Text("Nhập Thông Tin Cá Nhân"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentPage()),
                );
              },
              child: Text("Nhập Sinh Viên"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LunarYearPage()),
                );
              },
              child: Text("Tính Năm Âm Lịch"),
            ),
          ],
        ),
      ),
    );
  }
}

class CitizenPage extends StatefulWidget {
  @override
  _CitizenPageState createState() => _CitizenPageState();
}

class _CitizenPageState extends State<CitizenPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _nameController = TextEditingController();
  final _interestController = TextEditingController();
  final _extraInfoController = TextEditingController();

  // Mặc định là "THPT"
  String _educationLevel = 'THPT'; // Đặt giá trị mặc định là "THPT"

  // Danh sách các lựa chọn cho Bằng cấp
  final List<String> _educationLevels = ['THPT', 'ĐH', 'THS', 'TS'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Mở modal hiển thị thông tin
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0), // Bo tròn góc modal
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Thông tin Sinh Viên',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Tên Người: ${_nameController.text}'),
                  Text('Số Căn Cước Công Dân: ${_studentIdController.text}'),
                  Text('Bằng Cấp: $_educationLevel'),
                  Text('Sở Thích: ${_interestController.text}'),
                  Text('Bổ Sung: ${_extraInfoController.text}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Đóng modal
                    },
                    child: Text('Đóng'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nhập Sinh Viên")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tên người
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Tên Người'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Tên Người phải ít nhất 3 ký tự';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Số Căn Cước Công Dân
              TextFormField(
                controller: _studentIdController,
                decoration: InputDecoration(labelText: 'Số Căn Cước Công Dân'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 9) {
                    return 'Số Căn Cước Công Dân phải ít nhất 9 ký tự';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Dropdown chọn Bằng Cấp
              DropdownButtonFormField<String>(
                value: _educationLevel, // Giá trị mặc định là "THPT"
                decoration: InputDecoration(labelText: 'Bằng Cấp'),
                items: _educationLevels.map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _educationLevel = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn Bằng Cấp';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Sở thích
              TextFormField(
                controller: _interestController,
                decoration: InputDecoration(labelText: 'Sở Thích'),
                validator: (value) {
                  return null; // Không yêu cầu validation cho sở thích
                },
              ),
              SizedBox(height: 20),

              // Bổ sung
              TextFormField(
                controller: _extraInfoController,
                decoration: InputDecoration(labelText: 'Bổ Sung'),
                validator: (value) {
                  return null; // Không yêu cầu validation cho bổ sung
                },
              ),
              SizedBox(height: 20),

              // Nút Nhập
              ElevatedButton(onPressed: _submitForm, child: Text('Nhập')),
            ],
          ),
        ),
      ),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _students = <Map<String, String>>[];
  final _studentIdController = TextEditingController();
  final _nameController = TextEditingController();
  String? _gender;
  DateTime _birthDate = DateTime.now();
  final _birthPlaceController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _students.add({
          'Mã Sinh Viên': _studentIdController.text,
          'Họ Tên': _nameController.text,
          'Giới tính': _gender!,
          'Ngày Sinh': DateFormat('yyyy-MM-dd').format(_birthDate),
          'Nơi Sinh': _birthPlaceController.text,
        });
      });

      _studentIdController.clear();
      _nameController.clear();
      _gender = null;
      _birthDate = DateTime.now();
      _birthPlaceController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nhập Sinh Viên")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _studentIdController,
                decoration: InputDecoration(labelText: 'Mã Sinh Viên'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 9) {
                    return 'Mã Sinh Viên phải ít nhất 9 ký tự';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Họ Tên'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 3) {
                    return 'Họ Tên phải ít nhất 3 ký tự';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('Nam'),
                      leading: Radio<String>(
                        value: 'Nam',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text('Nữ'),
                      leading: Radio<String>(
                        value: 'Nữ',
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Text('Ngày Sinh'),
                subtitle: Text(DateFormat('yyyy-MM-dd').format(_birthDate)),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _birthDate,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null && picked != _birthDate) {
                    setState(() {
                      _birthDate = picked;
                    });
                  }
                },
              ),
              TextFormField(
                controller: _birthPlaceController,
                decoration: InputDecoration(labelText: 'Nơi Sinh'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _submitForm, child: Text('Nhập')),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    final student = _students[index];
                    return Card(
                      child: ListTile(
                        title: Text(student['Mã SV']!),
                        subtitle: Text(
                          'Họ Tên: ${student['Họ Tên']} \nNgày Sinh: ${student['Ngày Sinh']} \nNơi Sinh: ${student['Nơi Sinh']}',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LunarYearPage extends StatefulWidget {
  @override
  _LunarYearPageState createState() => _LunarYearPageState();
}

class _LunarYearPageState extends State<LunarYearPage> {
  final _yearController = TextEditingController();
  String _lunarYear = "";

  void _convertToLunarYear() {
    // Lấy năm dương lịch từ ô nhập
    int year = int.tryParse(_yearController.text) ?? 0;

    if (year > 0) {
      // Tính toán năm âm lịch (lấy năm dương lịch trừ đi 1 vì năm âm lịch bắt đầu từ khoảng tháng 1-2)
      int lunarYear = year;

      // Xác định tên năm âm lịch dựa trên chu kỳ 60 năm (Thiên can + Địa chi)
      List<String> heavenlyStems = [
        'Giáp',
        'Ất',
        'Bính',
        'Đinh',
        'Mậu',
        'Kỷ',
        'Canh',
        'Tân',
        'Nhâm',
        'Quý',
      ];

      List<String> earthlyBranches = [
        'Tí',
        'Sửu',
        'Dần',
        'Mão',
        'Thìn',
        'Tỵ',
        'Ngọ',
        'Mùi',
        'Thân',
        'Dậu',
        'Tuất',
        'Hợi',
      ];

      // Tính thiên can và địa chi của năm âm lịch
      int stemIndex =
          (lunarYear - 4) % 10; // Thiên can bắt đầu từ năm 4 (Giáp Tí)
      int branchIndex = (lunarYear - 4) % 12; // Địa chi bắt đầu từ năm 4 (Tí)

      // Tạo tên năm âm lịch
      String lunarYearName =
          '${heavenlyStems[stemIndex]} ${earthlyBranches[branchIndex]}';

      setState(() {
        _lunarYear = lunarYearName; // Cập nhật kết quả
      });
    } else {
      setState(() {
        _lunarYear = 'Năm không hợp lệ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tính Năm Âm Lịch")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _yearController,
              decoration: InputDecoration(labelText: 'Nhập năm dương lịch'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertToLunarYear,
              child: Text("Chuyển đổi"),
            ),
            SizedBox(height: 20),
            Text('Năm âm lịch: $_lunarYear'),
          ],
        ),
      ),
    );
  }
}
