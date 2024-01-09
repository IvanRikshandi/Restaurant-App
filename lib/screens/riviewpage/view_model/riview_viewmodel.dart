import 'package:flutter/material.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/riviewpage/models/review_model.dart';

class RiviewViewModel extends ChangeNotifier {
  final BaseConstant _apiService = BaseConstant();
  late RestaurantReviewModel _restaurantReviewModel;
  ResultState _state = ResultState.loading;

  RestaurantReviewModel get restaurantReviewModel => _restaurantReviewModel;
  ResultState get state => _state;

  Future<void> postRestaurantReview(
      String name, String review, String date) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      await _apiService.postRestaurantReview(name, review, date);

      await fetchRestaurantReviews();
    } catch (_) {
      _state = ResultState.failure;
      notifyListeners();
    }
  }

  Future<void> fetchRestaurantReviews() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurantReviewModel =
          (await _apiService.fetchRestaurantReview()) as RestaurantReviewModel;

      if (_restaurantReviewModel.customerReviews.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }

      notifyListeners();
    } catch (_) {
      _state = ResultState.failure;
      notifyListeners();
    }
  }
}
