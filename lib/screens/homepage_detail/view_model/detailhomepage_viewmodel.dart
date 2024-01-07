import 'package:flutter/material.dart';
import '../../../common/constants/constants.dart';
import '../../../common/global/imgurls.dart';
import '../models/restaurant_detail.dart';

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
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  String getImageUrl(String pictureId) {
    if (pictureId.isNotEmpty) {
      return '${BaseConstant.baseUrl}/images/medium/$pictureId';
    } else {
      return ImageUrls.placeholderImage;
    }
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
}
