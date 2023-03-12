import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/helper.dart';
import '../../config/service_locator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ProfileModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';

  User? user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<String> imgUrls = [];

  late LatLng location;
  late String city;

  Marker get marker => Marker(
        point: location,
        builder: (ctx) => const Icon(
          Icons.pin_drop,
          color: Colors.redAccent,
        ),
      );

  onModelReady() async {
    setState(ViewState.busy);

    try {
      user = await apiService.getProfileData();
    } catch (e) {
      errorText = e.toString();
    }
    if (errorText.isNotEmpty) {
      setState(ViewState.error);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageUrls', user?.imageUrls ?? []);

    nameController.text = user?.name ?? '';
    descriptionController.text = user?.bio ?? '';
    city = user?.city ?? '';
    location = LatLng(user?.latitude ?? 0, user?.longitude ?? 0);

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

  addImage() {}

  pop(context) async => Navigator.pop(context);

  updateBio(context) async {
    await apiService.updateBio(nameController.text, descriptionController.text);
    Navigator.pop(context);
  }

  updateMap(context) async {
    await apiService.updateMap(city, location);
    Navigator.pop(context);
  }

  // Navigate to other screens
  toProfileBio(context) async {
    await Navigator.pushNamed(context, ProfileBio.routeName);

    onModelReady();
  }

  toProfileMap(context) async {
    await Navigator.pushNamed(context, ProfileMap.routeName);
    onModelReady();
  }

  toProfilePic(context) async {
    await Navigator.pushNamed(context, ProfilePic.routeName);
    onModelReady();
  }

  signOut(context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', '');
    prefs.setString('name', '');
    prefs.setDouble('latitude', 0);
    prefs.setDouble('longitude', 0);
    prefs.setStringList('imageUrls', []);

    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const OnboardingScreen(),
        ),
        (Route<dynamic> route) => false);
  }
}

class ImgModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  List<String> imageUrls = [];

  late ImageProvider image;
  late String url;
  late bool isOld;

  onModelReady(url) async {
    setState(ViewState.busy);
    isOld = url != kImgPlaceholderUrl;
    final prefs = await SharedPreferences.getInstance();
    imageUrls = prefs.getStringList('imageUrls') ?? [];
    this.url = url;
    image = CachedNetworkImageProvider(url);

    setState(ViewState.retrieved);
  }

  updateImage(context) async {
    ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image was selected'),
        ),
      );
    } else {
      debugPrint('Updating ...');

      setState(ViewState.busy);

      if (isOld) {
        debugPrint('Deleting ...');
        await apiService.deleteImage(url).catchError((e) {
          debugPrint("ERROR WHEN DELETING: $e");
        });
      }

      url = await apiService.uploadImage(image);
      debugPrint("This URL = $url");

      this.image = FileImage(
        File(image.path),
      );

      await apiService.updateImg(await apiService.getAllUrls());

      isOld = true;
      setState(ViewState.retrieved);
    }
  }
}
