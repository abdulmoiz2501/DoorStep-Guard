import 'package:firebase_auth/firebase_auth.dart';

// Function to get the current user's UID
Future<String?> getGuardUID() async {
  String? guardUID;
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      guardUID = user.uid;
    }
  } catch (error) {
    print('Error getting guard UID: $error');
  }
  return guardUID;
}
