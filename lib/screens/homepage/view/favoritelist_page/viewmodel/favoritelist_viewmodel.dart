import 'package:flutter/material.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/common/helper/dbhelper.dart';
import 'package:restaurant_app/common/service/constants.dart';

class FavoriteListViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _favoriteRestaurants = [];
  List<Map<String, dynamic>> get favoriteRestaurants => _favoriteRestaurants;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  Future<void> fetchFavoriteRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      _favoriteRestaurants = await _databaseHelper.getRestaurants();
      if (_favoriteRestaurants.isEmpty) {
        _state = ResultState.noData;
      } else {
        _state = ResultState.hasData;
      }
    } catch (e) {
      _state = ResultState.failure;
    } finally {
      notifyListeners();
    }
  }

  String getImageUrl(String pictureId) {
    return '${BaseConstant.baseUrl}/images/medium/$pictureId';
  }

  String getPlaceHolderImg() {
    return ImageUrls.placeholderImage;
  }
}
