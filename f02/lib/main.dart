import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'screens/admin/admin_home_screen.dart';
import 'screens/admin/analytics_screen.dart';
import 'screens/admin/user_manage_screen.dart';
import 'screens/admin/demo_homee_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_passwood_screen.dart';
import 'screens/introduce/introduce_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  runApp(MyApp(analytics: analytics));
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics;

  MyApp({required this.analytics});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/introduce',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      routes: {
        '/introduce': (context) => IntroduceScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/admin-home': (context) => AdminHomeScreen(),
        '/analytics': (context) => AnalyticsScreen(analytics: analytics), 
        '/user-management': (context) => UserManageScreen(),
        '/demo-home': (context) => DemoHomeScreen(),
      },
    );
  }
}
