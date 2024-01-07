import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/screens/homepage_detail/models/restaurant_detail.dart';
import '../models/restaurantmodels.dart';

class HomepageRestaurantViewModel extends ChangeNotifier {
  final BaseConstant _apiService = BaseConstant();
  late RestaurantAppModel _restaurantAppModel;
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;

  RestaurantAppModel get restaurantAppModel => _restaurantAppModel;
  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;

  Future<void> fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      _restaurantAppModel = await _apiService.fetchRestaurantList();
      if (_restaurantAppModel.restaurants.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }
    } catch (e) {
      print('Error fetching data: $e');
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _restaurantAppModel =
          (await _apiService.searchRestaurant(query)) as RestaurantAppModel;

      if (_restaurantAppModel.restaurants.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }
    } catch (error) {
      print('Error searching restaurants: $error');
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

  String getImg404Error() {
    return ImageUrls.img404Error;
  }

  String getImgNoData() {
    return ImageUrls.imgNoData;
  }

  String getPlaceHolderImg() {
    return ImageUrls.placeholderImage;
  }
}
