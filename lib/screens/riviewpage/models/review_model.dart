import 'dart:convert';

RestaurantReviewModel restaurantReviewModelFromJson(String str) =>
    RestaurantReviewModel.fromJson(json.decode(str));

String restaurantReviewModelToJson(RestaurantReviewModel data) =>
    json.encode(data.toJson());

class RestaurantReviewModel {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  RestaurantReviewModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory RestaurantReviewModel.fromJson(Map<String, dynamic> json) =>
      RestaurantReviewModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews":
            List<dynamic>.from(customerReviews.map((x) => x.toJson())),
      };
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}
