import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums/view_state.dart';
import '../../service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class MapModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  final _firestore = FirebaseFirestore.instance;

  onModelReady() {
    setState(ViewState.retrieved);
  }

  createNewUser(TabController tabController, context) async {
    final prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('email') ?? '';
    String name = prefs.getString('name') ?? '';
    String bio = prefs.getString('bio') ?? '';

    _firestore.collection('users').add(
      {'email': email, 'name': name, 'bio': bio},
    );
  }
}
