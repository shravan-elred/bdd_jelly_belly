import 'package:bdd_jelly_belly/application.dart';
import 'package:bdd_jelly_belly/injection_container.dart' as di;
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  await di.init();
  await tester.pumpWidget(Application());
  await tester.pumpAndSettle();
}
