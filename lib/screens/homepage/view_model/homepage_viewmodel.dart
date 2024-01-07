import 'package:flutter/foundation.dart';
import 'package:restaurant_app/common/constants/constants.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/screens/homepage_detail/models/restaurant_detail.dart';
import '../models/restaurantmodels.dart';

class HomepageRestaurantViewModel extends ChangeNotifier {
  final BaseConstant apiService;

  HomepageRestaurantViewModel({required this.apiService});

  late RestaurantAppModel _restaurantAppModel;
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;

  RestaurantAppModel get restaurantAppModel => _restaurantAppModel;
  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;

  bool _isSearching = false;

  String querys = '';

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  bool get isSearching => _isSearching;
  String get query => querys;

  Future<void> fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      if (isSearching) {
        await searchRestaurants(query);
      } else {
        await fetchRestaurantList();
      }
    } catch (_) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      _restaurantAppModel = await apiService.fetchRestaurantList();
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

      List<RestaurantAppModel> restaurant =
          (await apiService.searchRestaurant(query));

      _restaurantAppModel = restaurant as RestaurantAppModel;

      if (_restaurantAppModel.restaurants.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }
    } catch (_) {
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
