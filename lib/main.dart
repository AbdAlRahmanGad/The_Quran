import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_quran/controller/authentication_controller.dart';
import 'package:the_quran/firebase_options.dart';
import 'package:the_quran/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthenticationController _authController = AuthenticationController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(
        authController: _authController,
      ),
    );
  }
}
