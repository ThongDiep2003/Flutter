import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'auth/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool loading = false;

  Future<void> handleLogin() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuthService.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print('Login failed: $e');
    } finally {
      setState(() {
        loading = false;
      });
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
            loading ? CircularProgressIndicator() : ElevatedButton(onPressed: handleLogin, child: Text("Login")),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/forgot_password'), child: Text("Forgot Password")),
            TextButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: Text("Register")),
          ],
        ),
      ),
    );
  }
}
