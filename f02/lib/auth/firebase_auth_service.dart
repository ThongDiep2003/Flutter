import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_options.dart';

class FirebaseAuthService {
  static Future<void> signIn(String email, String password) async {
    await FirebaseConfig.auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signUp(String email, String password) async {
    await FirebaseConfig.auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> resetPassword(String email) async {
    await FirebaseConfig.auth.sendPasswordResetEmail(email: email);
  }

  static User? get currentUser => FirebaseConfig.auth.currentUser;
}
