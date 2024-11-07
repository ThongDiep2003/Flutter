import 'package:firebase_database/firebase_database.dart';
import '../firebase_options.dart';

class UserProfileService {
  static DatabaseReference get userRef => FirebaseConfig.database.ref("users/${FirebaseConfig.auth.currentUser?.uid}");

  static Future<void> createUserProfile(String name, String email) async {
    await userRef.set({
      "name": name,
      "email": email,
    });
  }

  static Future<Map<String, dynamic>?> getUserProfile() async {
    final snapshot = await userRef.get();
    return snapshot.value as Map<String, dynamic>?;
  }
}
