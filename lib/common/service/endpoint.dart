import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/service/constants.dart';
import '../../screens/homepage/models/searchrestaurantmodel.dart';
import '../../screens/homepage_detail/models/restaurant_detail.dart';
import '../../screens/homepage/models/restaurantmodels.dart';

class EndPoint {
  Future<RestaurantAppModel> fetchRestaurantList() async {
    final response = await http
        .get(Uri.parse('${BaseConstant.baseUrl}${BaseConstant.listEndpoint}'));
    if (response.statusCode == 200) {
      return restaurantAppModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetailApp> fetchRestaurantDetail(String id) async {
    final response = await http.get(
        Uri.parse('${BaseConstant.baseUrl}${BaseConstant.detailEndpoint}/$id'));
    if (response.statusCode == 200) {
      return restaurantDetailAppFromJson(response.body);
    } else {
      throw Exception('Failed to Load Detail');
    }
  }

  Future<RestaurantSearchModel> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(
        '${BaseConstant.baseUrl}${BaseConstant.searchEndpoint}$query'));
    if (response.statusCode == 200) {
      return restaurantSearchModelFromJson(response.body);
    } else {
      throw Exception('Failed to perform search');
    }
  }

  Future<void> postRestaurantReview(
      String id, String name, String review) async {
    final response = await http.post(
        Uri.parse('${BaseConstant.baseUrl}${BaseConstant.reviewEndpoint}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'id': id,
          'name': name,
          'review': review,
        }));

    if (response.statusCode != 200) {
      throw Exception('Failed to post review');
    }
  }
}
