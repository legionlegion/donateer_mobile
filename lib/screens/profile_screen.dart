import 'package:donateer/provider/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import './login_screen.dart';
import './progress_screen.dart';

class ProfileScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Padding(
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
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(
                      context,
                      listen: false,
                    );
                    // check if Google is used, if used then sign out
                    final GoogleSignIn googleSignIn = new GoogleSignIn();
                    googleSignIn.isSignedIn().then((s) {
                      provider.logout();
                    });
                    await FirebaseAuth.instance.signOut();
                    // Navigator.of(context).pushAndRemoveUntil(
                    //   MaterialPageRoute(
                    //     builder: (context) => LoginScreen(),
                    //   ),
                    //   ModalRoute.withName('/'),
                    // );
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
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
                    user!.displayName![0],
                    style: TextStyle(
                      fontSize: 30.0,
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Text(user!.displayName!,
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
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => ProgressScreen(),
                            ),
                          );
                        },
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
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text('hours', textAlign: TextAlign.center),
                      subtitle: Text('total volunteered',
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text('hours', textAlign: TextAlign.center),
                      subtitle: Text('pending volunteer',
                          textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text('\$', textAlign: TextAlign.center),
                      subtitle:
                          Text('total donated', textAlign: TextAlign.center),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: Text('\$', textAlign: TextAlign.center),
                      subtitle:
                          Text('pending donation', textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Spacer(),
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
      ),
    );
  }
}
