import 'package:donateer/provider/google_sign_in.dart';
import 'package:donateer/screens/profile_screen.dart';
import 'package:donateer/screens/register_income_screen.dart';
import 'package:donateer/screens/tabs_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import './register_details_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => TabsScreen(),
        ),
      );
    }

    return firebaseApp;
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
                  controller: _emailTextController,
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
                  controller: _passwordTextController,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  child: Text('Log in'),
                  onPressed: () async {
                    _trySubmit();
                    // UserCredential authResult =
                    //     await FirebaseAuth.instance.signInWithEmailAndPassword(
                    //   email: _emailTextController.text,
                    //   password: _passwordTextController.text,
                    // );

                    User? user =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    ).then((UserCredential userCredential) {return userCredential.user});

                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TabsScreen(),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(height: 5),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity,50),
                  ), 
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.white,),
                  label: Text('Sign In with Google'), 
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                    provider.googleLogin().then((user) => {
                      if (user != null) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RegisterIncomeScreen(user: user,),
                          ),
                        ),
                      }
                    });
                  },
                ),
                TextButton(
                  child: Text('Create an account',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),),
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
