import 'package:bdd_jelly_belly/feature/beans/display/view_model/bean_view_model.dart';
import 'package:bdd_jelly_belly/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../view_model/bean_view_model_test.mocks.dart';

/// Usage: Initialize Mock Loading Beans DI
Future<void> initializeMockLoadingBeansDi(WidgetTester tester) async {
  await sl.reset();

  sl.registerLazySingleton<BeanViewModel>(() => MockBeanViewModel());
}
