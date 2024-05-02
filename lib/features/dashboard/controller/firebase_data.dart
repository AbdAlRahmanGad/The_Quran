import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepo {
  FirebaseAuth instance = FirebaseAuth.instance;

  User? fetch() {
    return instance.currentUser;
  }

  Future<void> delete({required int id}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(id.toString()).delete().then((_) => print("User deleted"));
  }

  Future<void> insert({required String name, String? bio}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users
        .add({
          'full_name': name,
          'address': bio,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
