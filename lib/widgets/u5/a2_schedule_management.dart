import 'package:flutter/material.dart';

// --- MÔ HÌNH DỮ LIỆU ---

// 1. Giáo viên (Teacher)
class Teacher {
  final int id;
  final String name;
  final String department;

  Teacher({required this.id, required this.name, required this.department});
}

// 2. Lịch dạy (Schedule)
class Schedule {
  final int scheduleId;
  final int teacherId;
  final String subject;
  final String dayOfWeek;
  final String time;

  Schedule({
    required this.scheduleId,
    required this.teacherId,
    required this.subject,
    required this.dayOfWeek,
    required this.time,
  });
}

// --- DỮ LIỆU GIẢ LẬP VÀ DANH SÁCH BAN ĐẦU ---

final List<Teacher> teachersList = [
  Teacher(id: 1, name: 'Nguyễn Văn A', department: 'Công nghệ phần mềm'),
  Teacher(id: 2, name: 'Trần Thị B', department: 'Mạng máy tính'),
  Teacher(id: 3, name: 'Lê Hữu C', department: 'An toàn thông tin'),
];

// Danh sách các ngày trong tuần (để dùng cho Dropdown)
const List<String> daysOfWeek = [
  'Thứ Hai',
  'Thứ Ba',
  'Thứ Tư',
  'Thứ Năm',
  'Thứ Sáu',
  'Thứ Bảy',
];

// Danh sách các môn học giả định
const List<String> subjectsList = [
  'Lập trình C++',
  'Cấu trúc dữ liệu',
  'Mạng máy tính cơ bản',
  'Phát triển Web',
];

// Danh sách lịch dạy hiện tại
List<Schedule> currentSchedules = [];

// --- WIDGET CHÍNH: QUẢN LÝ LỊCH ---

class ScheduleManagementScreen extends StatefulWidget {
  const ScheduleManagementScreen({super.key});

  @override
  State<ScheduleManagementScreen> createState() =>
      _ScheduleManagementScreenState();
}

class _ScheduleManagementScreenState extends State<ScheduleManagementScreen> {
  // Trạng thái cho các trường nhập liệu
  Teacher? _selectedTeacher;
  String? _selectedSubject;
  String? _selectedDay;
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTeacher = teachersList.first;
    _selectedSubject = subjectsList.first;
    _selectedDay = daysOfWeek.first;
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }

  // --- HÀM XỬ LÝ CHỨC NĂNG ---

  // Chức năng: Kiểm tra trùng lịch (quan trọng)
  bool _checkConflict(int teacherId, String day, String time) {
    // Giảng viên không được dạy nhiều môn trong tuần, nhưng không được trùng giờ.
    return currentSchedules.any(
      (schedule) =>
          schedule.teacherId == teacherId &&
          schedule.dayOfWeek == day &&
          schedule.time == time,
    );
  }

  // Chức năng: Gán lịch dạy
  void _assignSchedule() {
    if (_timeController.text.isEmpty ||
        _selectedTeacher == null ||
        _selectedSubject == null ||
        _selectedDay == null) {
      _showSnackBar('Vui lòng điền đầy đủ thông tin!', Colors.orange);
      return;
    }

    final newTime = _timeController.text;
    final teacherId = _selectedTeacher!.id;

    // 1. Kiểm tra trùng lịch
    if (_checkConflict(teacherId, _selectedDay!, newTime)) {
      _showSnackBar(
        'LỖI: Giảng viên ${_selectedTeacher!.name} đã có lịch vào $_selectedDay lúc $newTime!',
        Colors.red,
      );
      return;
    }

    // 2. Thêm lịch dạy mới
    final newSchedule = Schedule(
      scheduleId: currentSchedules.length + 1,
      teacherId: teacherId,
      subject: _selectedSubject!,
      dayOfWeek: _selectedDay!,
      time: newTime,
    );

    setState(() {
      currentSchedules.add(newSchedule);
      _timeController.clear(); // Xóa trường giờ sau khi thêm
    });

    _showSnackBar(
      'Đã gán lịch thành công cho ${_selectedTeacher!.name}!',
      Colors.green,
    );
  }

  // Chức năng: Tìm giảng viên rảnh (ví dụ)
  void _findAvailableTeachers() {
    // Logic tìm GV rảnh: Lọc danh sách GV hiện tại chưa có lịch
    // Hiện tại chỉ demo thông báo
    _showSnackBar(
      'Chức năng tìm giảng viên rảnh chưa được triển khai chi tiết.',
      Colors.blue,
    );
  }

  // Chức năng: Liệt kê lịch theo giảng viên (hiển thị trong ListView)
  List<Schedule> _getSchedulesByTeacher(Teacher teacher) {
    return currentSchedules
        .where((schedule) => schedule.teacherId == teacher.id)
        .toList();
  }

  // Hàm hiển thị SnackBar
  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  // --- XÂY DỰNG GIAO DIỆN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUẢN LÝ LỊCH GIẢNG DẠY'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Gán Lịch Dạy ---
            const Text(
              'Gán Lịch Dạy Mới',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Dropdown Giảng viên
            DropdownButtonFormField<Teacher>(
              decoration: const InputDecoration(labelText: 'Giảng viên'),
              value: _selectedTeacher,
              items: teachersList
                  .map(
                    (t) => DropdownMenuItem(
                      value: t,
                      child: Text('${t.name} (${t.department})'),
                    ),
                  )
                  .toList(),
              onChanged: (Teacher? newValue) {
                setState(() {
                  _selectedTeacher = newValue;
                });
              },
            ),

            // Dropdown Môn học
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Môn học'),
              value: _selectedSubject,
              items: subjectsList
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubject = newValue;
                });
              },
            ),

            // Dropdown Ngày trong tuần
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Ngày trong tuần'),
              value: _selectedDay,
              items: daysOfWeek
                  .map((d) => DropdownMenuItem(value: d, child: Text(d)))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDay = newValue;
                });
              },
            ),

            // Nhập Giờ
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Giờ bắt đầu (Ví dụ: 08:00)',
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // Nút Thao tác
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _assignSchedule,
                  child: const Text('Gán Lịch Dạy'),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: _findAvailableTeachers,
                  child: const Text('Tìm GV Rảnh'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),

            const Divider(height: 40, thickness: 1),

            // --- Liệt kê lịch theo giảng viên ---
            const Text(
              'Liệt Kê Lịch Dạy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Hiển thị lịch dạy của TẤT CẢ giáo viên
            ...teachersList.map((teacher) {
              final schedules = _getSchedulesByTeacher(teacher);
              return ExpansionTile(
                title: Text(
                  teacher.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${teacher.department} (${schedules.length} lịch)',
                ),
                children: schedules.isEmpty
                    ? [
                        const Padding(
                          padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                          child: Text('Chưa có lịch dạy nào.'),
                        ),
                      ]
                    : schedules
                          .map(
                            (s) => ListTile(
                              leading: const Icon(Icons.class_rounded),
                              title: Text('${s.dayOfWeek} (${s.time})'),
                              subtitle: Text(s.subject),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                // Chức năng: Xóa lịch (đã bao gồm trong chức năng quản lý)
                                onPressed: () {
                                  setState(() {
                                    currentSchedules.remove(s);
                                  });
                                  _showSnackBar(
                                    'Đã xóa lịch của ${teacher.name} môn ${s.subject}.',
                                    Colors.red,
                                  );
                                },
                              ),
                            ),
                          )
                          .toList(),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản Lý Lịch Giảng Dạy',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Import và sử dụng ScheduleManagementScreen
      home: const ScheduleManagementScreen(),
    );
  }
}
