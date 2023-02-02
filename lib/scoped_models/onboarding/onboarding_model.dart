import '../base_model.dart';

class OnboardingModel extends BaseModel {
  onModelReady() {
    setState(ViewState.retrieved);
  }
}
