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
    required this.userEmail,
    required this.userName,
    required this.userPassword,
  }) : super(key: key);

  final String userEmail;
  final String userName;
  final String userPassword;

  @override
  _RegisterIncomeScreenState createState() => _RegisterIncomeScreenState();
}

class _RegisterIncomeScreenState extends State<RegisterIncomeScreen> {
  String _dropdownvalue = 'Below \$1000';
  var _isLoading = false;

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
                  Text('Step 2/2:\nLet’s help you set an estimate of your hourly income!',
                      style: Theme.of(context).textTheme.headline1),
                  SizedBox(height: 12),
                  Text(
                      'This information is needed to calculate how much money should be donated according to the number of hours you choose to volunteer. It is strictly confidential and will not be disclosed to any third-parties.',
                      style: TextStyle(
                        fontSize: 10.0,
                      )),
                  SizedBox(height: 15),    
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
                  Text('Estimated hourly income: \$${_dropdownvalue}'),
                  
                  Spacer(),
                  ElevatedButton(
                    child: Text('Finish'),
                    onPressed: () async {

                      User? user = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: widget.userEmail,
                              password: widget.userPassword)
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

                      var duration = Duration(seconds: 1);
                      Timer(duration, () {
                         Navigator.of(context)
                          .pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) =>
                              TabsScreen(user),
                        ),
                        ModalRoute.withName('/'),
                      );
                      });

                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
