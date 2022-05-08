import 'package:flutter/foundation.dart';

class Organisation {
  final String name;
  final String description;
  final List<String> categories;
  final String website;
  final String contactNo;
  final String email;
  final String imageUrl;
  final String donateMessage;
  // bool isFavourite; //maybe no need this if firebase used?

  Organisation({
    required this.name,
    required this.description,
    required this.categories,
    required this.website,
    required this.contactNo,
    required this.email,
    required this.imageUrl,
    required this.donateMessage
  });
}