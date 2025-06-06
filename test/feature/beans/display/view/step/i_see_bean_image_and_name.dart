import 'dart:convert';

import 'package:bdd_jelly_belly/feature/beans/data/model/bean_response_model.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixture/fixture.dart';

/// Usage: I see Bean image and name
Future<void> iSeeBeanImageAndName(WidgetTester tester) async {
  final mockResponse = BeanResponseModel.fromMap(
    jsonDecode(
      Fixture.fromPath(
        "test/feature/beans/fixture/bean_response_model_fetch_fixture.json",
      ),
    ),
  );
  expect(find.text(mockResponse.items.first.flavorName), findsOneWidget);
  expect(
    find.image(NetworkImage(mockResponse.items.first.imageUrl)),
    findsOneWidget,
  );
}
