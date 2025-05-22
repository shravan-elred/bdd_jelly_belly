import '../../domain/entity/bean_response.dart';
import 'bean_model.dart';

class BeanResponseModel extends BeanResponse {
  const BeanResponseModel({
    required super.totalCount,
    required super.pageSize,
    required super.currentPage,
    required super.totalPages,
    required super.items,
  });

  factory BeanResponseModel.fromMap(Map<String, dynamic> map) {
    return BeanResponseModel(
      totalCount: map["totalCount"] as int,
      pageSize: map["pageSize"] as int,
      currentPage: map["currentPage"] as int,
      totalPages: map["totalPages"] as int,
      items: List<BeanModel>.from(
        (map["items"] as List<dynamic>).map((e) => BeanModel.fromMap(e)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "totalCount": totalCount,
      "pageSize": pageSize,
      "currentPage": currentPage,
      "totalPages": totalPages,
      "items": items.map((e) => (BeanModel.fromEntity(e)).toMap()).toList(),
    };
  }
}
