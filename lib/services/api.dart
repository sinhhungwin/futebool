import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart' as model;

class ApiService {
  final _db = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;
  final _fs = FirebaseStorage.instance;

  Future<model.User> getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    final docRef = _db.collection('users').doc(email);
    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      debugPrint("Error getting document: $error");

      throw Exception(error);
    });

    final data = value.data() as Map<String, dynamic>;
    return model.User.fromJSON(data);
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

  Future<String> uploadImage(XFile image) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      String email = prefs.getString('email') ?? 'anonymous';

      await _fs.ref('$email/${image.name}').putFile(File(image.path));

      String url = await getDownloadURL(image.name);
      return url;
    } catch (_) {
      debugPrint(_.toString());
      return '';
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

  Future<List<String>> getAllUrls() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? 'anonymous';

    List<String> urls = [];

    ListResult res = await _fs.ref(email).listAll();
    for (var item in res.items) {
      String downloadURL = await _fs.ref(item.fullPath).getDownloadURL();
      urls.add(downloadURL);
    }

    return urls;
  }

  Future<List<model.User>> getAllUsers() async {
    List<model.User> res = [];
    final docRef =
        await _db.collection('users').get().onError((error, stackTrace) {
      debugPrint("Error getting document: $error");

      throw Exception(error);
    });

    for (var doc in docRef.docs) {
      final data = doc.data();
      res.add(model.User.fromJSON(data));
    }
    return res;
  }
}
