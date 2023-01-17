import 'package:futebol/config/service_locator.dart';
import 'package:futebol/enums/view_state.dart';
import 'package:futebol/services/api.dart';

import '../../models/models.dart';
import '../base_model.dart';

class ProfileModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  // TODO: Rename data model
  User2? user;

  onModelReady() async {
    user = await apiService.getProfileData();

    setState(ViewState.retrieved);
  }
}
