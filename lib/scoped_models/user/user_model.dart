import 'package:futebol/config/service_locator.dart';
import 'package:futebol/services/api.dart';

import '../../models/models.dart';
import '../base_model.dart';

class UserModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  late User user;

  onModelReady() {
    user = User.users.first;
    setState(ViewState.retrieved);
  }
}
