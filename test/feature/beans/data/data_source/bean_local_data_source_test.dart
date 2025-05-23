import 'dart:convert';

import 'package:bdd_jelly_belly/core/error/exceptions.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_local_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixture/fixture.dart';
import 'bean_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late BeanLocalDataSourceImpl dataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = BeanLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getBeans', () {
    final pageSize = 1;
    final currentPage = 1;
    final matcher = BeanResponseModel.fromMap(
      jsonDecode(
        Fixture.fromPath(
          'test/feature/beans/fixture/bean_response_model_fixture.json',
        ),
      ),
    );

    test(
      'should return BeanResponseModel from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(
          Fixture.fromPath(
            'test/feature/beans/fixture/bean_response_model_fixture.json',
          ),
        );
        // act
        final result = await dataSource.getBeans(
          pageSize: pageSize,
          currentPage: currentPage,
        );
        // assert
        verify(mockSharedPreferences.getString("$pageSize|$currentPage"));
        expect(result, equals(matcher));
      },
    );

    test(
      'should throw a CacheExeption when there is not a cached value',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final call = dataSource.getBeans;
        // assert
        expect(
          () => call(currentPage: currentPage, pageSize: pageSize),
          throwsA(TypeMatcher<CacheException>()),
        );
      },
    );
  });

  group('cacheBeans', () {
    final model = BeanResponseModel.fromMap(
      jsonDecode(
        Fixture.fromPath(
          'test/feature/beans/fixture/bean_response_model_fixture.json',
        ),
      ),
    );
    test('should call SharedPreferences to cache the data', () async {
      // arrange
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => true);
      final matcher = jsonEncode(model.toMap());
      // act
      await dataSource.cacheBeans(model);
      // assert
      verify(
        mockSharedPreferences.setString(
          "${model.pageSize}|${model.currentPage}",
          matcher,
        ),
      );
    });

    test('should throw a CacheExeption when the value is not cached', () async {
      // arrange
      when(
        mockSharedPreferences.setString(any, any),
      ).thenAnswer((_) async => false);
      // act
      final call = dataSource.cacheBeans;
      // assert
      expect(() => call(model), throwsA(TypeMatcher<CacheException>()));
    });
  });
}
