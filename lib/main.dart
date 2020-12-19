import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ghummakad/screens/login_screen.dart';
import './screens/home_screen.dart';
import './screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghumakkad',
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
      ),
      home: HomeScreen(),
      routes: {
        SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
    );
  }
}
