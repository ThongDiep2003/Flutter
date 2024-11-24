import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Soft neutral background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title
            Text(
              'Welcome Admin!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 40),

            // Button to navigate to Analytics Screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/analytics');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[800], // Muted chromatic color
                foregroundColor: Colors.white, // Text/Icon color
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.analytics),
                  SizedBox(width: 8),
                  Text(
                    'View Analytics',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Button to navigate to User Management Screen
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user-management');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey[800], // Muted chromatic color
                foregroundColor: Colors.white, // Text/Icon color
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.group),
                  SizedBox(width: 8),
                  Text(
                    'Manage Users',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
