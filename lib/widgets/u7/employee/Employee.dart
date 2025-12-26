class Employee {
  final int id;
  final String name;
  final String position;
  final int age;
  final double salary;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.age,
    required this.salary,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      age: json['age'],
      salary: json['salary'].toDouble(),
    );
  }
}