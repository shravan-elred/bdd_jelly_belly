import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see Bean loading widget
Future<void> iSeeBeanLoadingWidget(WidgetTester tester) async {
  expect(find.byKey(ValueKey("BeanLoadingWidget")), findsOneWidget);
}
