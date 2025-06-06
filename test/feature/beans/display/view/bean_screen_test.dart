// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/initialize_mock_beans_list_di.dart';
import './step/mock_beans_list.dart';
import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_see_bean_image_and_name.dart';
import './step/initialize_mock_loading_beans_di.dart';
import './step/mock_loading_beans.dart';
import './step/i_see_bean_loading_widget.dart';
import './step/initialize_mock_empty_beans_di.dart';
import './step/mock_empty_beans.dart';
import './step/i_see_bean_empty_widget.dart';

void main() {
  group('''Beans screen displays correct AppBar title''', () {
    testWidgets('''AppBar title is "Beans"''', (tester) async {
      await initializeMockBeansListDi(tester);
      await mockBeansList(tester);
      await theAppIsRunning(tester);
      await iSeeText(tester, "Beans");
    });
    testWidgets('''Beans List should display all bean details''',
        (tester) async {
      await initializeMockBeansListDi(tester);
      await mockBeansList(tester);
      await theAppIsRunning(tester);
      await iSeeBeanImageAndName(tester);
    });
    testWidgets('''Beans List when loading should display loader widget''',
        (tester) async {
      await initializeMockLoadingBeansDi(tester);
      await mockLoadingBeans(tester);
      await theAppIsRunning(tester);
      await iSeeBeanLoadingWidget(tester);
    });
    testWidgets('''Beans List when empty should display empty state widget''',
        (tester) async {
      await initializeMockEmptyBeansDi(tester);
      await mockEmptyBeans(tester);
      await theAppIsRunning(tester);
      await iSeeBeanEmptyWidget(tester);
    });
  });
}
