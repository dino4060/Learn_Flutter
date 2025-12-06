import 'package:flutter/material.dart';

// --- MÔ HÌNH DỮ LIỆU ---
// Mô hình Môn Học
class Subject {
  final String name;
  final String assetPath; // Đường dẫn đến ảnh mô tả môn học

  Subject(this.name, this.assetPath);
}

// Mô hình Sinh Viên
class Student {
  final String name;

  Student(this.name);
}

// Mô hình Điểm Môn Học (Lưu trữ)
class GradeEntry {
  final DateTime date;
  final double score;
  final int coefficient; // Hệ số
  final Subject subject;
  final Student student;

  GradeEntry({
    required this.date,
    required this.score,
    required this.coefficient,
    required this.subject,
    required this.student,
  });

  // Tạo tiêu đề hiển thị trong danh sách
  String get displayTitle =>
      'Sinh viên: ${student.name}\nĐiểm: ${score.toStringAsFixed(0)}';
}

// --- DỮ LIỆU GIẢ LẬP ---
final List<Subject> subjectsList = [
  Subject('Phát triển Desktop App', 'assets/subjects/dotnet.png'), // Giả định
  Subject('Phát triển Web App', 'assets/subjects/spring.png'), // Giả định
  Subject('Phát triển Mobile App', 'assets/subjects/flutter.png'), // Giả định
];

final List<Student> studentsList = [
  Student('Nguyễn Hữu Đình Lân'),
  Student('Nguyễn Hữu Xuân Thắng'),
  Student('Nguyễn Thảo Linh'),
  Student('Nguyễn Hữu Quý Dương'),
];

// --- WIDGET CHÍNH ---
class GradeManagementScreen extends StatefulWidget {
  const GradeManagementScreen({super.key});

  @override
  State<GradeManagementScreen> createState() => _GradeManagementScreenState();
}

class _GradeManagementScreenState extends State<GradeManagementScreen> {
  // Trạng thái nhập liệu
  final TextEditingController _dateController = TextEditingController(
    text: '08/09/2025',
  ); // Giá trị mặc định
  final TextEditingController _scoreController = TextEditingController();
  final TextEditingController _coefficientController = TextEditingController();

  // Trạng thái lựa chọn Dropdown
  Subject? _selectedSubject;
  Student? _selectedStudent;

  // Danh sách các mục đã thêm
  final List<GradeEntry> _gradeEntries = [
    // Dữ liệu mẫu (nếu cần)
    GradeEntry(
      date: DateTime.now(),
      score: 8,
      coefficient: 2,
      subject: subjectsList[0],
      student: studentsList[3],
    ), // Nguyễn Hữu Quý Dương
  ];

  @override
  void initState() {
    super.initState();
    _selectedSubject = subjectsList.first;
    _selectedStudent = studentsList.first;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _scoreController.dispose();
    _coefficientController.dispose();
    super.dispose();
  }

  // --- HÀM XỬ LÝ SỰ KIỆN ---

  void _addGradeEntry() {
    final score = double.tryParse(_scoreController.text);
    final coefficient = int.tryParse(_coefficientController.text);

    if (score == null ||
        coefficient == null ||
        _selectedSubject == null ||
        _selectedStudent == null) {
      // Có thể hiển thị SnackBar báo lỗi
      return;
    }

    setState(() {
      final newEntry = GradeEntry(
        date: DateTime.now(), // Sử dụng ngày hiện tại thay vì giá trị text
        score: score,
        coefficient: coefficient,
        subject: _selectedSubject!,
        student: _selectedStudent!,
      );
      _gradeEntries.add(newEntry);
    });

    // Hiển thị thông báo "Đã thêm thành công"
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã thêm thành công')));

    // Xóa các trường nhập liệu sau khi thêm
    _scoreController.clear();
    _coefficientController.clear();
  }

  void _handleEdit(GradeEntry entry) {
    // Logic 'Sửa' (ví dụ: Tải thông tin của entry lên các trường nhập liệu)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Chức năng Sửa: Đang chỉnh sửa điểm của ${entry.student.name}',
        ),
      ),
    );
  }

  void _handleDelete(GradeEntry entry) {
    // Logic 'Xóa'
    setState(() {
      _gradeEntries.remove(entry);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa điểm của ${entry.student.name}')),
    );
  }

  void _handleClear() {
    // Xóa tất cả các trường nhập liệu
    setState(() {
      _scoreController.clear();
      _coefficientController.clear();
      _selectedSubject = subjectsList.first;
      _selectedStudent = studentsList.first;
    });
  }

  // --- XÂY DỰNG GIAO DIỆN ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUẢN LÝ ĐIỂM MÔN HỌC'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Phần Nhập liệu chính ---
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Ngày cập nhật'),
              keyboardType: TextInputType.datetime,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _scoreController,
                    decoration: const InputDecoration(labelText: 'Nhập điểm'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _coefficientController,
                    decoration: const InputDecoration(labelText: 'Hệ số'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- Dropdown Môn Học ---
            const Text(
              'Danh sách môn học',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<Subject>(
              isExpanded: true,
              value: _selectedSubject,
              onChanged: (Subject? newValue) {
                setState(() {
                  _selectedSubject = newValue;
                });
              },
              items: subjectsList.map<DropdownMenuItem<Subject>>((
                Subject subject,
              ) {
                return DropdownMenuItem<Subject>(
                  value: subject,
                  child: Text(subject.name),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // --- Dropdown Sinh Viên ---
            const Text(
              'Danh sách sinh viên',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<Student>(
              isExpanded: true,
              value: _selectedStudent,
              onChanged: (Student? newValue) {
                setState(() {
                  _selectedStudent = newValue;
                });
              },
              items: studentsList.map<DropdownMenuItem<Student>>((
                Student student,
              ) {
                return DropdownMenuItem<Student>(
                  value: student,
                  child: Text(student.name),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // --- Nhóm Nút Thao Tác ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _addGradeEntry,
                  child: const Text('Thêm'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Xóa'),
                ), // Xử lý Xóa sau
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Sửa'),
                ), // Xử lý Sửa sau
                ElevatedButton(
                  onPressed: _handleClear,
                  child: const Text('Clear'),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // --- Danh sách Điểm (ListView) ---
            const Text(
              'Danh sách điểm',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _gradeEntries.length,
              itemBuilder: (context, index) {
                final entry = _gradeEntries[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    // Hiển thị ảnh môn học (giả định path đúng)
                    leading: entry.subject.assetPath.isNotEmpty
                        ? Image.asset(
                            entry.subject.assetPath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.subject,
                                  size: 50,
                                ), // Icon nếu ảnh lỗi
                          )
                        : const Icon(Icons.subject, size: 50),
                    title: Text(
                      entry.displayTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Môn: ${entry.subject.name} | Hệ số: ${entry.coefficient}',
                    ),
                    onTap: () {
                      // Yêu cầu: Khi chọn dòng thông tin sinh viên sẽ hiển thị tương ứng lên từng text
                      _scoreController.text = entry.score.toString();
                      _coefficientController.text = entry.coefficient
                          .toString();
                      setState(() {
                        _selectedSubject = entry.subject;
                        _selectedStudent = entry.student;
                      });
                    },
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => _handleEdit(entry),
                          child: const Text('Sửa'),
                        ),
                        TextButton(
                          onPressed: () => _handleDelete(entry),
                          child: const Text(
                            'Xóa',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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
      title: 'Quản Lý Điểm Môn Học',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Import và sử dụng GradeManagementScreen
      home: const GradeManagementScreen(),
    );
  }
}
