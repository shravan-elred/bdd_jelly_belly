import 'package:bdd_jelly_belly/feature/beans/domain/entity/bean.dart';

class BeanModel extends Bean {
  const BeanModel({
    required super.id,
    required super.groupName,
    required super.ingredients,
    required super.flavorName,
    required super.description,
    required super.colorGroup,
    required super.backgroundColor,
    required super.imageUrl,
    required super.glutenFree,
    required super.sugarFree,
    required super.seasonal,
    required super.kosher,
  });

  factory BeanModel.fromMap(Map<String, dynamic> map) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
