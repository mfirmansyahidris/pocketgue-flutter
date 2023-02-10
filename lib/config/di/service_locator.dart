import 'package:get_it/get_it.dart';
import 'package:pocketgue/config/config.dart';
import 'package:pocketgue/core/core.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator() async {
  /// register API
  sl.registerFactory<RestApi>(() => RestApi());

  /// register  Repositories
  sl.registerLazySingleton<AnimalRepository>(() => AnimalRepository());
  sl.registerLazySingleton<SavedAnimalRepository>(() => SavedAnimalRepository());
}

/// register prefManager
void initPrefManager(SharedPreferences initPrefManager) {
  sl.registerLazySingleton<PrefManager>(() => PrefManager(initPrefManager));
}
