import '../../config/service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ChatModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';

  onModelReady() {}
}
