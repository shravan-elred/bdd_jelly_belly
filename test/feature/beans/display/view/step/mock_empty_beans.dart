import 'dart:collection';

import 'package:bdd_jelly_belly/feature/beans/display/view_model/bean_view_model.dart';
import 'package:bdd_jelly_belly/injection_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../view_model/bean_view_model_test.mocks.dart';

/// Usage: Mock Empty Beans
Future<void> mockEmptyBeans(WidgetTester tester) async {
  final mockViewModel = sl<BeanViewModel>() as MockBeanViewModel;
  when(mockViewModel.isLoading).thenReturn(false);
  when(mockViewModel.beans).thenReturn(UnmodifiableListView([]));
  when(mockViewModel.fetchBeans()).thenAnswer((_) async {});
}
