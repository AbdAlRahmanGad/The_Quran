import 'package:flutter/material.dart';
import 'package:task/controllers/authentication_controller.dart';
import 'package:task/models/authentication_model.dart';
import 'package:task/screens/home_page.dart';
import 'package:task/screens/forgot_password_screen.dart';
import 'package:task/screens/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthenticationController authController;

  LoginScreen({required this.authController});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                if (!RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    .hasMatch(value)) {
                  return 'Password must contain at least one uppercase letter, one lowercase letter, one digit, and one special character';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  AuthenticationModel authModel = AuthenticationModel(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  try {
                    await authController.login(
                        authModel.email, authModel.password);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                authController: authController,
                              )),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  }
                }
              },
              child: Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SignUpScreen(authController: authController)),
                );
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ForgotPasswordScreen(authController: authController)),
                );
              },
              child: Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }
}
