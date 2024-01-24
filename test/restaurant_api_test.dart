import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/service/constants.dart';
import 'package:restaurant_app/common/service/endpoint.dart';
import 'package:restaurant_app/screens/homepage/models/restaurantmodels.dart';
import 'package:restaurant_app/screens/homepage/view_model/homepage_viewmodel.dart';

class MockApiService extends Mock implements EndPoint {
  @override
  Future<RestaurantAppModel> fetchRestaurantList() async {
    return RestaurantAppModel(
      error: false,
      message: 'Mock data',
      count: 2,
      restaurants: [
        Restaurant(
          id: '1',
          name: 'Mock Restaurant 1',
          description: 'Description 1',
          pictureId: 'picture_1',
          city: 'City 1',
          rating: 4.5,
        ),
        Restaurant(
          id: '2',
          name: 'Mock Restaurant 2',
          description: 'Description 2',
          pictureId: 'picture_2',
          city: 'City 2',
          rating: 4.0,
        ),
      ],
    );
  }
}

void main() {
  group('HomepageRestaurantViewModel Tests', () {
    late HomepageRestaurantViewModel viewModel;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      viewModel = HomepageRestaurantViewModel(apiService: mockApiService);
    });

    test('fetchRestaurantLists returns data on success', () async {
      // Arrange
      final mockResult = RestaurantAppModel(
        error: false,
        message: 'Success',
        count: 2,
        restaurants: [
          Restaurant(
            id: '1',
            name: 'Restaurant A',
            description: 'Description A',
            pictureId: 'picture_A',
            city: 'City A',
            rating: 4.5,
          ),
          Restaurant(
            id: '2',
            name: 'Restaurant B',
            description: 'Description B',
            pictureId: 'picture_B',
            city: 'City B',
            rating: 4.0,
          ),
        ],
      );

      when(mockApiService.fetchRestaurantList())
          .thenAnswer((_) async => mockResult);

      // Act
      await viewModel.fetchRestaurantLists();

      // Assert
      expect(viewModel.state, ResultState.hasData);
      expect(viewModel.restaurantAppModel, mockResult);
    });

    test('fetchRestaurantLists sets state to noData when result is empty',
        () async {
      // Arrange
      final mockResult = RestaurantAppModel(
        error: false,
        message: 'Success',
        count: 0,
        restaurants: [],
      );

      when(mockApiService.fetchRestaurantList())
          .thenAnswer((_) async => mockResult);

      // Act
      await viewModel.fetchRestaurantLists();

      // Assert
      expect(viewModel.state, ResultState.noData);
      expect(viewModel.message, 'Empty Data');
    });

    test('fetchRestaurantLists sets state to failure on error', () async {
      // Arrange
      when(mockApiService.fetchRestaurantList()).thenThrow(Exception());

      // Act
      await viewModel.fetchRestaurantLists();

      // Assert
      expect(viewModel.state, ResultState.failure);
    });
  });
}
