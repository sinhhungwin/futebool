import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:futebol/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _db = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;

  Future<User2> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    final docRef = _db.collection('users').doc(email);

    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      if (kDebugMode) {
        print("Error getting document: $error");
      }

      throw Exception(error);
    });

    final data = value.data() as Map<String, dynamic>;
    return User2.fromJSON(data);
  }

  Future<String> signInWithEmail(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      UserCredential credential = await _fa
          .signInWithEmailAndPassword(email: email, password: password)
          .onError(
            (error, stackTrace) => throw Exception(error),
          );

      if (kDebugMode) {
        print('User Signed In Successfully');
      }

      return credential.user?.email ?? '';
    }

    return '';
  }

  setInitialData(Map<String, dynamic> data) async {
    await _db
        .collection('users')
        .doc(data['email'])
        .set(data)
        .onError((error, stackTrace) => throw Exception(error));
  }
}
