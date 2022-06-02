import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './organisation_details_screen.dart';
import './tabs_screen.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late Future resultsLoaded;
  List _allResults = [];
  List _resultsList = [];
  List _favourites = [];

  @override
  void initState() {
    getStreamSnapshots();
    getResultsList();
    super.initState();
  }

  getStreamSnapshots() async {
    var data =
        await FirebaseFirestore.instance.collection('Organisations').get();
    setState(() {
      _allResults = data.docs;
    });
  }

  getResultsList() async {
    var fav = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get();
    setState(() {
      if (fav['favourites'] != null) {
        _favourites = fav['favourites'];
      } else {
        _favourites = [];
      }
    });
    var results = [];
    for (var data in _allResults) {
      if (_favourites.contains(data['name'])) {
        results.add(data);
      }
    }
    setState(() {
      _resultsList = results;
    });
  }

  updateFirestoreFavourites() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .update({'favourites': _favourites});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Favourites',
            style: Theme.of(context).textTheme.headline1
          ),
          Expanded(
              child: ListView.builder(
            itemCount: _resultsList.length,
            itemBuilder: (ctx, index) => InkWell(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  ctx,
                  MaterialPageRoute(
                    builder: (ctx) => OrganisationDetailsScreen(
                        obj: _resultsList[index].data()),
                  ),
                  (route) => false,
                );
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 16.0),
                color: Theme.of(context).primaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ListTile(
                      //leading: Icon(Icons.arrow_drop_down_circle),   // to add organisation logo
                      trailing: IconButton(
                        icon: _favourites.contains(_resultsList[index]['name'])
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red[400],
                              )
                            : const Icon(Icons.favorite_outline_rounded),
                        onPressed: () async {
                          if (!_favourites
                              .contains(_resultsList[index]['name'])) {
                            setState(() {
                              _favourites.add(_resultsList[index]['name']);
                            });
                            updateFirestoreFavourites();
                          } else if (_favourites
                              .contains(_resultsList[index]['name'])) {
                            setState(() {
                              _favourites.remove(_resultsList[index]['name']);
                            });
                            updateFirestoreFavourites();
                          }
                        },
                      ),
                      title: Text(_resultsList[index]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Image.network(_resultsList[index]['imageUrl'],
                        height: 145, fit: BoxFit.fitWidth),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _resultsList[index]['description']
                                .replaceAll("\\n", "\n")
                                .substring(0, 90) +
                            '...',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
