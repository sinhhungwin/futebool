import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/service_locator.dart';
import '../../enums/view_state.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class MapModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  String city = 'Hanoi';
  LatLng location = LatLng(21.028511, 105.804817);

  Marker get marker => Marker(
        point: location,
        builder: (ctx) => const Icon(
          Icons.pin_drop,
          color: Colors.redAccent,
        ),
      );

  onModelReady(context) {
    setState(ViewState.retrieved);
  }

  onTap(LatLng location) async {
    this.location = location;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);

    city = placemarks.first.subAdministrativeArea ?? '...';
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('city', city);

    notifyListeners();
  }

  createNewUser(TabController tabController, context) async {
    final prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {};

    data['email'] = prefs.getString('email') ?? '';
    data['name'] = prefs.getString('name') ?? '';
    data['bio'] = prefs.getString('bio') ?? '';
    data['latitude'] = location.latitude;
    data['longitude'] = location.longitude;
    data['city'] = prefs.getString('city') ?? '';
    data['imageUrls'] = prefs.getStringList('imageUrls') ?? [];

    prefs.setStringList('imageUrls', []);

    try {
      await apiService.setInitialData(data);
      Navigator.pushNamed(context, HomeScreen.routeName);
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
