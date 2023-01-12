import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'location_model.dart';
import 'match_result_model.dart';
import 'rating_model.dart';

class User extends Equatable {
  final int id;
  final String email;
  final String name;
  final String bio;
  final List<String> imageUrls;
  final Location location;
  final int elo;
  final List<MatchResult> log;
  final List<Rating> ratings;

  const User(
      {required this.id,
      required this.email,
      required this.name,
      required this.bio,
      required this.imageUrls,
      required this.location,
      this.elo = 1800,
      required this.log,
      required this.ratings});

  static User fromSnapshot(DocumentSnapshot snap) {
    User user = User(
        id: snap['id'],
        email: snap['email'],
        name: snap['name'],
        bio: snap['bio'],
        imageUrls: snap['imageUrls'],
        location:
            const Location(xCoordinate: "0", yCoordinate: "0", name: "Hanoi"),
        log: const [],
        ratings: const []);

    return user;
  }

  static List<User> users = [];

  @override
  List<Object?> get props =>
      [id, email, name, bio, imageUrls, location, elo, log, ratings];
}
