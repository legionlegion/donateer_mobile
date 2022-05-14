import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './register_details_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var _userEmail = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset('assets/images/auth_image.png',
                    height: 200, fit: BoxFit.fitWidth),
                Text('Welcome back.\nLogin to your account',
                    style: Theme.of(context).textTheme.headline1),
                SizedBox(height: 30),
                Text('— OR —'),
                SizedBox(height: 12),
                Text('Continue with your email'),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email address',
                  ),
                  onSaved: (value) {
                    _userEmail = value!;
                  },
                ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password must be at least 7 characters long.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) {
                    _userPassword = value!;
                  },
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Log in'),
                  onPressed: () async { 
                    _trySubmit();
                    UserCredential authResult = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _userEmail, password: _userPassword);
                  },
                ),
                TextButton(
                  child: Text('Create an account',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterDetailsScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
