import 'dart:collection';
import 'dart:convert';

import 'package:bdd_jelly_belly/core/error/failures.dart';
import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:bdd_jelly_belly/feature/beans/display/view_model/bean_view_model.dart';
import 'package:bdd_jelly_belly/feature/beans/domain/usecase/get_beans_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture.dart';
import 'bean_view_model_test.mocks.dart';

@GenerateMocks([GetBeansUseCase])
void main() {
  late BeanViewModel beanViewModel;
  late MockGetBeansUseCase mockGetBeansUseCase;

  setUp(() {
    mockGetBeansUseCase = MockGetBeansUseCase();
    beanViewModel = BeanViewModel(getBeansUseCase: mockGetBeansUseCase);
  });

  final mockGetBeansResponse = BeanResponseModel.fromMap(
    jsonDecode(
      Fixture.fromPath(
        'test/feature/beans/fixture/bean_response_model_fetch_fixture.json',
      ),
    ),
  );
  final mockGetBeansMoreResponse = BeanResponseModel.fromMap(
    jsonDecode(
      Fixture.fromPath(
        'test/feature/beans/fixture/bean_response_model_fetch_more_fixture.json',
      ),
    ),
  );

  group('GetBeans', () {
    test('initial state should be empty', () async {
      // arrage
      // act
      // assert
      expect(beanViewModel.isLoading, false);
      expect(beanViewModel.beans.isEmpty, true);
    });

    test('fetchBeans success state', () async {
      // arrange
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 1),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(Duration(milliseconds: 100));
        return Right(mockGetBeansResponse);
      });
      // act
      final future = beanViewModel.fetchBeans();
      expect(beanViewModel.isLoading, true);
      await future;
      // assert
      expect(beanViewModel.totalPages, mockGetBeansResponse.totalPages);
      expect(beanViewModel.pageSize, mockGetBeansResponse.pageSize);
      expect(beanViewModel.totalCount, mockGetBeansResponse.totalCount);
      expect(beanViewModel.currentPage, mockGetBeansResponse.currentPage);
      expect(
        beanViewModel.beans,
        equals(UnmodifiableListView(mockGetBeansResponse.items)),
      );
    });

    test('fetchBeans failure state', () async {
      // arrange
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 1),
        ),
      ).thenAnswer((_) async => Left(ServerFailure()));
      // act
      await beanViewModel.fetchBeans();
      // assert
      expect(beanViewModel.isLoading, false);
    });

    test('fetchMoreBeans success state', () async {
      // arrange
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 1),
        ),
      ).thenAnswer((_) async {
        return Right(mockGetBeansResponse);
      });
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 2),
        ),
      ).thenAnswer((_) async {
        await Future.delayed(Durations.medium1);
        return Right(mockGetBeansMoreResponse);
      });
      // act
      await beanViewModel.fetchBeans();
      final future = beanViewModel.fetchMoreBeans();
      expect(beanViewModel.isLoadingMore, true);
      await future;
      // assert
      expect(beanViewModel.totalPages, mockGetBeansMoreResponse.totalPages);
      expect(beanViewModel.pageSize, mockGetBeansMoreResponse.pageSize);
      expect(beanViewModel.totalCount, mockGetBeansMoreResponse.totalCount);
      expect(beanViewModel.currentPage, mockGetBeansMoreResponse.currentPage);
      expect(
        beanViewModel.beans,
        equals(
          UnmodifiableListView([
            ...mockGetBeansResponse.items,
            ...mockGetBeansMoreResponse.items,
          ]),
        ),
      );
    });
    test('fetchMoreBeans failure state', () async {
      // arrange
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 1),
        ),
      ).thenAnswer((_) async {
        return Right(mockGetBeansResponse);
      });
      when(
        mockGetBeansUseCase.call(
          GetBeansUseCaseParams(pageSize: 10, currentPage: 2),
        ),
      ).thenAnswer((_) async => Left(ServerFailure()));
      // act
      await beanViewModel.fetchBeans();
      await beanViewModel.fetchMoreBeans();
      // assert
      expect(beanViewModel.isLoading, false);
    });
  });
}
