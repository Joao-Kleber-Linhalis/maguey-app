import 'package:get_it/get_it.dart';
import 'package:magueyapp/service/firebase_service/firebase_service.dart';
import 'package:magueyapp/service/firestore_service/firestore_service.dart';
import 'package:magueyapp/theme/text_styling.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:magueyapp/data/api/api_service.dart';
import 'package:magueyapp/data/repositories/api_repository.dart';
import 'package:magueyapp/utils/app_routes/app_routes.dart';
import 'package:magueyapp/utils/shared_pref_manager/shared_pref.dart';

GetIt getIt = GetIt.instance;

setupDI() async {
  // AppRoutes initialization
  getIt.registerLazySingleton<AppRoutes>(() => AppRoutes());

  // Shared Preference Instance
  final pref = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => pref);

  // Register Shared Pref Manager that depends on SharedPreferences
  getIt.registerLazySingleton(() => SharedPrefsManager(getIt.get()));

  /* getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt.get()),
  );*/

  // ApiServices
  getIt.registerLazySingleton(() => ApiService(getIt.get()));

  getIt.registerLazySingleton<FirebaseService>(() => FirebaseService());

  getIt.registerLazySingleton<FirestoreService>(
      () => FirestoreService(getIt.get()));

  // Api Repository
  getIt.registerLazySingleton(() => ApiRepository(getIt.get()));

  getIt.registerLazySingleton<TextStyleCustom>(() => TextStyleCustom());

  // Api Repository
  //getIt.registerLazySingleton(() => HomeViewModel(getIt.get()));

  // Monserrat Font Family
  String monserrat = 'monserrat';
  getIt.registerSingleton<String>(monserrat, instanceName: 'f1');

  // Bebas Neue Font Family
  String bebas = 'bebas_neue';
  getIt.registerSingleton<String>(bebas, instanceName: 'f2');
}
