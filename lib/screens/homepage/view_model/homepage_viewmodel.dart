import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/common/service/endpoint.dart';
import 'package:restaurant_app/screens/homepage/models/searchrestaurantmodel.dart';
import 'package:restaurant_app/screens/homepage_detail/models/restaurant_detail.dart';
import '../models/restaurantmodels.dart';

class HomepageRestaurantViewModel extends ChangeNotifier {
  final EndPoint apiService;

  HomepageRestaurantViewModel({required this.apiService}) {
    fetchRestaurantLists();
  }

  late RestaurantSearchModel _restaurants;
  late RestaurantAppModel _restaurantAppModel;
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;
  String _message = '';
  String _query = '';

  String get query => _query;
  RestaurantSearchModel get restaurants => _restaurants;
  String get message => _message;
  RestaurantAppModel get restaurantAppModel => _restaurantAppModel;
  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;

  Future<dynamic> fetchRestaurantLists() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.fetchRestaurantList();
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        return _restaurantAppModel = result;
      }
    } catch (_) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchSearchRestaurants(String query) async {
    _state = ResultState.loading;
    notifyListeners();
    _query = query;
    try {
      _restaurants = await apiService.searchRestaurant(_query);
      _state = ResultState.hasData;
    } catch (error) {
      _message = 'Failed search: $error';
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

  String getPlaceHolderImg() {
    return ImageUrls.placeholderImage;
  }
}
