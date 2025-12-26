import 'package:flutter_application_1/widgets/u7/employee/Employee.dart';

Future<List<Employee>> fetchEmployees() async {
  await Future.delayed(const Duration(seconds: 2)); // Chờ 2 giây giả lập mạng

  final List<Map<String, dynamic>> mockJson = [
    {
      "id": 1,
      "name": "Nguyễn Văn A",
      "position": "Developer",
      "age": 25,
      "salary": 15000000.0,
    },
    {
      "id": 2,
      "name": "Trần Thị B",
      "position": "Designer",
      "age": 23,
      "salary": 12000000.0,
    },
    {
      "id": 3,
      "name": "Lê Văn C",
      "position": "Project Manager",
      "age": 30,
      "salary": 25000000.0,
    },
    {
      "id": 4,
      "name": "Phạm Minh D",
      "position": "QA Engineer",
      "age": 27,
      "salary": 14000000.0,
    },
    {
      "id": 5,
      "name": "Hoàng Thị E",
      "position": "HR Manager",
      "age": 32,
      "salary": 18000000.0,
    },
    {
      "id": 6,
      "name": "Vũ Văn F",
      "position": "Mobile Developer",
      "age": 26,
      "salary": 16000000.0,
    },
    {
      "id": 7,
      "name": "Đặng Thị G",
      "position": "UI/UX Designer",
      "age": 24,
      "salary": 13000000.0,
    },
    {
      "id": 8,
      "name": "Bùi Văn H",
      "position": "Backend Developer",
      "age": 29,
      "salary": 20000000.0,
    },
    {
      "id": 9,
      "name": "Ngô Thị I",
      "position": "Business Analyst",
      "age": 28,
      "salary": 19000000.0,
    },
    {
      "id": 10,
      "name": "Lý Văn J",
      "position": "DevOps Engineer",
      "age": 31,
      "salary": 22000000.0,
    },
  ];

  return mockJson.map((json) => Employee.fromJson(json)).toList();
}
