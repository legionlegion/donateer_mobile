import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!.displayName;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context).textTheme.headline1,
                ),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  radius: 40,
                  child: Text(
                    user![0],
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  
                  children: [
                    Text(user!,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        )),
                    OutlinedButton(
                      child: const Text('Edit Profile'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                )
              ],
            )
          ],
        ),
    );
  }
}
