import 'package:flutter/material.dart';

class BeanLoadingWidget extends StatelessWidget {
  const BeanLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
