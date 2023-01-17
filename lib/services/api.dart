import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:futebol/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<User2> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    final docRef = db.collection('users').doc(email);

    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      if (kDebugMode) {
        print("Error getting document: $error");
      }

      throw Exception(error);
    });

    final data = value.data() as Map<String, dynamic>;
    return User2.fromJSON(data);
  }
}
