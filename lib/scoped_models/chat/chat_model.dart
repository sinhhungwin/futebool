import 'package:futebol/models/chat/massage_model.dart';

import '../../config/service_locator.dart';
import '../../services/api.dart';
import '../base_model.dart';

class ChatModel extends BaseModel {
  ApiService apiService = locator<ApiService>();
  String errorText = '';

  List<Massage> messages = [];

  onModelReady(email) async {
    try {
      messages = await apiService.getMessages(email);

      setState(ViewState.retrieved);
    } catch (e) {
      errorText = e.toString();
      setState(ViewState.error);
    }
  }
}
