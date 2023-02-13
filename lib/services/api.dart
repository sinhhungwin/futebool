import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:futebol/models/chat/massage_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart' as model;

class ApiService {
  final _db = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;
  final _fs = FirebaseStorage.instance;

  Future<model.User> getProfileData({String email = ''}) async {
    if (email.isEmpty) {
      final prefs = await SharedPreferences.getInstance();
      email = prefs.getString('email') ?? '';
    }

    final docRef = _db.collection('users').doc(email);
    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      debugPrint("Error getting document: $error");

      throw Exception(error);
    });

    final data = value.data() as Map<String, dynamic>;
    return model.User.fromJSON(data);
  }

  // Authenticate
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

  //----------------------------------
  // Matches
  Future<bool> checkIfDocExists(
      {required String collection, required String document}) async {
    try {
      var ref = _db.collection(collection);
      var doc = await ref.doc(document).get();
      return doc.exists;
    } catch (e) {
      rethrow;
    }
  }

  getMatches() async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';
    final docRef = _db.collection('matches').doc(email);
    DocumentSnapshot value = await docRef.get().onError((error, stackTrace) {
      debugPrint("Error getting document: $error");

      throw Exception(error);
    });

    final data = value.data() as Map<String, dynamic>;
    return model.MatchModel.fromJSON(data);
  }

  // Like a team
  like(String email) async {
    // 1. Get email from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email') ?? '';

    // 2. Update 'matches' collection in
    // 2.1. Document named after this email; 'like' array
    final myDocRef = _db.collection('matches').doc(myEmail);
    bool isDocExist =
        await checkIfDocExists(collection: 'matches', document: myEmail);

    // Set a new document if not exist
    if (!isDocExist) {
      myDocRef.set({
        'like': [email]
      });
    } else {
      // Update current document if exist
      myDocRef.update({
        'like': FieldValue.arrayUnion([email])
      });
    }

    // 2.2. Document named after the email in argument; 'liked' array
    final docRef = _db.collection('matches').doc(email);
    isDocExist = await checkIfDocExists(collection: 'matches', document: email);

    // Set a new document if not exist
    if (!isDocExist) {
      docRef.set({
        'liked': [myEmail]
      });
    } else {
      // Update current document if exist
      docRef.update({
        'liked': FieldValue.arrayUnion([myEmail])
      });
    }
  }

//----------------------------------
// Chat
  Future<List<Massage>> getMessages(String partner) async {
    // 1. Get email from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    debugPrint("partner: $partner");

    String user1 = email;
    String user2 = partner;

    if (user1.compareTo(user2) > 0) {
      user1 = partner;
      user2 = email;
    }

    final ref = await _db
        .collection('chats')
        .where('users', isEqualTo: [user1, user2])
        .get()
        .onError((error, stackTrace) {
          debugPrint("Error getting document: $error");

          throw Exception(error);
        });

    List<dynamic> resMap = [];
    List<Massage> res = [];

    for (var doc in ref.docs) {
      final data = doc.data();
      debugPrint("Data: $data");
      resMap.add(data['messages']);
    }

    for (var item in resMap) {
      debugPrint("Item: $item");

      for (var i in item) {
        res.add(Massage.fromJSON(i));
      }
    }

    return res;
  }

  sendMessage(String text, String partner) async {
    // 1. Get email from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    String myEmail = prefs.getString('email') ?? '';

    // 2. Update 'matches' collection in
    // 2.1. Document named after this email; 'like' array

    String user1 = myEmail;
    String user2 = partner;

    if (user1.compareTo(user2) > 0) {
      user1 = partner;
      user2 = myEmail;
    }

    final ref = await _db
        .collection('chats')
        .where('users', isEqualTo: [user1, user2])
        .get()
        .onError((error, stackTrace) {
          debugPrint("Error getting document: $error");

          throw Exception(error);
        });

    for (var doc in ref.docs) {
      bool isDocExist =
          await checkIfDocExists(collection: 'chats', document: doc.id);

      final ref2 = _db.collection('chats').doc(doc.id);

      // Set a new document if not exist
      if (!isDocExist) {
        ref2.set({
          'users': [user1, user2],
          'messages': [
            {
              'sender': myEmail,
              'receiver': partner,
              'message': text,
              'dateTime': Timestamp.fromMicrosecondsSinceEpoch(
                  DateTime.now().microsecondsSinceEpoch)
            }
          ]
        });
      } else {
        // Update current document if exist
        ref2.update({
          'messages': FieldValue.arrayUnion([
            {
              'sender': myEmail,
              'receiver': partner,
              'message': text,
              'dateTime': Timestamp.fromMicrosecondsSinceEpoch(
                  DateTime.now().microsecondsSinceEpoch)
            }
          ])
        });
      }
    }
  }

  updateLastMessage(String text, String partner, String name) async {
    final prefs = await SharedPreferences.getInstance();
    String email = prefs.getString('email') ?? '';

    final ref = _db.collection('matches').doc(email);
    final res = await ref.get();
    debugPrint("RES: ${res.data()?['messages']}");
    final data = res.data()?['messages'] ?? {};

    Map res2 = {
      partner: {
        'message': text,
        'name': name,
        'time': Timestamp.fromMicrosecondsSinceEpoch(
            DateTime.now().microsecondsSinceEpoch),
      },
    };

    res2.addAll(data);

    ref.update(
      {
        'messages': res2,
      },
    );
  }
}
