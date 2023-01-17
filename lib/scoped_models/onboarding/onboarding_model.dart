import '../../enums/view_state.dart';
import '../base_model.dart';

class OnboardingModel extends BaseModel {
  onModelReady() {
    setState(ViewState.retrieved);
  }
}
