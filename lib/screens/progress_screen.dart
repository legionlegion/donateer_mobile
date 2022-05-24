import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            children: [
              Text(
                'My Progress',
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(height: 7),
              Text('PENDING CONTRIBUTIONS',
                  style: const TextStyle(
                    fontSize: 15.0,
                  )),
              const SizedBox(height: 10),
              Text('PENDING CONTRIBUTIONS',
                  style: const TextStyle(
                    fontSize: 15.0,
                  )),
              const SizedBox(height: 7),
            ],
          ),
        ),
      ),
    );
  }
}
