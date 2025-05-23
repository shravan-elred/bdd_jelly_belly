import 'package:shared_preferences/shared_preferences.dart';

import '../model/bean_response_model.dart';

abstract class BeanLocalDataSource {
  Future<BeanResponseModel> getBeans({int currentPage = 1, int pageSize = 10});
  Future<void> cacheBeans(BeanResponseModel modelToCache);
}

class BeanLocalDataSourceImpl implements BeanLocalDataSource {
  const BeanLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<BeanResponseModel> getBeans({int currentPage = 1, int pageSize = 10}) {
    throw UnimplementedError();
  }

  @override
  Future<void> cacheBeans(BeanResponseModel modelToCache) {
    throw UnimplementedError();
  }
}
