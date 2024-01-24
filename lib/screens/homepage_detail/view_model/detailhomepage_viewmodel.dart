import 'package:flutter/material.dart';
import 'package:restaurant_app/common/helper/dbhelper.dart';
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/common/service/endpoint.dart';
import '../../../common/global/imgurls.dart';
import '../models/restaurant_detail.dart';

class DetailRestaurantViewModel extends ChangeNotifier {
  final EndPoint _apiService = EndPoint();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;
  bool _isFavorite = false;

  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;
  bool get isFavorite => _isFavorite;

  final List<RestaurantDetail> _favorites = [];
  List<RestaurantDetail> get bookmarks => _favorites;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _restaurantDetailApp = await _apiService.fetchRestaurantDetail(id);
      _isFavorite = await _databaseHelper.isRestaurantFavorite(id);
      _state = ResultState.hasData;
    } catch (e) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  String getImageUrl(String pictureId) {
    return '${BaseConstant.baseUrl}/images/medium/$pictureId';
  }

  String getLottieLoading() {
    return ImageUrls.lottieLoading;
  }

  Future<void> toggleFavorite() async {
    if (isFavorite) {
      // If already a favorite, remove from favorites
      await _databaseHelper
          .deleteRestaurant(_restaurantDetailApp.restaurant.id);
      notifyListeners();
    } else {
      // If not a favorite, add to favorites
      Map<String, dynamic> restaurantData = {
        'id': _restaurantDetailApp.restaurant.id,
        'name': _restaurantDetailApp.restaurant.name,
        'address': _restaurantDetailApp.restaurant.address,
        'rating': _restaurantDetailApp.restaurant.rating,
        'imgUrlId': _restaurantDetailApp.restaurant.pictureId,
      };
      await _databaseHelper.insertRestaurant(restaurantData);
      notifyListeners();
    }

    // Toggle the favorite status
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
