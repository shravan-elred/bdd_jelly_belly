import 'package:flutter/material.dart';

import 'feature/beans/display/view/bean_screen_provider.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      home: BeanScreenProvider(),
    );
  }
}
