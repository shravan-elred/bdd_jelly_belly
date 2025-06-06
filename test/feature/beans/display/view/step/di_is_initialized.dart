import 'package:flutter_test/flutter_test.dart';

import '../../../../../test_injection_container.dart' as test_di;

/// Usage: DI is initialized
Future<void> diIsInitialized(WidgetTester tester) async {
  await test_di.initTestDi();
}
