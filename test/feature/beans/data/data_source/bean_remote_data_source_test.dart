import 'dart:convert';

import 'package:bdd_jelly_belly/core/error/exceptions.dart';
import 'package:bdd_jelly_belly/feature/beans/data/data_source/bean_remote_data_source.dart';
import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixture/fixture.dart';
import 'bean_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late BeanRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = BeanRemoteDataSourceImpl(client: mockClient);
  });

  void setUpMockClientSuccess200() {
    return when(mockClient.get(any, headers: anyNamed("headers"))).thenAnswer(
      (_) async => http.Response(
        Fixture.fromPath(
          "test/feature/beans/fixture/bean_response_model_fixture.json",
        ),
        200,
      ),
    );
  }

  void setUpMockClientFailure404() {
    return when(
      mockClient.get(any, headers: anyNamed("headers")),
    ).thenAnswer((_) async => http.Response("Something went wrong!", 404));
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

    test('should perform a GET request on a URL with pageSize & currentPage '
        'being the endpoint and with application/json header', () async {
      // arrange
      setUpMockClientSuccess200();
      // act
      await dataSource.getBeans(pageSize: pageSize, currentPage: currentPage);
      // assert
      verify(
        mockClient.get(
          Uri.parse(
            "https://jellybellywikiapi.onrender.com/api/Beans?pageSize=$pageSize&currentPage=$currentPage",
          ),
          headers: {'Content-Type': 'application/json'},
        ),
      );
    });

    test(
      'should return BeanResponseModel when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockClientSuccess200();
        // act
        final actual = await dataSource.getBeans(
          pageSize: pageSize,
          currentPage: currentPage,
        );
        // assert
        expect(actual, equals(matcher));
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockClientFailure404();
        // act
        final call = dataSource.getBeans;
        // assert
        expect(
          () => call(currentPage: currentPage, pageSize: pageSize),
          throwsA(TypeMatcher<ServerException>()),
        );
      },
    );
  });
}
