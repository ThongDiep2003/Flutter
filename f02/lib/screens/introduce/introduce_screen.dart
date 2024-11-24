import 'package:flutter/material.dart';
import '/screens/auth/login_screen.dart'; // Thay đường dẫn theo file của bạn

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({super.key});

  @override
  _IntroduceScreenState createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  @override
  void initState() {
    super.initState();

    // Đợi 5 giây và điều hướng đến LoginScreen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Welcome",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
