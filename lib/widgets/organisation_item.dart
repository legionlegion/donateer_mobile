import 'package:flutter/material.dart';
import '../models/organisation.dart';

class OrganisationItem extends StatelessWidget {
  //final Organisation organisation;

  //ProductItem(this.organisation);

  void toggleFavourite(String organisationName) {
    
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            //leading: Icon(Icons.arrow_drop_down_circle),   // to add organisation logo
            trailing: IconButton(
              icon: const Icon(Icons.favorite_outline_rounded),
              onPressed: () {},
            ),
            title: const Text('Card title 1',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Image.network(
              'https://media-exp1.licdn.com/dms/image/C5622AQHdCZ0mVUUOWQ/feedshare-shrink_2048_1536/0/1650526293171?e=2147483647&v=beta&t=INjnjNGSC55gQBQAcRtsLqExMzniOYMUAmOLMfeKRZM',
              height: 145,
              fit: BoxFit.fitWidth),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          
        ],
      ),
    );
  }
}
