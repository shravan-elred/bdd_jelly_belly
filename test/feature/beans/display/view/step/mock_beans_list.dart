import 'dart:convert';

import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/repository/bean_repository.dart';
import 'package:bdd_jelly_belly/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../fixture/fixture.dart';
import '../../../domain/usecase/get_beans_use_case_test.mocks.dart';

/// Usage: Mock Beans List
Future<void> mockBeansList(WidgetTester tester) async {
  final repository = sl.get<BeanRepository>() as MockBeanRepository;
  final mockResponse = BeanResponseModel.fromMap(
    jsonDecode(
      Fixture.fromPath(
        "test/feature/beans/fixture/bean_response_model_fetch_fixture.json",
      ),
    ),
  );
  when(
    repository.getBeans(pageSize: 10, currentPage: 1),
  ).thenAnswer((_) async => Right(mockResponse));
}
