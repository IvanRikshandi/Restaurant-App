import 'package:flutter/material.dart';
import 'package:restaurant_app/common/global/imgurls.dart';
import 'package:restaurant_app/common/service/constants.dart';

import '../../../../../common/database/dbhelper.dart';

class FavoriteListViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Map<String, dynamic>> _favoriteRestaurants = [];
  List<Map<String, dynamic>> get favoriteRestaurants => _favoriteRestaurants;

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  Future<void> fetchFavoriteRestaurants() async {
    try {
      _state = ResultState.loading;
      _favoriteRestaurants = await _databaseHelper.getRestaurants();
      notifyListeners();
      if (_favoriteRestaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching favorite restaurants: $e');
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
