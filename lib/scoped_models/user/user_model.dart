import 'package:futebol/config/service_locator.dart';
import 'package:futebol/services/api.dart';

import '../../models/models.dart';
import '../base_model.dart';

class UserModel extends BaseModel {
  ApiService apiService = locator<ApiService>();

  averageRating(User user) {
    num sum = 0;
    num count = 0;

    for (var item in user.ratings) {
      sum += item.rating;
      count++;
    }

    return count == 0 ? 0 : sum / count;
  }

  onModelReady() {
    setState(ViewState.retrieved);
  }
}
