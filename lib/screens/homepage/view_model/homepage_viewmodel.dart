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

  late RestaurantAppModel _restaurantAppModel;
  late RestaurantDetailApp _restaurantDetailApp;
  ResultState _state = ResultState.loading;
  bool _isSearching = false;
  String _message = '';
  String querys = '';
  RestaurantAppModel _searchRestaurantResult = RestaurantAppModel(
    error: false,
    message: '',
    count: 0,
    restaurants: [],
  );

  String get message => _message;
  RestaurantAppModel get restaurantAppModel => _restaurantAppModel;
  RestaurantAppModel get searchRestaurantResult => _searchRestaurantResult;
  RestaurantDetailApp get restaurantDetailApp => _restaurantDetailApp;
  ResultState get state => _state;
  bool get isSearching => _isSearching;
  String get query => querys;

  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  Future<void> fetchData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      if (isSearching) {
        await searchRestaurants(query);
      } else {
        await fetchRestaurantLists();
      }
    } catch (_) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

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

  Future<void> searchRestaurants(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final searchResult = await apiService.searchRestaurant(query);

      _searchRestaurantResult = searchResult;

      if (_searchRestaurantResult.restaurants.isEmpty) {
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
