import 'package:equatable/equatable.dart';

class Bean extends Equatable {
  const Bean({
    required this.id,
    required this.groupName,
    required this.ingredients,
    required this.flavorName,
    required this.description,
    required this.colorGroup,
    required this.backgroundColor,
    required this.imageUrl,
    required this.glutenFree,
    required this.sugarFree,
    required this.seasonal,
    required this.kosher,
  });

  final int id;
  final List<String> groupName;
  final List<String> ingredients;
  final String flavorName;
  final String description;
  final String colorGroup;
  final String backgroundColor;
  final String imageUrl;
  final bool glutenFree;
  final bool sugarFree;
  final bool seasonal;
  final bool kosher;

  @override
  List<Object?> get props => [
    id,
    groupName,
    ingredients,
    flavorName,
    description,
    colorGroup,
    backgroundColor,
    imageUrl,
    glutenFree,
    sugarFree,
    seasonal,
    kosher,
  ];
}
