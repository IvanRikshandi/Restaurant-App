import 'package:flutter/material.dart';
import '../../../common/constants/constants.dart';
import '../../homepage/models/restaurant_detail.dart';

class DetailRestaurantViewModel extends ChangeNotifier {
  final BaseConstant _apiService = BaseConstant();
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;

  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _restaurantDetailApp = await _apiService.fetchRestaurantDetail(id);
      _state = ResultState.hasData;
    } catch (e) {
      print('Error fetching data: $e');
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }
}
