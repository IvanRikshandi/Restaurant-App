import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/screens/homepage/models/restaurant_detail.dart';
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
    _state = ResultState.loading;
    try {
      _restaurantAppModel = await _apiService.fetchRestaurantList();
      _state = ResultState.hasData;
    } catch (e) {
      print('Error fetching data: $e');
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  String getImageUrl(String pictureId) {
    if (pictureId.isNotEmpty) {
      return '${BaseConstant.baseUrl}/images/medium/$pictureId';
    } else {
      return 'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg';
    }
  }

  String getLottieLoading() {
    return 'https://lottie.host/35aef488-5036-4b59-8c35-c3a7a3fcc4df/6ulvzRF4gl.json';
  }
}
