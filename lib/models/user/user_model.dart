import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static List<User> users = [
    const User(
        id: 1,
        email: 'foo3@gmail.com',
        name: 'Alex',
        bio: 'Lorem Ipsum',
        imageUrls: [
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
        ],
        location: Location(xCoordinate: "0", yCoordinate: "0", name: "Hanoi"),
        log: [],
        ratings: []),
    const User(
        id: 1,
        email: 'foo3@gmail.com',
        name: 'Alex',
        bio: 'Lorem Ipsum',
        imageUrls: [
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
        ],
        location: Location(xCoordinate: "0", yCoordinate: "0", name: "Hanoi"),
        log: [],
        ratings: []),
    const User(
        id: 1,
        email: 'foo3@gmail.com',
        name: 'Alex',
        bio: 'Lorem Ipsum',
        imageUrls: [
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
        ],
        location: Location(xCoordinate: "0", yCoordinate: "0", name: "Hanoi"),
        log: [],
        ratings: []),
    const User(
        id: 1,
        email: 'foo3@gmail.com',
        name: 'Alex',
        bio: 'Lorem Ipsum',
        imageUrls: [
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg',
          'https://image.thanhnien.vn/w1024/Uploaded/2023/oqivotiw/2023_01_08/real-madrid-7731.jpeg'
        ],
        location: Location(xCoordinate: "0", yCoordinate: "0", name: "Hanoi"),
        log: [],
        ratings: []),
  ];

  @override
  List<Object?> get props =>
      [id, email, name, bio, imageUrls, location, elo, log, ratings];
}

Stream<User> getUser() {
  final FirebaseFirestore _ff = FirebaseFirestore.instance;

  return _ff.collection('users').doc('JQKj3U7G2uRFxtNR4Pbv').snapshots().map(
        (event) => User.fromSnapshot(event),
      );
}

Future<String> getDownloadURL(String imgName) async {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final prefs = await SharedPreferences.getInstance();

  String email = prefs.getString('email') ?? 'anonymous';

  String downloadURL = await storage.ref('$email/$imgName').getDownloadURL();

  return downloadURL;
}

Future<void> updateUserPictures(String imgName) async {
  final FirebaseFirestore _ff = FirebaseFirestore.instance;

  String downloadUrl = await getDownloadURL(imgName);

  return _ff.collection('users').doc('JQKj3U7G2uRFxtNR4Pbv').update(
    {
      'imageUrls': FieldValue.arrayUnion(
        [downloadUrl],
      ),
    },
  );
}
