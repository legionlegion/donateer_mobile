import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import './organisation_details_screen.dart';

class AfterDonationScreen extends StatelessWidget {
  final Map obj;
  final User user;

  AfterDonationScreen({Key? key, required this.obj, required this.user}) : super(key: key);

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
                    builder: (context) => OrganisationDetailsScreen(obj: obj, user: user),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: obj["videoUrl"],
                flags: const YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Text(obj["donateMessage"]),
            ),
          ],
        ),
      ),
    );
  }
}
