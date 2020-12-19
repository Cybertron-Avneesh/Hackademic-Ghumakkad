import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/signup_screen.dart';

class LoginCard extends StatefulWidget {
  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;
  final _passwordFN = FocusNode();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  @override
  void dispose() {
    super.dispose();
    _passwordFN.dispose();
  }

  Future<void> _saveForm() async {
    final _auth = FirebaseAuth.instance;
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await _auth.signInWithEmailAndPassword(
        email: _authData['email'],
        password: _authData['password'],
      );
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
          height: MediaQuery.of(context).size.height*0.15,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,


        ),
         Container(
           
      
        padding: EdgeInsets.only(
          left:MediaQuery.of(context).size.height*0.04 ,
          right: MediaQuery.of(context).size.height*0.04,
          
        ),
        // height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:MediaQuery.of(context).size.height*0.05  ,),
             
                Align(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor:Colors.white,
                                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 120,
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
                        cursorColor: Theme.of(context).primaryColor,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
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
                        cursorColor: Theme.of(context).primaryColor,
                        focusNode: _passwordFN,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.length < 6) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['password'] = value;
                        },
                      ),
                      SizedBox(height: 20),
                      _isLoading
                          ? CircularProgressIndicator()
                          : FloatingActionButton.extended(
                              onPressed: _saveForm,
                              label: Text(
                                'Log In',
                                style: TextStyle(color: Colors.black),
                              ),
                              icon: Icon(Icons.login, color: Colors.black),
                              heroTag: null,
                              elevation: 2,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(SignupScreen.routeName);
                        },
                        child: Text(
                          'Create An Account',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
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
