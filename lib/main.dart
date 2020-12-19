import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/place_screen.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/signup_screen.dart';
import './screens/bills_screen.dart';
import './screens/bill_screen.dart';
import './screens/qr_screen.dart';

import 'package:flutter/services.dart' ;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
 
    return MaterialApp(
      title: 'Ghumakkad',
      theme: ThemeData(
        primaryColor: Colors.teal,
        accentColor: Colors.tealAccent,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snap) {
          if (snap.hasData) return HomeScreen();
          return LoginScreen();
        },
      ),
      routes: {
        HomeScreen.routeName: (ctx) => HomeScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        PlaceScreen.routeName: (ctx) => PlaceScreen(),
        QRScreen.routeName: (ctx) => QRScreen(),
        BillsScreen.routeName: (ctx) => BillsScreen(),
        BillScreen.routeName: (ctx) => BillScreen(),
      },
    );
  }
}
