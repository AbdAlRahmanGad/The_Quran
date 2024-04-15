import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_quran/features/auth/model/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signUp(String email, String password) async {
    final UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    return UserModel(
      id: userCredential.user?.uid,
      email: userCredential.user?.email ?? '',
      displayName: userCredential.user?.displayName ?? '',
    );
  }

  Future<UserModel?> login(String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return UserModel(
      id: userCredential.user?.uid,
      email: userCredential.user?.email ?? '',
      displayName: userCredential.user?.displayName ?? '',
    );
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
