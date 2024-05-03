import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo {
  FirebaseAuth instance = FirebaseAuth.instance;

  User? fetch() {
    return instance.currentUser;
  }
}
