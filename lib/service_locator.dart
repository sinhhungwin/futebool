import 'package:get_it/get_it.dart';

import 'scoped_models/models.dart';
import 'services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<UserModel>(() => UserModel());
  locator.registerFactory<OnboardingModel>(() => OnboardingModel());
  locator.registerFactory<EmailModel>(() => EmailModel());
}
