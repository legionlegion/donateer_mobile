import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart'; // to remove
import './screens/register_details_screen.dart';
import './screens/register_income_screen.dart';
import './screens/organisations_overview_screen.dart';
import './screens/organisation_details_screen.dart';
import './screens/profile_screen.dart';
import './screens/favourites_screen.dart';
import './screens/login_screen.dart';

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
        primarySwatch: Colors.red,
        primaryColor: HexColor('#FFFBFE'),
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Buenard',
              color: Colors.red[900]), // page titles
          headline2: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          //bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 45),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            primary: Colors.black, //button color
            onPrimary: Colors.white,
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
              print("wtf");
              return ProfileScreen();
            }
            print("here");
            return OrganisationsOverviewScreen();
          }),
      routes: {
        '/profile': (ctx) => ProfileScreen(),
        '/favourite': (ctx) => FavouritesScreen(),
        '/home': (ctx) => OrganisationsOverviewScreen(),
      },
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
