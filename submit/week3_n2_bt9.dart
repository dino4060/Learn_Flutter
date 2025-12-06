import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chuyển động cong',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CurvedAnimationPage(),
    );
  }
}

class CurvedAnimationPage extends StatefulWidget {
  @override
  _CurvedAnimationPageState createState() => _CurvedAnimationPageState();
}

class _CurvedAnimationPageState extends State<CurvedAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Khởi tạo AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // Animation từ 0 đến 1
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Lặp lại animation liên tục
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Tính toán vị trí theo đường cong parabol
  Offset _calculatePosition(double progress, Size size) {
    // Điểm bắt đầu (góc dưới bên phải)
    double startX = size.width - 80;
    double startY = size.height - 100;

    // Điểm kết thúc (giữa màn hình, phía trên)
    double endX = size.width / 2 - 20;
    double endY = size.height / 2 - 50;

    // Tính toán vị trí X (di chuyển từ phải sang trái)
    double x = startX + (endX - startX) * progress;

    // Tính toán vị trí Y theo đường cong parabol
    // Sử dụng công thức parabol: y = a * (x - h)^2 + k
    double normalizedProgress = progress;
    double curveHeight = 100; // Độ cao của đường cong

    // Tạo đường cong từ dưới lên trên
    double y =
        startY -
        (startY - endY) * normalizedProgress -
        curveHeight * math.sin(normalizedProgress * math.pi);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyển động cong'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          Size size = MediaQuery.of(context).size;
          Offset position = _calculatePosition(_animation.value, size);

          return Stack(
            children: [
              // Vẽ đường cong (tùy chọn, để hiển thị path)
              CustomPaint(
                size: size,
                painter: CurvePainter(_animation.value, size),
              ),

              // Box di chuyển
              Positioned(
                left: position.dx,
                top: position.dy,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Custom Painter để vẽ đường cong
class CurvePainter extends CustomPainter {
  final double progress;
  final Size size;

  CurvePainter(this.progress, this.size);

  @override
  void paint(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Path path = Path();

    // Điểm bắt đầu
    double startX = size.width - 80;
    double startY = size.height - 100;

    // Điểm kết thúc
    double endX = size.width / 2 - 20;
    double endY = size.height / 2 - 50;

    path.moveTo(startX, startY);

    // Vẽ đường cong bằng cách tạo nhiều điểm
    for (double i = 0; i <= 1; i += 0.01) {
      double x = startX + (endX - startX) * i;
      double curveHeight = 100;
      double y =
          startY - (startY - endY) * i - curveHeight * math.sin(i * math.pi);
      path.lineTo(x, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
