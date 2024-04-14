import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_quran/features/auth/view/page/forgot_password_screen.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';
import 'package:the_quran/features/auth/view/page/login_screen.dart';
import 'package:the_quran/features/auth/view/page/on_boarding.dart';
import 'package:the_quran/features/auth/view/page/sign_up_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:the_quran/core/utils/firebase_options.dart';

late final SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  prefs = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool onBoarding = prefs.getBool('onBoarding') ?? true;

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      title: 'The Quran',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              if (onBoarding) return const OnBoadrding();
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}

Route onGenerateRoute(RouteSettings settings) {
  if (settings.name == "Login") {
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  } else if (settings.name == "Sign Up") {
    return MaterialPageRoute(builder: (context) => const SignUpScreen());
  } else if (settings.name == "Forgot Password") {
    return MaterialPageRoute(
        builder: (context) => const ForgotPasswordScreen());
  } else {
    return MaterialPageRoute(builder: (context) => const HomePage());
  }
}
