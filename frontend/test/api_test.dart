import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurantapp/core/api/api_client.dart';
import 'package:restaurantapp/core/datasource/restaurant_datasource.dart';
import 'package:restaurantapp/entity/models/restaurant.dart';
import 'package:restaurantapp/entity/models/restaurant_details.dart';
import 'package:restaurantapp/entity/models/review.dart';
import 'package:restaurantapp/utils/settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'mock_api_client.mocks.dart';

void main() {
  late RestaurantDataSource dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();

    ApiClient.shared.dio = mockDio;

    dataSource = RestaurantDataSource();
  });

  group('RestaurantDataSource Tests', () {
    test('getRestaurantList returns a list of restaurants', () async {
      final mockResponse = Response(
        data: {
          'data': [
            {'id': 1, 'name': 'Test Restaurant', 'location': 'Test Location'},
          ],
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get('${AppSettings.BASE_URL}${AppSettings.GET_RESTAURANTS}'))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getRestaurantList();

      expect(result, isA<List<Restaurant>>());
      expect(result.first.name, 'Test Restaurant');
    });

    test('getRestaurantDetails returns restaurant details', () async {
      final mockResponse = Response(
        data: {
          'data': {'id': 1, 'name': 'Test Restaurant', 'location': 'Test Location'}
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get('${AppSettings.BASE_URL}${AppSettings.GET_RESTAURANT}1'))
          .thenAnswer((_) async => mockResponse);

      final result = await dataSource.getRestaurantDetails(id: 1);

      expect(result, isA<RestaurantDetails>());
      expect(result.name, 'Test Restaurant');
    });

    test('addReview returns true on success', () async {
      final review = Review(
        rating: 5,
        user: 'Test User',
        comment: 'Great food!',
      );
      final mockResponse = Response(
        data: {'success': true},
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.post(
        '${AppSettings.BASE_URL}${AppSettings.ADD_REVIEW(1)}',
        data: {
          'rating': review.rating,
          'user_name': review.user,
          'comment': review.comment,
        },
      )).thenAnswer((_) async => mockResponse);

      final result = await dataSource.addReview(review: review, id: 1);

      expect(result, true);
    });
  });
}
