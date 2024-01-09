import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/screens/homepage_detail/models/restaurant_detail.dart';
import '../models/restaurantmodels.dart';

class HomepageRestaurantViewModel extends ChangeNotifier {
  final BaseConstant apiService;

  HomepageRestaurantViewModel({required this.apiService}) {
    fetchRestaurantLists();
  }

  ConnectivityStatus _status = ConnectivityStatus.connected;
  late RestaurantAppModel _restaurantAppModel;
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;
  String _message = '';

  ConnectivityStatus get status => _status;
  String get message => _message;
  RestaurantAppModel get restaurantAppModel => _restaurantAppModel;
  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;

  bool get isConnected => _status == ConnectivityStatus.connected;

  Future<dynamic> fetchRestaurantLists() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final result = await apiService.fetchRestaurantList();
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantAppModel = result;
      }
    } catch (_) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  ConnectivityProvider() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        _status = ConnectivityStatus.disconnected;
      } else {
        _status = ConnectivityStatus.connected;
      }
      notifyListeners();
    });
  }

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;

      RestaurantAppModel restaurant = await apiService.searchRestaurant(query);

      _restaurantAppModel.restaurants = restaurant.restaurants;

      if (_restaurantAppModel.restaurants.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }
    } catch (error) {
      print('Error: $error');
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
