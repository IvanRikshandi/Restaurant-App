import 'package:flutter/services.dart';
import '../models/restaurantmodels.dart';

class HomepageRestaurantViewModel {
  late List<Restaurant> menu;

  Future<void> getMenuFromJson() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/dummydata.json');
      final restauranAppModel = restaurantAppModelFromJson(jsonString);
      menu = restauranAppModel.restaurants;
    } catch (e) {
      throw Exception(e);
    }
  }
}
