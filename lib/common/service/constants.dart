enum ResultState { loading, failure, hasData, noData }

enum ConnectivityStatus { connected, disconnected }

class BaseConstant {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";
  static const String listEndpoint = "/list";
  static const String detailEndpoint = "/detail";
  static const String searchEndpoint = "/search?q=";
  static const String reviewEndpoint = "/review";
}
