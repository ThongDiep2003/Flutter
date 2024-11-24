import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  final FirebaseAnalytics analytics;

  AnalyticsScreen({required this.analytics});

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('users');
  List<int> _userCountsPerMonth = List.filled(12, 0);

  @override
  void initState() {
    super.initState();
    _fetchUserCounts();
  }

  Future<void> _fetchUserCounts() async {
    try {
      final usersSnapshot = await _dbRef.get();
      final users = usersSnapshot.value as Map<dynamic, dynamic>?;

      if (users != null) {
        List<int> counts = List.filled(12, 0);

        for (var user in users.values) {
          if (user is Map && user['timestamp'] != null) {
            final timestamp = user['timestamp'] as int;
            final date = DateTime.fromMillisecondsSinceEpoch(timestamp);

            counts[date.month - 1]++;
          }
        }

        setState(() {
          _userCountsPerMonth = counts;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Analytics Dashboard',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Users Registered Per Month',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 200, // Kích thước nhỏ hơn cho biểu đồ
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: (_userCountsPerMonth.reduce((a, b) => a > b ? a : b) + 2).toDouble(),
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              months[value.toInt() % 12],
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          );
                        },
                        interval: 1,
                      ),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: _userCountsPerMonth
                      .asMap()
                      .entries
                      .map((entry) => BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.toDouble(),
                                color: Colors.blueAccent,
                                width: 12, // Thanh nhỏ hơn
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Total Users: ${_userCountsPerMonth.reduce((a, b) => a + b)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
