import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../enums/view_state.dart';
import '../../service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class MapModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  final _firestore = FirebaseFirestore.instance;
  String city = 'Hanoi';

  Marker marker = Marker(
    point: LatLng(21.028511, 105.804817),
    builder: (ctx) => const Icon(
      Icons.pin_drop,
      color: Colors.redAccent,
    ),
  );
  BuildContext? context;

  onModelReady(context) {
    this.context = context;
    setState(ViewState.retrieved);
  }

  onTap(LatLng location) async {
    marker = Marker(
      point: location,
      builder: (ctx) => const Icon(
        Icons.pin_drop,
        color: Colors.redAccent,
      ),
    );

    var address = await Geocoder.local.findAddressesFromCoordinates(
      Coordinates(location.latitude, location.longitude),
    );
    city = address.first.locality ?? '...';

    notifyListeners();
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
