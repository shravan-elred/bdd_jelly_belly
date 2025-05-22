import '../../domain/entity/bean.dart';

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
    return BeanModel(
      id: map["beanId"] as int,
      groupName: List<String>.from(map["groupName"] as List),
      ingredients: List<String>.from(map["ingredients"] as List),
      flavorName: map["flavorName"] as String,
      description: map["description"] as String,
      colorGroup: map["colorGroup"] as String,
      backgroundColor: map["backgroundColor"] as String,
      imageUrl: map["imageUrl"] as String,
      glutenFree: map["glutenFree"] as bool,
      sugarFree: map["sugarFree"] as bool,
      seasonal: map["seasonal"] as bool,
      kosher: map["kosher"] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "beanId": id,
      "groupName": groupName,
      "ingredients": ingredients,
      "flavorName": flavorName,
      "description": description,
      "colorGroup": colorGroup,
      "backgroundColor": backgroundColor,
      "imageUrl": imageUrl,
      "glutenFree": glutenFree,
      "sugarFree": sugarFree,
      "seasonal": seasonal,
      "kosher": kosher,
    };
  }
}
