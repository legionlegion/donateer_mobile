import 'package:donateer/widgets/donate_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './tabs_screen.dart';

class OrganisationDetailsScreen extends StatefulWidget {
  final Map obj;
  final User user;

  const OrganisationDetailsScreen({Key? key, required this.obj, required this.user})
      : super(key: key);

  @override
  _OrganisationDetailsScreenState createState() =>
      _OrganisationDetailsScreenState();
}

class _OrganisationDetailsScreenState extends State<OrganisationDetailsScreen> {


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
                    builder: (context) => TabsScreen(widget.user),
                  ),
                  (route) => false,
                );
              }),
          title: Text(widget.obj['name']),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.favorite_outline_rounded),
                onPressed: () {})
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(widget.obj['imageUrl'],
                height: 145, fit: BoxFit.fitWidth),
            Padding(
              padding: const EdgeInsets.all(22),
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
                        const SizedBox(height: 7),
                        Text(widget.obj['description'].replaceAll("\\n", "\n")),
                        const SizedBox(height: 15),
                        Text(
                          'CONTACT',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        const SizedBox(height: 7),
                        Row(children: [
                          const Icon(Icons.laptop),
                          const Spacer(flex: 1),
                          Text(widget.obj['website']),
                          const Spacer(flex: 15),
                        ]),
                        const SizedBox(height: 5),
                        Row(children: [
                          const Icon(Icons.call),
                          const Spacer(flex: 1),
                          Text(widget.obj['contactNo']),
                          const Spacer(flex: 15),
                        ]),
                        const SizedBox(height: 5),
                        Row(children: [
                          const Icon(Icons.email),
                          const Spacer(flex: 1),
                          Text(widget.obj['email']),
                          const Spacer(flex: 15),
                        ]),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text('DONATE YOUR TIME'),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DonateDialog(name: widget.obj['name'], obj: widget.obj, user: widget.user);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
