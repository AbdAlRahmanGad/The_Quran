import 'package:flutter/material.dart';
import 'package:the_quran/controller/authentication_controller.dart';
import 'package:the_quran/view/login_screen.dart';

class HomePage extends StatelessWidget {
  final AuthenticationController authController;

  HomePage({required this.authController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await authController.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginScreen(authController: authController)),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}