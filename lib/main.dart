import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';
import './screens/organisations_overview_screen.dart';
import './screens/organisation_details_screen.dart';
import './screens/profile_screen.dart';
import './screens/favourites_screen.dart';

import './widgets/organisation_item.dart'; // to remove

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

        primaryColor: Colors.red[50],
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Buenard',
              color: Colors.red[900]), // page titles
          //headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          //bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.black,
            ), //button color
            foregroundColor: MaterialStateProperty.all<Color>(
              Color(0xffffffff),
            ), //text (and icon)
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(
              Colors.black,
            ),
          ),
        ),
      ),
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return ProfileScreen();
            }
            return AuthScreen();
          }),
      routes: {
        '/profile': (ctx) => ProfileScreen(),
        '/favourite': (ctx) => FavouritesScreen(),
        '/home': (ctx) => OrganisationsOverviewScreen(),
        '/organisation-detail': (ctx) => OrganisationDetailsScreen(),
      },
    );
  }
}
