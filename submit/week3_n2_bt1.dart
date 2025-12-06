import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
        backgroundColor: Colors.grey[300],
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),

            // Animation Gốc
            _buildAnimationSection('Gốc', FlutterLogo(size: 100)),

            SizedBox(height: 40),

            // Animation Tỉ lệ 1:1
            _buildAnimationSection(
              'Tỉ lệ 1:1',
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.5, end: 1.0),
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (context, double scale, child) {
                  return Transform.scale(scale: scale, child: child);
                },
                child: FlutterLogo(size: 100),
                onEnd: () {
                  // Lặp lại animation
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: 40),

            // Animation Xoay 90 độ
            _buildAnimationSection(
              'Xoay 90 độ',
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 0.25),
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                builder: (context, double turns, child) {
                  return Transform.rotate(
                    angle: turns * 2 * 3.14159,
                    child: child,
                  );
                },
                child: FlutterLogo(size: 100),
                onEnd: () {
                  setState(() {});
                },
              ),
            ),

            SizedBox(height: 40),

            // Animation Fade
            _buildAnimationSection('Fade', FadeAnimation()),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationSection(String title, Widget animation) {
    return Center(
      child: Column(
        children: [
          animation,
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
        ],
      ),
    );
  }
}

// Widget riêng cho Fade Animation
class FadeAnimation extends StatefulWidget {
  @override
  _FadeAnimationState createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Lặp lại animation: fade in -> fade out
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation, child: FlutterLogo(size: 100));
  }
}
