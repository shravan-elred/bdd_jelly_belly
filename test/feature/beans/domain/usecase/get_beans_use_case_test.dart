import 'dart:convert';

import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/repository/bean_repository.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/usecase/get_beans_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture.dart';
import 'get_beans_use_case_test.mocks.dart';

@GenerateMocks([BeanRepository])
void main() {
  late GetBeansUseCase useCase;
  late MockBeanRepository mockBeanRepository;

  setUp(() {
    mockBeanRepository = MockBeanRepository();
    useCase = GetBeansUseCase(repository: mockBeanRepository);
  });

  test('should get trivia for the number from the repository', () async {
    // arrange
    final currentPage = 1;
    final pageSize = 1;
    final params = GetBeansUseCaseParams(
      currentPage: currentPage,
      pageSize: pageSize,
    );
    final model = BeanResponseModel.fromMap(
      jsonDecode(
        Fixture.fromPath(
          "test/feature/beans/fixture/bean_response_model_fixture.json",
        ),
      ),
    );
    when(
      mockBeanRepository.getBeans(pageSize: pageSize, currentPage: currentPage),
    ).thenAnswer((_) async => Right(model));
    // act
    final result = await useCase.call(params);
    // assert
    expect(result, Right(model));
    verify(
      mockBeanRepository.getBeans(pageSize: pageSize, currentPage: currentPage),
    );
    verifyNoMoreInteractions(mockBeanRepository);
  });
}
