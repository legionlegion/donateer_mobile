import 'package:donateer/screens/profile_screen.dart';
import 'package:donateer/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TabsScreen(tabNo: 2),
                        ),
                        (route) => false,
                      );
                    }),
                Text(
                  'My Progress',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ]),
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
