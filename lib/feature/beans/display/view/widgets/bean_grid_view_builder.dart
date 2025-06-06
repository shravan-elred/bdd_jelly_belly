import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart' show Tuple2;
import 'package:provider/provider.dart';

import '../../../../../core/extension/hex_color_extension.dart';
import '../../../domain/entity/bean.dart';
import '../../view_model/bean_view_model.dart';
import 'bean_empty_state_widget.dart';
import 'bean_loading_widget.dart';

class BeanGridViewBuilder extends StatelessWidget {
  const BeanGridViewBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<BeanViewModel, Tuple2<bool, List<Bean>>>(
      selector: (_, vm) => Tuple2(vm.isLoading, vm.beans),
      builder: (context, tuple, child) {
        final beans = tuple.value2;
        final isLoading = tuple.value1;
        if (isLoading) {
          return BeanLoadingWidget(key: ValueKey("BeanLoadingWidget"));
        }
        if (beans.isEmpty) {
          return BeanEmptyStateWidget(key: ValueKey("BeanEmptyStateWidget"));
        }
        return GridView.builder(
          padding: EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: beans.length,
          itemBuilder: (BuildContext context, int index) {
            final bean = beans[index];
            return Container(
              color: HexColor.fromHex(bean.backgroundColor).withAlpha(30),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Image.network(bean.imageUrl),
                  ),
                  Text(
                    bean.flavorName,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
