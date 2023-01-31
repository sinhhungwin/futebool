import 'package:scoped_model/scoped_model.dart';

import '../enums/view_state.dart';

export '../enums/view_state.dart';

class BaseModel extends Model {
  ViewState _state = ViewState.busy;
  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;

    // Notify listeners will only update listeners of state.
    notifyListeners();
  }
}
