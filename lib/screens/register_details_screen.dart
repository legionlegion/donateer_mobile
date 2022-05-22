import 'package:flutter/material.dart';
import './register_income_screen.dart';
import './login_screen.dart';

class RegisterDetailsScreen extends StatefulWidget {
  @override
  _RegisterDetailsScreenState createState() => _RegisterDetailsScreenState();
}

class _RegisterDetailsScreenState extends State<RegisterDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordTextController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterIncomeScreen(
              userEmail: _emailTextController.text,
              userName: _usernameController.text,
              userPassword: _passwordTextController.text),
        ),
        (route) => false,
      );
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
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Step 1/2:\nEnter your details \nto create an account',
                  style: Theme.of(context).textTheme.headline1,
                ),
                SizedBox(height: 12),
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
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return 'Please enter at least 4 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Username'),
                  controller: _usernameController,
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
                  child: Text('Continue'),
                  onPressed: _trySubmit,
                ),
                TextButton(
                  child: Text('Already have an account? Log In',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      )),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
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
