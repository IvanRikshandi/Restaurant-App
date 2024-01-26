import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/screens/homepage/models/restaurantmodels.dart';

void main() {
  group('RestaurantAppModel', () {
    test('fromJson creates a valid RestaurantAppModel object', () {
      final jsonMap = {
        'error': false,
        'message': 'Success',
        'count': 2,
        'restaurants': [
          {
            'id': '1',
            'name': 'Restaurant 1',
            'description': 'Description 1',
            'pictureId': 'pic1',
            'city': 'City 1',
            'rating': 4.5,
          },
          {
            'id': '2',
            'name': 'Restaurant 2',
            'description': 'Description 2',
            'pictureId': 'pic2',
            'city': 'City 2',
            'rating': 3.8,
          },
        ],
      };

      final model = RestaurantAppModel.fromJson(jsonMap);

      expect(model.error, false);
      expect(model.message, 'Success');
      expect(model.count, 2);
      expect(model.restaurants, hasLength(2));
      expect(model.restaurants[0].name, 'Restaurant 1');
      expect(model.restaurants[1].city, 'City 2');
    });

    test('toJson converts a RestaurantAppModel object to a JSON map', () {
      final model = RestaurantAppModel(
        error: false,
        message: 'Success',
        count: 2,
        restaurants: [
          Restaurant(
            id: '1',
            name: 'Restaurant 1',
            description: 'Description 1',
            pictureId: 'pic1',
            city: 'City 1',
            rating: 4.5,
          ),
          Restaurant(
            id: '2',
            name: 'Restaurant 2',
            description: 'Description 2',
            pictureId: 'pic2',
            city: 'City 2',
            rating: 3.8,
          ),
        ],
      );

      final jsonMap = model.toJson();

      expect(jsonMap['error'], false);
      expect(jsonMap['message'], 'Success');
      expect(jsonMap['count'], 2);
      expect(jsonMap['restaurants'], hasLength(2));
      expect(jsonMap['restaurants'][0]['name'], 'Restaurant 1');
      expect(jsonMap['restaurants'][1]['city'], 'City 2');
    });
  });

  group('Restaurant', () {
    test('fromJson creates a valid Restaurant object', () {
      final jsonMap = {
        'id': '1',
        'name': 'Restaurant 1',
        'description': 'Description 1',
        'pictureId': 'pic1',
        'city': 'City 1',
        'rating': 4.5,
      };

      final restaurant = Restaurant.fromJson(jsonMap);

      expect(restaurant.id, '1');
      expect(restaurant.name, 'Restaurant 1');
      expect(restaurant.description, 'Description 1');
      expect(restaurant.pictureId, 'pic1');
      expect(restaurant.city, 'City 1');
      expect(restaurant.rating, 4.5);
    });

    test('toJson converts a Restaurant object to a JSON map', () {
      final restaurant = Restaurant(
        id: '1',
        name: 'Restaurant 1',
        description: 'Description 1',
        pictureId: 'pic1',
        city: 'City 1',
        rating: 4.5,
      );

      final jsonMap = restaurant.toJson();

      expect(jsonMap['id'], '1');
      expect(jsonMap['name'], 'Restaurant 1');
      expect(jsonMap['description'], 'Description 1');
      expect(jsonMap['pictureId'], 'pic1');
      expect(jsonMap['city'], 'City 1');
      expect(jsonMap['rating'], 4.5);
    });
  });
}
