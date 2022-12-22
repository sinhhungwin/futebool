import 'package:futebol/scoped_models/home_model.dart';
import 'package:get_it/get_it.dart';

import 'services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // register models
  locator.registerFactory<HomeModel>(() => HomeModel());
}
