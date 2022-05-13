import 'package:flutter/material.dart';
import '../models/organisation.dart';
import '../widgets/organisation_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrganisationsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Organisations').snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['description']),
            ),
          );
        },
      ),
    );
    */
    return Scaffold(
       appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Organisations').snapshots(),
        builder: (ctx, AsyncSnapshot streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.docs;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['description']),
            ),
          );
        },
      ),
    );
  }
}
