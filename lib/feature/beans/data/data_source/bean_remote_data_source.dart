import 'package:http/http.dart' as http;

import '../model/bean_response_model.dart';

abstract class BeanRemoteDataSource {
  Future<BeanResponseModel> getBeans({int pageSize = 10, int currentPage = 1});
}

class BeanRemoteDataSourceImpl implements BeanRemoteDataSource {
  const BeanRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<BeanResponseModel> getBeans({int pageSize = 10, int currentPage = 1}) {
    throw UnimplementedError();
  }
}
