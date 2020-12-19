import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/login_screen.dart';

class SignupCard extends StatefulWidget {
  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordController = TextEditingController();
  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _confirmPasswordFN = FocusNode();
  Map<String, Object> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _emailFN.dispose();
    _passwordFN.dispose();
    _confirmPasswordFN.dispose();
  }

  Future<void> _saveForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential authResult;
      authResult = await _auth.createUserWithEmailAndPassword(
        email: _authData['email'],
        password: _authData['password'],
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user.uid)
          .set({
        'email': _authData['email'],
        'name': _authData['name'],
      });
      Navigator.of(context).pushReplacementNamed('/');
    } on PlatformException catch (err) {
      var message = 'An Error Occured, Please check your Credentials';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(err.message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Align(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.account_circle,
                      size: 120,
                      color: Colors.black,
                    ),
                  ),
                  alignment: Alignment.topCenter,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter your Name';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_emailFN);
                        },
                        onSaved: (value) {
                          _authData['name'] = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        focusNode: _emailFN,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please Enter a Valid Email Address';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_passwordFN);
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        focusNode: _passwordFN,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password is Too Short!';
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_confirmPasswordFN);
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        focusNode: _confirmPasswordFN,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not Match!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        },
                        child: Text(
                          'Already have an Account?',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      _isLoading
                          ? CircularProgressIndicator()
                          : FloatingActionButton.extended(
                              onPressed: _saveForm,
                              label: Text(
                                'Sign Up',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(Icons.confirmation_number),
                              heroTag: null,
                              elevation: 2,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
