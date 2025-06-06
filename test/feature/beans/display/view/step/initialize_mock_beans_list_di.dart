import 'package:bdd_jelly_belly/core/network/network_info.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_local_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_remote_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/display/view_model/bean_view_model.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/repository/bean_repository.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/usecase/get_beans_use_case.dart';
import 'package:bdd_jelly_belly/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../data/repository/bean_repository_impl_test.mocks.dart';
import '../../../domain/usecase/get_beans_use_case_test.mocks.dart';

/// Usage: Initialize Mock Beans List DI
Future<void> initializeMockBeansListDi(WidgetTester tester) async {
  await sl.reset();

  // view model
  sl.registerFactory<BeanViewModel>(() => BeanViewModel(getBeansUseCase: sl()));

  // use cases
  sl.registerLazySingleton<GetBeansUseCase>(
    () => GetBeansUseCase(repository: sl()),
  );

  // repository
  sl.registerLazySingleton<BeanRepository>(() => MockBeanRepository());

  // data sources
  sl.registerLazySingleton<BeanRemoteDataSource>(
    () => MockBeanRemoteDataSource(),
  );
  sl.registerLazySingleton<BeanLocalDataSource>(
    () => MockBeanLocalDataSource(),
  );

  // core
  sl.registerLazySingleton<NetworkInfo>(() => MockNetworkInfo());
}
