import '../../domain/entity/bean_response.dart';

class BeanResponseModel extends BeanResponse {
  const BeanResponseModel({
    required super.totalCount,
    required super.pageSize,
    required super.currentPage,
    required super.totalPages,
    required super.items,
  });

  factory BeanResponseModel.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
