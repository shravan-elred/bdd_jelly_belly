import 'dart:convert';

import 'package:bdd_jelly_belly/core/error/exceptions.dart';
import 'package:bdd_jelly_belly/core/error/failures.dart';
import 'package:bdd_jelly_belly/core/network/network_info.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_local_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_remote_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:bdd_jelly_belly/feature/beans/data/repository/bean_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture.dart';
import 'bean_repository_impl_test.mocks.dart';

@GenerateMocks([BeanRemoteDataSource, BeanLocalDataSource, NetworkInfo])
void main() {
  late BeanRepositoryImpl repository;
  late MockBeanRemoteDataSource mockRemoteDataSource;
  late MockBeanLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockBeanRemoteDataSource();
    mockLocalDataSource = MockBeanLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = BeanRepositoryImpl(
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('getBeans', () {
    final pageSize = 1;
    final currentPage = 1;
    final matcher = BeanResponseModel.fromMap(
      jsonDecode(
        Fixture.fromPath(
          "test/feature/beans/fixture/bean_response_model_fixture.json",
        ),
      ),
    );
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // act
      repository.getBeans();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          ).thenAnswer((_) async => matcher);
          // act
          final actual = await repository.getBeans(
            pageSize: pageSize,
            currentPage: currentPage,
          );
          // assert
          expect(actual, equals(Right(matcher)));
        },
      );
      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          ).thenAnswer((_) async => matcher);
          // act
          await repository.getBeans(
            pageSize: pageSize,
            currentPage: currentPage,
          );
          // assert
          verify(
            mockRemoteDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          );
          verify(mockLocalDataSource.cacheBeans(matcher));
        },
      );
      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(
            mockRemoteDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          ).thenThrow(ServerException());
          // act
          final result = await repository.getBeans(
            pageSize: pageSize,
            currentPage: currentPage,
          );
          // assert
          verify(
            mockRemoteDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          );
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestOffline(() {
      test(
        'should return locally cached data when the cached data is present',
        () async {
          // arrange
          when(
            mockLocalDataSource.getBeans(
              currentPage: currentPage,
              pageSize: pageSize,
            ),
          ).thenAnswer((_) async => matcher);
          // act
          final result = await repository.getBeans(
            currentPage: currentPage,
            pageSize: pageSize,
          );
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(
            mockLocalDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          );
          expect(result, equals(Right(matcher)));
        },
      );
      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(
            mockLocalDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          ).thenThrow(CacheException());
          // act
          final result = await repository.getBeans(
            pageSize: pageSize,
            currentPage: currentPage,
          );
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(
            mockLocalDataSource.getBeans(
              pageSize: pageSize,
              currentPage: currentPage,
            ),
          );
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
