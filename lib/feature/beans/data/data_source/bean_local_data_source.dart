import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../model/bean_response_model.dart';

abstract class BeanLocalDataSource {
  Future<BeanResponseModel> getBeans({int currentPage = 1, int pageSize = 10});
  Future<void> cacheBeans(BeanResponseModel modelToCache);
}

class BeanLocalDataSourceImpl implements BeanLocalDataSource {
  const BeanLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  @override
  Future<BeanResponseModel> getBeans({
    int currentPage = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = sharedPreferences.getString("$pageSize|$currentPage");
      if (response != null) {
        return BeanResponseModel.fromMap(jsonDecode(response));
      }
      throw CacheException();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheBeans(BeanResponseModel modelToCache) async {
    try {
      final isCached = await sharedPreferences.setString(
        "${modelToCache.pageSize}|${modelToCache.currentPage}",
        jsonEncode(modelToCache.toMap()),
      );
      if (!isCached) throw CacheException();
    } catch (e) {
      throw CacheException();
    }
  }
}
