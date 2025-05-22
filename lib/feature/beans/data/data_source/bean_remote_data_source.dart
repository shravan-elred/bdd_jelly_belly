import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../model/bean_response_model.dart';

abstract class BeanRemoteDataSource {
  Future<BeanResponseModel> getBeans({int pageSize = 10, int currentPage = 1});
}

class BeanRemoteDataSourceImpl implements BeanRemoteDataSource {
  const BeanRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<BeanResponseModel> getBeans({
    int pageSize = 10,
    int currentPage = 1,
  }) async {
    try {
      final response = await client.get(
        Uri.parse(
          "https://jellybellywikiapi.onrender.com/api/Beans?pageSize=$pageSize&currentPage=$currentPage",
        ),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return BeanResponseModel.fromMap(jsonDecode(response.body));
      }
      throw ServerException();
    } catch (e) {
      throw ServerException();
    }
  }
}
