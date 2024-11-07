import 'package:flutter/material.dart';
import 'auth/firebase_auth_service.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    await FirebaseAuthService.resetPassword(emailController.text.trim());
    print("Password reset link sent");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Enter your email")),
            ElevatedButton(onPressed: resetPassword, child: Text("Send Reset Link")),
          ],
        ),
      ),
    );
  }
}
