import 'package:flutter/material.dart';

class DemoHomeScreen extends StatelessWidget {
  const DemoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Dashboard'),
      ),
      body: const Center(
        child: Text(
          'Chỉ Admin mới sử dụng được ứng dụng này.',
          style: TextStyle(fontSize: 20, color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
