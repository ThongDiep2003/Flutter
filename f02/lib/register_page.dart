import 'package:flutter/material.dart';
import 'auth/firebase_auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> handleRegister() async {
    try {
      await FirebaseAuthService.signUp(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print("Registration failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password")),
            TextField(controller: confirmPasswordController, decoration: InputDecoration(labelText: "Confirm Password")),
            ElevatedButton(onPressed: handleRegister, child: Text("Register")),
          ],
        ),
      ),
    );
  }
}
