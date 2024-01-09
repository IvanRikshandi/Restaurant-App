import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../screens/homepage_detail/models/restaurant_detail.dart';
import '../../screens/homepage/models/restaurantmodels.dart';

enum ResultState { loading, failure, hasData, noData }

enum ConnectivityStatus { connected, disconnected }

class BaseConstant {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";
  static const String listEndpoint = "/list";
  static const String detailEndpoint = "/detail";
  static const String searchEndpoint = "/list?q=";
  static const String reviewEndpoint = "/review";

  Future<RestaurantAppModel> fetchRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl$listEndpoint'));
    if (response.statusCode == 200) {
      return restaurantAppModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetailApp> fetchRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl$detailEndpoint/$id'));
    if (response.statusCode == 200) {
      return restaurantDetailAppFromJson(response.body);
    } else {
      throw Exception('Failed to Load Detail');
    }
  }

  Future<RestaurantAppModel> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$searchEndpoint$query'));
    if (response.statusCode == 200) {
      return restaurantAppModelFromJson(response.body);
    } else {
      throw Exception('Failed to perform search');
    }
  }

  Future<void> postRestaurantReview(
      String id, String review, String name) async {
    final response = await http.post(Uri.parse('$baseUrl$reviewEndpoint'),
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

  Future<RestaurantAppModel> fetchRestaurantReview() async {
    final response = await http.get(Uri.parse('$baseUrl$reviewEndpoint'));
    if (response.statusCode == 200) {
      return restaurantAppModelFromJson(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
