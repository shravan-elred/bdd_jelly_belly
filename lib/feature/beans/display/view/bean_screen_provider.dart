import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../../injection_container.dart';
import '../view_model/bean_view_model.dart';
import 'bean_screen.dart';

class BeanScreenProvider extends StatelessWidget {
  const BeanScreenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<BeanViewModel>(),
      child: BeanScreen(),
    );
  }
}
