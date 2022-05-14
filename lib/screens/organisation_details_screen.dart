import 'package:flutter/material.dart';

import './organisations_overview_screen.dart';

class OrganisationDetailsScreen extends StatelessWidget {
  final Map obj;

  const OrganisationDetailsScreen({Key? key, required this.obj})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrganisationsOverviewScreen(),
                  ),
                  (route) => false,
                );
              }),
          title: Text(obj['name']),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.favorite_outline_rounded),
                onPressed: () {})
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(obj['imageUrl'], height: 145, fit: BoxFit.fitWidth),
          Padding(
            padding: EdgeInsets.all(22),
            child: Container(
              height: MediaQuery.of(context).size.height - 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'ABOUT US',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 7),
                      Text(obj['description'].replaceAll("\\n", "\n")),
                      SizedBox(height: 15),
                      Text(
                        'CONTACT',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      SizedBox(height: 7),
                      Row(children: [
                        Icon(Icons.laptop),
                        Spacer(flex: 1),
                        Text(obj['website']),
                        Spacer(flex: 15),
                      ]),
                      SizedBox(height: 5),
                      Row(children: [
                        Icon(Icons.call),
                        Spacer(flex: 1),
                        Text(obj['contactNo']),
                        Spacer(flex: 15),
                      ]),
                      SizedBox(height: 5),
                      Row(children: [
                        Icon(Icons.email),
                        Spacer(flex: 1),
                        Text(obj['email']),
                        Spacer(flex: 15),
                      ]),
                    ],
                  ),
                  ElevatedButton(
                      child: Text('DONATE YOUR TIME'), onPressed: () {}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
