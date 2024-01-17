class Restaurant {
  String id;
  String name;
  String location;
  double rating;
  String imageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        rating: json["rating"]?.toDouble() ?? 0.0,
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "rating": rating,
        "imageUrl": imageUrl,
      };

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      rating: map['rating'],
      imageUrl: map['imgUrl'],
    );
  }
}
