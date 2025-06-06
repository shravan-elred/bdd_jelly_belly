import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/bean_view_model.dart';
import 'widgets/bean_grid_view_builder.dart';

class BeanScreen extends StatefulWidget {
  const BeanScreen({super.key});

  @override
  State<BeanScreen> createState() => _BeanScreenState();
}

class _BeanScreenState extends State<BeanScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(context.read<BeanViewModel>().fetchBeans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beans')),
      body: BeanGridViewBuilder(),
    );
  }
}
