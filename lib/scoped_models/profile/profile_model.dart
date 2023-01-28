import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/helper.dart';
import '../../config/service_locator.dart';
import '../../enums/view_state.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ProfileModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  // TODO: Rename data model
  User2? user;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String imgPlaceholderUrl =
      'https://vn112.com/wp-content/uploads/2018/01/pxsolidwhiteborderedsvg-15161310048lcp4.png';
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
    user = await apiService.getProfileData();
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageUrls', user?.imageUrls ?? []);

    nameController.text = user?.name ?? '';
    descriptionController.text = user?.bio ?? '';

    debugPrint(user?.imageUrls.toString() ?? '[]');

    int urlLength = user?.imageUrls.length ?? 1;

    city = user?.city ?? '';
    location = LatLng(user?.latitude ?? 0, user?.longitude ?? 0);

    // Get images
    for (var j = 0; j < urlLength; j++) {
      imgUrls.add(user?.imageUrls.elementAt(j) ?? imgPlaceholderUrl);
    }

    // Get image place holder for the rest
    for (var i = urlLength; i < kMaxImgListLength; i++) {
      imgUrls.add(imgPlaceholderUrl);
      debugPrint(imgUrls.toString());
    }

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

  updateImage() {}

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

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: const OnboardingScreen(),
      ),
    );
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
    image = NetworkImage(url);

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
