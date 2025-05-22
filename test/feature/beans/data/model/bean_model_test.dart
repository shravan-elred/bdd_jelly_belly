import 'dart:convert';

import 'package:bdd_jelly_belly/feature/beans/data/model/bean_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture/fixture.dart';

void main() {
  test("bean model fromMap unit test", () async {
    // arrange
    final matcher = BeanModel(
      id: 1,
      groupName: ["Jelly Belly Official Flavors", "Soda Pop Shoppe® Flavors"],
      ingredients: [
        "Sugar",
        "Corn Syrup",
        "Modified Food Starch",
        "Contains 2% Or Less Of The Following:",
        "Citric Acid",
        "Sodium Lactate",
        "Natural & Artificial Flavor",
        "Color Added",
        "Yellow 5",
        "Blue 1",
        "Beeswax",
        "Carnauba Wax",
        "Confectioner'S Glaze",
      ],
      flavorName: "7Up",
      description: "The Refreshing And Crisp Flavor Of Lemon Lime Soda.",
      colorGroup: "khaki",
      backgroundColor: "#CEDC91",
      imageUrl:
          "https://cdn-tp1.mozu.com/9046-m1/cms/files/ab692677-5471-4863-91a8-659363ae4cc4",
      glutenFree: false,
      sugarFree: false,
      seasonal: false,
      kosher: true,
    );
    // act
    final source = Fixture.fromPath(
      "test/feature/beans/fixture/bean_model_fixture.json",
    );
    final map = jsonDecode(source);
    final actual = BeanModel.fromMap(map);
    // assert
    expect(actual, matcher);
  });

  test("bean model toMap method unit test", () async {
    // arrange
    final source = Fixture.fromPath(
      "test/feature/beans/fixture/bean_model_fixture.json",
    );
    final matcher = jsonDecode(source);
    // act
    final model = BeanModel(
      id: 1,
      groupName: ["Jelly Belly Official Flavors", "Soda Pop Shoppe® Flavors"],
      ingredients: [
        "Sugar",
        "Corn Syrup",
        "Modified Food Starch",
        "Contains 2% Or Less Of The Following:",
        "Citric Acid",
        "Sodium Lactate",
        "Natural & Artificial Flavor",
        "Color Added",
        "Yellow 5",
        "Blue 1",
        "Beeswax",
        "Carnauba Wax",
        "Confectioner'S Glaze",
      ],
      flavorName: "7Up",
      description: "The Refreshing And Crisp Flavor Of Lemon Lime Soda.",
      colorGroup: "khaki",
      backgroundColor: "#CEDC91",
      imageUrl:
          "https://cdn-tp1.mozu.com/9046-m1/cms/files/ab692677-5471-4863-91a8-659363ae4cc4",
      glutenFree: false,
      sugarFree: false,
      seasonal: false,
      kosher: true,
    );
    final actual = model.toMap();
    // assert
    expect(actual, matcher);
  });
}
