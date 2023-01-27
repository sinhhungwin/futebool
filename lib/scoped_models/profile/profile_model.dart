import 'package:flutter/material.dart';

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

  onModelReady() async {
    setState(ViewState.busy);
    user = await apiService.getProfileData();

    nameController.text = user?.name ?? '';
    descriptionController.text = user?.bio ?? '';

    setState(ViewState.retrieved);
  }

  updateBio(context) async {
    await apiService.updateBio(nameController.text, descriptionController.text);
    Navigator.pop(context);
  }

  // Navigate to other screens
  toProfileBio(context) async {
    await Navigator.pushNamed(context, ProfileBio.routeName);

    onModelReady();
  }

  toProfileMap(context) => Navigator.pushNamed(context, ProfileMap.routeName);
  toProfilePic(context) => Navigator.pushNamed(context, ProfilePic.routeName);
}
