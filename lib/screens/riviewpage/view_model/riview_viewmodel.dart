import 'package:flutter/material.dart';
import 'package:restaurant_app/common/service/endpoint.dart';
import 'package:restaurant_app/screens/riviewpage/models/review_model.dart';

class RiviewViewModel extends ChangeNotifier {
  final EndPoint _apiService = EndPoint();
  late RestaurantReviewModel _restaurantReviewModel;

  RestaurantReviewModel get restaurantReviewModel => _restaurantReviewModel;

  Future<String> postRestaurantReview(
      String id, String name, String review) async {
    try {
      await _apiService.postRestaurantReview(id, name, review);
      notifyListeners();
      return "success";
    } catch (error) {
      notifyListeners();
      return 'error post : $error';
    }
  }
}
