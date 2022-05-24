import 'dart:async';

import 'package:donateer/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './profile_screen.dart';
import './login_screen.dart';

class RegisterIncomeScreen extends StatefulWidget {
  RegisterIncomeScreen({
    Key? key,
    this.userEmail,
    this.userName,
    this.userPassword,
    this.user,
  }) : super(key: key);

  String? userEmail;
  String? userName;
  String? userPassword;
  User? user;

  @override
  _RegisterIncomeScreenState createState() => _RegisterIncomeScreenState();
}

class _RegisterIncomeScreenState extends State<RegisterIncomeScreen> {
  String _dropdownvalue = 'Below \$1000';
  var _isLoading = false;
  var isGoogleUser;

  void initState() {
    isGoogleUser = widget.user != null;
  }

  // List of items in our dropdown menu
  var items = [
    'Below \$1000',
    '\$1000 to \$2999',
    '\$3000 to \$4999',
    '\$5000 to \$6999',
    '\$7000 to \$8999',
    '\$9000 to \$10999',
    '\$11000 to \$12999',
    '\$13000 to \$14999',
    '\$15000 and above',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.all(22),
              child: Column(
                children: <Widget>[
                  Text('Step 2/2:\nEnter your monthly income',
                      style: Theme.of(context).textTheme.headline1),
                  SizedBox(height: 12),
                  ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      value: _dropdownvalue,
                      isExpanded: true,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                      'This information is needed to calculate how much money should be donated according to the number of hours you choose to volunteer. It is strictly confidential and will not be disclosed to any third-parties.',
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  Spacer(),
                  ElevatedButton(
                    child: Text('Finish'),
                    onPressed: () async {
                      if (!isGoogleUser) {
                        User? user = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: widget.userEmail!,
                                password: widget.userPassword!)
                            .then((UserCredential userCredential) {return userCredential.user});
                        await user!.updateDisplayName(widget.userName).then((value) => null);

                        await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(user.uid)
                          .set({
                        'username': widget.userName,
                        'email': widget.userEmail,
                        'income': _dropdownvalue,
                      });
                      } else {
                        await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.user!.uid)
                          .set({
                            'username': widget.userName,
                            'email': widget.userEmail,
                            'income': _dropdownvalue,
                        });
                      };
                      Navigator.of(context)
                        .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) =>
                                TabsScreen(),
                          ),
                          ModalRoute.withName('/'),
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
