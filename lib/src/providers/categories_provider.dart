import 'package:flutter/cupertino.dart';

import '../models/category_model.dart';

class CategoriesProvider with ChangeNotifier {
  final List<Category> _categoryList = [
    Category(
      id: "1",
      title: "All",
      imageUrl: "assets/icons/home.png",
    ),
    Category(
      id: "2",
      title: "Selling ",
      imageUrl: "assets/icons/selling.png",
    ),
    Category(
      id: "3",
      title: "Buying",
      imageUrl: "assets/icons/buying.png",
    ),
    Category(
      id: "4",
      title: "Business",
      imageUrl: "assets/icons/business.png",
    ),
    Category(
      id: "5",
      title: "Renting",
      imageUrl: "assets/icons/balance.png",
    ),
    Category(
      id: "6",
      title: "Khlo Taraf",
      imageUrl: "assets/icons/key.png",
    ),
    Category(
      id: "7",
      title: "Building",
      imageUrl: "assets/icons/build.png",
    ),
    Category(
      id: "8",
      title: "Important",
      imageUrl: "assets/icons/important.png",
    ),
    Category(
      id: "9",
      title: "Others",
      imageUrl: "assets/icons/plus.png",
    ),
  ];

  List<Category> get categoryList {
    return [..._categoryList];
  }
}
