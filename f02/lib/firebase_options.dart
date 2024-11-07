import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseConfig {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }
}
