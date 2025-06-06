import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see Bean Empty widget
Future<void> iSeeBeanEmptyWidget(WidgetTester tester) async {
  expect(find.byKey(ValueKey("BeanEmptyStateWidget")), findsOneWidget);
}
