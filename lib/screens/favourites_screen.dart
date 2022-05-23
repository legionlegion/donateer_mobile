import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(22),
        child: Column(children: [
          Text(
            'Favourites',
            style: Theme.of(context).textTheme.headline1,
          ),
        ]));
  }
}
