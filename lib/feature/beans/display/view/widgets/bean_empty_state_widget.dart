import 'package:flutter/material.dart';

class BeanEmptyStateWidget extends StatelessWidget {
  const BeanEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No beans found!'));
  }
}
