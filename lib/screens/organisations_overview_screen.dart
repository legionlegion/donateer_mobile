import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './organisation_details_screen.dart';
import '../widgets/filter_dialog.dart';
import './tabs_screen.dart';

class OrganisationsOverviewScreen extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  final filter;

  OrganisationsOverviewScreen({Key? key, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(14),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Get Involved',
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            )
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                label: const Text('Filter'),
                icon: Icon(Icons.filter_alt_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return FilterDialog();
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
              Center(
                child: Ink(
                  width: 40,
                  decoration: ShapeDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    shape: const CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_alt_off_outlined),
                    iconSize: 19.0,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => TabsScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: (filter == null
                  ? FirebaseFirestore.instance
                      .collection('Organisations')
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection('Organisations')
                      .where('categories',
                          arrayContainsAny: filter['categories'])
                      .snapshots()),
              builder: (ctx, AsyncSnapshot streamSnapshot) {
                if (streamSnapshot.hasData) {
                  var documents = streamSnapshot.data.docs;
                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (ctx, index) => InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          ctx,
                          MaterialPageRoute(
                            builder: (ctx) => OrganisationDetailsScreen(
                                obj: documents[index].data()),
                          ),
                          (route) => false,
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(8),
                        color: Theme.of(context).primaryColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              //leading: Icon(Icons.arrow_drop_down_circle),   // to add organisation logo
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.favorite_outline_rounded),
                                onPressed: () {},
                              ),
                              title: Text(documents[index]['name'],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Image.network(documents[index]['imageUrl'],
                                height: 145, fit: BoxFit.fitWidth),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                documents[index]['description']
                                        .replaceAll("\\n", "\n")
                                        .substring(0, 90) +
                                    '...',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
