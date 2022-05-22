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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          Card(
            color: Theme.of(context).secondaryHeaderColor,
            child: Column(
              children: [
                ListTile(
                    leading: Padding(
                        padding: EdgeInsets.all(5),
                        child: Image.asset('assets/images/progress.png')),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                    title: Text(
                      'My Progress',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
          
          const SizedBox(height: 15),
          Text('SUPPORT'),
          const SizedBox(height: 5),
          Card(
            child: Column(
              children: [
                ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                    title: Text('CONTACT US',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ))),
                ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {},
                    ),
                    title: Text('FAQ',
                        style: const TextStyle(
                          fontSize: 14.0,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
