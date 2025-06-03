import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'feature/beans/data/data_source/bean_local_data_source.dart';
import 'feature/beans/data/data_source/bean_remote_data_source.dart';
import 'feature/beans/data/repository/bean_repository_impl.dart';
import 'feature/beans/display/view_model/bean_view_model.dart';
import 'feature/beans/domain/repository/bean_repository.dart';
import 'feature/beans/domain/usecase/get_beans_use_case.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // view model
  sl.registerFactory<BeanViewModel>(() => BeanViewModel(getBeansUseCase: sl()));

  // use cases
  sl.registerLazySingleton<GetBeansUseCase>(
    () => GetBeansUseCase(repository: sl()),
  );

  // repository
  sl.registerLazySingleton<BeanRepository>(
    () => BeanRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<BeanRemoteDataSource>(
    () => BeanRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<BeanLocalDataSource>(
    () => BeanLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
}
