import 'package:futebol/enums/view_state.dart';
import 'package:futebol/service_locator.dart';
import 'package:futebol/services/api.dart';

import '../base_model.dart';

class OnboardingModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  onModelReady() {
    setState(ViewState.retrieved);
  }
}
