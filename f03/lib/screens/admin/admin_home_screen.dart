import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tiêu đề
            Text(
              'Welcome Admin!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // Nút chuyển đến Analytics Screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/analytics');
              },
              icon: Icon(Icons.analytics),
              label: Text('View Analytics'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
            SizedBox(height: 20),

            // Nút chuyển đến User Management Screen
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/user-management');
              },
              icon: Icon(Icons.group),
              label: Text('Manage Users'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50), // Full-width button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
