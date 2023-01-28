import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:futebol/models/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _db = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;
  final _fs = FirebaseStorage.instance;

  Future<User2> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    final docRef = _db.collection('users').doc(email);

    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      debugPrint("Error getting document: $error");

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

      debugPrint('User Signed In Successfully');

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

  updateMap(String city, LatLng location) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    var ref = _db.collection('users').doc(email);

    ref.update({
      'city': city,
      'latitude': location.latitude,
      'longitude': location.longitude
    }).then(
      (value) => debugPrint("DocumentSnapshot successfully updated!"),
      onError: (e) => debugPrint("Error updating document $e"),
    );
  }

  updateBio(String name, String bio) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    var ref = _db.collection('users').doc(email);

    ref.update({'name': name, 'bio': bio}).then(
      (value) => debugPrint("DocumentSnapshot successfully updated!"),
      onError: (e) => debugPrint("Error updating document $e"),
    );
  }

  updateImg(List<String> urls) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    var ref = _db.collection('users').doc(email);

    ref.update({'imageUrls': urls}).then(
      (value) => debugPrint("DocumentSnapshot successfully updated!"),
      onError: (e) => debugPrint("Error updating document $e"),
    );
  }

  Future<void> uploadImage(XFile image) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? 'anonymous';

      await _fs.ref('$email/${image.name}').putFile(File(image.path));
    } catch (_) {
      debugPrint(_.toString());
    }
  }

  Future<void> deleteImage(String url) async {
    try {
      await _fs.refFromURL(url).delete();
    } catch (_) {
      debugPrint(_.toString());
    }
  }

  Future<String> getDownloadURL(String imgName) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? 'anonymous';

    String downloadURL = await _fs.ref('$email/$imgName').getDownloadURL();

    return downloadURL;
  }
}
