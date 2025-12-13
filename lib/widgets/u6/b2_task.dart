import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Công việc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      home: TaskManagementScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Task {
  int id;
  String tenCongViec;
  String moTa;
  bool hoanThanh;

  Task({
    required this.id,
    required this.tenCongViec,
    required this.moTa,
    this.hoanThanh = false,
  });
}

class TaskManagementScreen extends StatefulWidget {
  @override
  _TaskManagementScreenState createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final _tenCongViecController = TextEditingController();
  final _moTaController = TextEditingController();
  final _searchController = TextEditingController();

  List<Task> _tasks = [];
  List<Task> _filteredTasks = [];
  int _nextId = 1;
  int? _selectedTaskId;

  @override
  void initState() {
    super.initState();
    // Dữ liệu mẫu
    _tasks = [
      Task(
        id: _nextId++,
        tenCongViec: 'Học Flutter',
        moTa: 'Hoàn thành khóa học Flutter cơ bản',
        hoanThanh: false,
      ),
      Task(
        id: _nextId++,
        tenCongViec: 'Làm bài tập',
        moTa: 'Bài tập về quản lý công việc',
        hoanThanh: false,
      ),
      Task(
        id: _nextId++,
        tenCongViec: 'Đi chợ',
        moTa: 'Mua rau củ quả',
        hoanThanh: true,
      ),
    ];
    _filteredTasks = List.from(_tasks);
  }

  void _clearForm() {
    _tenCongViecController.clear();
    _moTaController.clear();
    setState(() {
      _selectedTaskId = null;
    });
  }

  void _addTask() {
    if (_tenCongViecController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập tên công việc')));
      return;
    }

    setState(() {
      _tasks.add(
        Task(
          id: _nextId++,
          tenCongViec: _tenCongViecController.text,
          moTa: _moTaController.text,
          hoanThanh: false,
        ),
      );
      _filterTasks();
    });

    _clearForm();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã thêm công việc mới')));
  }

  void _updateTask() {
    if (_selectedTaskId == null) return;

    if (_tenCongViecController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Vui lòng nhập tên công việc')));
      return;
    }

    setState(() {
      int index = _tasks.indexWhere((t) => t.id == _selectedTaskId);
      if (index != -1) {
        _tasks[index].tenCongViec = _tenCongViecController.text;
        _tasks[index].moTa = _moTaController.text;
      }
      _filterTasks();
    });

    _clearForm();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã cập nhật công việc')));
  }

  void _deleteTask(int id) {
    setState(() {
      _tasks.removeWhere((t) => t.id == id);
      _filterTasks();
      if (_selectedTaskId == id) {
        _clearForm();
      }
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Đã xóa công việc')));
  }

  void _deleteCompletedTasks() {
    setState(() {
      _tasks.removeWhere((t) => t.hoanThanh);
      _filterTasks();
      _clearForm();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xóa tất cả công việc hoàn thành')),
    );
  }

  void _toggleTaskStatus(int id) {
    setState(() {
      int index = _tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        _tasks[index].hoanThanh = !_tasks[index].hoanThanh;
      }
      _filterTasks();
    });
  }

  void _selectTask(Task task) {
    setState(() {
      _selectedTaskId = task.id;
      _tenCongViecController.text = task.tenCongViec;
      _moTaController.text = task.moTa;
    });
  }

  void _filterTasks() {
    String keyword = _searchController.text.toLowerCase();
    setState(() {
      if (keyword.isEmpty) {
        _filteredTasks = List.from(_tasks);
      } else {
        _filteredTasks = _tasks.where((task) {
          return task.tenCongViec.toLowerCase().contains(keyword) ||
              task.moTa.toLowerCase().contains(keyword);
        }).toList();
      }
    });
  }

  void _showAddEditDialog({Task? task}) {
    final isEdit = task != null;
    if (isEdit) {
      _tenCongViecController.text = task.tenCongViec;
      _moTaController.text = task.moTa;
      _selectedTaskId = task.id;
    } else {
      _clearForm();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? 'Sửa công việc' : 'Thêm công việc mới'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tenCongViecController,
                decoration: InputDecoration(
                  labelText: 'Tên công việc *',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _moTaController,
                decoration: InputDecoration(
                  labelText: 'Mô tả',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _clearForm();
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (isEdit) {
                _updateTask();
              } else {
                _addTask();
              }
              Navigator.pop(context);
            },
            child: Text(isEdit ? 'Cập nhật' : 'Thêm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int completedCount = _tasks.where((t) => t.hoanThanh).length;
    int totalCount = _tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Công việc'),
        actions: [
          if (completedCount > 0)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              tooltip: 'Xóa công việc đã hoàn thành',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Xác nhận'),
                    content: Text(
                      'Bạn có chắc muốn xóa tất cả công việc đã hoàn thành?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Hủy'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _deleteCompletedTasks();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text('Xóa'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Thanh tìm kiếm
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm công việc...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterTasks();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) => _filterTasks(),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng: $totalCount công việc',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      'Hoàn thành: $completedCount',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Danh sách công việc
          Expanded(
            child: _filteredTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _searchController.text.isNotEmpty
                              ? Icons.search_off
                              : Icons.task_alt,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 16),
                        Text(
                          _searchController.text.isNotEmpty
                              ? 'Không tìm thấy công việc'
                              : 'Chưa có công việc nào',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredTasks.length,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];

                      return Card(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        elevation: 2,
                        child: ListTile(
                          leading: Checkbox(
                            value: task.hoanThanh,
                            onChanged: (value) => _toggleTaskStatus(task.id),
                            activeColor: Colors.green,
                          ),
                          title: Text(
                            task.tenCongViec,
                            style: TextStyle(
                              decoration: task.hoanThanh
                                  ? TextDecoration.lineThrough
                                  : null,
                              color: task.hoanThanh
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: task.moTa.isNotEmpty
                              ? Text(
                                  task.moTa,
                                  style: TextStyle(
                                    color: task.hoanThanh
                                        ? Colors.grey[400]
                                        : Colors.grey[700],
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _showAddEditDialog(task: task),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Xác nhận xóa'),
                                      content: Text(
                                        'Bạn có chắc muốn xóa công việc này?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Hủy'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            _deleteTask(task.id);
                                            Navigator.pop(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                          ),
                                          child: Text('Xóa'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEditDialog(),
        icon: Icon(Icons.add),
        label: Text('Thêm công việc'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  void dispose() {
    _tenCongViecController.dispose();
    _moTaController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
