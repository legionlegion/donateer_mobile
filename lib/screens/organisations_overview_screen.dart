import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './organisation_details_screen.dart';

class OrganisationsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Organisations')
                    .snapshots(),
                builder: (ctx, AsyncSnapshot streamSnapshot) {
                  final documents = streamSnapshot.data.docs;
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
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
