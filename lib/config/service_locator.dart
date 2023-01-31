import 'package:get_it/get_it.dart';

import '../scoped_models/models.dart';
import '../services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // register services
  locator.registerLazySingleton<ApiService>(() => ApiService());

  // register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<UserModel>(() => UserModel());
  locator.registerFactory<OnboardingModel>(() => OnboardingModel());
  locator.registerFactory<StartModel>(() => StartModel());
  locator.registerFactory<EmailModel>(() => EmailModel());
  locator.registerFactory<BioModel>(() => BioModel());
  locator.registerFactory<PictureModel>(() => PictureModel());
  locator.registerFactory<MapModel>(() => MapModel());
  locator.registerFactory<SplashModel>(() => SplashModel());
  locator.registerFactory<SignInModel>(() => SignInModel());
  locator.registerFactory<ProfileModel>(() => ProfileModel());
  locator.registerFactory<ImgModel>(() => ImgModel());
  locator.registerFactory<MatchesModel>(() => MatchesModel());
}
