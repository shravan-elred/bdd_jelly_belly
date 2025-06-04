import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' show Tuple2;
import 'package:provider/provider.dart';

import '../../../domain/entity/bean.dart';
import '../../view_model/bean_view_model.dart';

class BeanGridViewBuilder extends StatefulWidget {
  const BeanGridViewBuilder({super.key});

  @override
  State<BeanGridViewBuilder> createState() => _BeanGridViewBuilderState();
}

class _BeanGridViewBuilderState extends State<BeanGridViewBuilder> {
  @override
  void initState() {
    super.initState();
    Future.microtask(context.read<BeanViewModel>().fetchBeans);
  }

  @override
  Widget build(BuildContext context) {
    return Selector<BeanViewModel, Tuple2<bool, List<Bean>>>(
      selector: (_, vm) => Tuple2(vm.isLoading, vm.beans),
      builder: (context, tuple, child) {
        final beans = tuple.value2;
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
          ),
          itemCount: beans.length,
          itemBuilder: (BuildContext context, int index) {
            final bean = beans[index];
            return Column(
              children: [Image.network(bean.imageUrl), Text(bean.flavorName)],
            );
          },
        );
      },
    );
  }
}
