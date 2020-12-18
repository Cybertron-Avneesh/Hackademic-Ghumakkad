import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Container(
        child: Center(
          child: Text("Signup Screen"),
        ),
      ),
    );
  }
}
