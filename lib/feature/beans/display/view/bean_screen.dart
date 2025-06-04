import 'package:flutter/material.dart';

import 'widgets/bean_grid_view_builder.dart';

class BeanScreen extends StatelessWidget {
  const BeanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beans')),
      body: BeanGridViewBuilder(),
    );
  }
}
