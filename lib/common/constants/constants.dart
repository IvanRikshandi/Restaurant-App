import 'package:http/http.dart' as http;
import '../../screens/homepage_detail/models/restaurant_detail.dart';
import '../../screens/homepage/models/restaurantmodels.dart';

enum ResultState { loading, failure, hasData, noData }

enum EndPointType { getList, getDetailList }

class BaseConstant {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";
  static const String listEndpoint = "/list";
  static const String detailEndpoint = "/detail";
  static const String searchEndpoint = "/list?q=\$query";

  Future<RestaurantAppModel> fetchRestaurantList() async {
    final response = await http.get(Uri.parse('$baseUrl$listEndpoint'));
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

  Future<List<RestaurantAppModel>> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('$baseUrl$searchEndpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> data =
          restaurantAppModelFromJson(response.body).restaurants;
      List<RestaurantAppModel> restaurants = data
          .map((restaurantData) => RestaurantAppModel.fromJson(restaurantData))
          .toList();
      return restaurants;
    } else {
      throw Exception('Failed to Load Data');
    }
  }
}
